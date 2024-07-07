package tech.sgcor.hng.user.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.user.dto.response.GetUser;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {
    @Mock
    private UserRepository userRepository;
    @Mock
    private SecurityContext securityContext;
    @Mock
    private Authentication authentication;
    @InjectMocks
    private UserService underTest;

    @BeforeEach
    void setUp() {
        SecurityContextHolder.setContext(securityContext);
    }

    @Test
    void shouldGetUserById() {
        User user = User.builder()
                .userId(10L)
                .firstName("test")
                .lastName("user")
                .email("test@user.ocm")
                .role(Role.USER)
                .password("encoded-password")
                .organisations(Set.of(new Organisation()))
                .build();
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);
        when(userRepository.findById(user.getUserId())).thenReturn(Optional.of(user));

        GetUser res = underTest.getUserById(user.getUserId().toString());

        assertThat(res.status()).isEqualTo("success");
        assertThat(res.message()).isEqualTo("user data");
        assertThat(res.data().getUserId()).isEqualTo(user.getUserId().toString());
        assertThat(res.data().getFirstName()).isEqualTo(user.getFirstName());
        assertThat(res.data().getLastName()).isEqualTo(user.getLastName());
        assertThat(res.data().getEmail()).isEqualTo(user.getEmail());
        assertThat(res.data().getPhone()).isEqualTo(user.getPhone());
    }


}