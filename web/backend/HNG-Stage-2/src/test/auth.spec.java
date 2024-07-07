package tech.sgcor.hng.user.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import tech.sgcor.hng.config.JwtService;
import tech.sgcor.hng.exception.BadRequestException;
import tech.sgcor.hng.exception.UnauthorizedException;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.organisation.repository.OrganisationRepository;
import tech.sgcor.hng.user.dto.request.AuthRequest;
import tech.sgcor.hng.user.dto.request.CreateUserRequest;
import tech.sgcor.hng.user.dto.response.UserResponse;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthServiceTest {
    @Mock
    private AuthenticationManager authManager;
    @Mock
    private PasswordEncoder passwordEncoder;
    @Mock
    private UserRepository userRepository;
    @Mock
    private OrganisationRepository organisationRepository;
    @Mock
    private SecurityContext securityContext;
    @Mock
    private Authentication authentication;
    @Mock
    private JwtService jwtService;
    @InjectMocks
    private AuthService underTest;

    private User customUser;

    @BeforeEach
    void setUp() {
        SecurityContextHolder.setContext(securityContext);

        customUser = User.builder()
                .userId(10L)
                .email("test@user.com")
                .password("encoded-password")
                .firstName("test")
                .lastName("user")
                .phone("8398")
                .build();
    }

    @Test
    void shouldRegisterUserTest() {
        CreateUserRequest request = CreateUserRequest.builder()
                .email(customUser.getEmail())
                .firstName(customUser.getFirstName())
                .lastName(customUser.getLastName())
                .password("password")
                .build();
        when(passwordEncoder.encode("password")).thenReturn("encoded-password");
        when(organisationRepository.save(any())).thenReturn(new Organisation());
        when(jwtService.generateToken(any())).thenReturn("dummy-token");
        when(userRepository.saveAndFlush(any())).then(invocation -> {
            User user = invocation.getArgument(0);
            user.setUserId(10L);
            user.setEmail(customUser.getEmail());
            user.setFirstName(customUser.getFirstName());
            user.setLastName(customUser.getLastName());
            return user;
        });

        UserResponse res = underTest.registerUser(request);

        ArgumentCaptor<User> userArgumentCaptor = ArgumentCaptor.forClass(User.class);
        verify(userRepository).saveAndFlush(userArgumentCaptor.capture());
        User capturedUser = userArgumentCaptor.getValue();

        assertThat(capturedUser.getUserId()).isEqualTo(customUser.getUserId());
        assertThat(capturedUser.getFirstName()).isEqualTo(request.getFirstName());
        assertThat(capturedUser.getPassword()).isEqualTo("encoded-password");
        assertThat(capturedUser.getLastName()).isEqualTo(request.getLastName());
        assertThat(capturedUser.getEmail()).isEqualTo(request.getEmail());
        assertThat(capturedUser.getRole()).isEqualTo(Role.USER);

        assertThat(res.status()).isEqualTo("success");
        assertThat(res.message()).isEqualTo("Registration successful");
        assertThat(res.data()).hasFieldOrPropertyWithValue("accessToken", "dummy-token");
        assertThat(res.data().user()).isNotNull();
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("userId", customUser.getUserId().toString());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("firstName", request.getFirstName());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("lastName", request.getLastName());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("email", request.getEmail());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("phone", null);
    }

    @Test
    void shouldNotCreateUserIfEmailAlreadyExists() {
        CreateUserRequest request = CreateUserRequest.builder()
                .email("test@user.com")
                .build();

        when(userRepository.findByEmail(request.getEmail())).thenReturn(Optional.of(customUser));
        assertThatThrownBy(() -> underTest.registerUser(request))
                .isInstanceOf(BadRequestException.class)
                .hasMessageContaining("Registration unsuccessful");
    }

    @Test
    void shouldAuthenticateUserTest() {
        AuthRequest request = AuthRequest.builder()
                .email("test@user.com")
                .password("password")
                .build();

        when(userRepository.findByEmail(request.getEmail())).thenReturn(Optional.of(customUser));
        when(jwtService.generateToken(any())).thenReturn("dummy-token");
        when(passwordEncoder.matches(request.getPassword(), customUser.getPassword())).thenReturn(true);

        UserResponse res = underTest.authenticate(request);

        assertThat(res.status()).isEqualTo("success");
        assertThat(res.message()).isEqualTo("Login successful");
        assertThat(res.data()).hasFieldOrPropertyWithValue("accessToken", "dummy-token");
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("userId", customUser.getUserId().toString());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("firstName", customUser.getFirstName());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("lastName", customUser.getLastName());
        assertThat(res.data().user()).hasFieldOrPropertyWithValue("phone", customUser.getPhone());
    }

    @Test
    void shouldNotAuthenticateUserWithBadCredential() {
        AuthRequest request = AuthRequest.builder()
                .email(customUser.getEmail())
                .password("invalid-password")
                .build();

        when(userRepository.findByEmail(request.getEmail())).thenReturn(Optional.of(customUser));

        assertThatThrownBy(() -> underTest.authenticate(request))
                .isInstanceOf(UnauthorizedException.class)
                .hasMessageContaining("Authentication failed");
    }

    @Test
    void shouldGetAuthenticatedUserTest() {
        User user = new User();
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);

        User authUser = AuthService.getAuthenticatedUser();

        assertThat(user).isEqualTo(authUser);
    }

    @Test
    void shouldThrowExceptionWhenNoAuthentication() {
        when(securityContext.getAuthentication()).thenReturn(null);

        assertThatThrownBy(AuthService::getAuthenticatedUser)
                .isInstanceOf(UnauthorizedException.class)
                .hasMessageContaining("Client error");
    }

    @Test
    void shouldThrowExceptionWhenPrincipalIsNotUser() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn("not a user");

        assertThatThrownBy(AuthService::getAuthenticatedUser)
                .isInstanceOf(UnauthorizedException.class)
                .hasMessageContaining("Client error");
    }
}