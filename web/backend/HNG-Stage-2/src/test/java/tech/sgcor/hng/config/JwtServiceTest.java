package tech.sgcor.hng.config;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UserDetails;

import javax.crypto.SecretKey;

import java.util.Date;
import java.util.concurrent.TimeUnit;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class JwtServiceTest {
    @Mock
    private UserDetails userDetails;
    @InjectMocks
    private JwtService underTest;

    private SecretKey signingKey;

    @BeforeEach
    void setUp() {
        String testSecret = "my-very-very-very-very-very-very-secret-key-for-jwt-signing-my-very-secret-key-for-jwt-signing";
        byte[] keyInBytes = Decoders.BASE64URL.decode(testSecret);
        signingKey = Keys.hmacShaKeyFor(keyInBytes);
        underTest.secret = testSecret;
    }
    @Test
    void shouldGenerateToken() {
        when(userDetails.getUsername()).thenReturn("test@user.com");
        String token = underTest.generateToken(userDetails);

        assertThat(token).isNotNull();
    }

    @Test
    void shouldExtractUserEmail() {
        when(userDetails.getUsername()).thenReturn("test@user.com");
        String token = underTest.generateToken(userDetails);

        String userEmail = underTest.extractUserEmail(token);
        assertThat(userEmail).isEqualTo("test@user.com");
    }

    @Test
    void shouldValidateToke() {
        when(userDetails.getUsername()).thenReturn("test@user.com");
        String token = underTest.generateToken(userDetails);

        boolean isValid = underTest.isTokenValid(token, userDetails);

        assertThat(isValid).isTrue();
    }

    @Test
    void shouldDetectExpiredToken() {
        String expiredToken = Jwts.builder()
                .subject("test@user.com")
                .expiration(new Date(System.currentTimeMillis() - TimeUnit.HOURS.toMillis(1)))
                .signWith(signingKey)
                .compact();

        assertThatThrownBy(() -> underTest.isTokenExpired(expiredToken))
                .isInstanceOf(ExpiredJwtException.class);
    }
}