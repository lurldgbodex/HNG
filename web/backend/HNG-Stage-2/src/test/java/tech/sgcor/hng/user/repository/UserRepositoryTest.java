package tech.sgcor.hng.user.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase
class UserRepositoryTest {
    @Autowired
    private UserRepository underTest;

    @Test
    void shouldFindByEmailTest() {
        User newUser = User.builder()
                .firstName("test")
                .lastName("user")
                .email("test@user.com")
                .role(Role.USER)
                .password("encoded-password")
                .build();

        underTest.saveAndFlush(newUser);

        Optional<User> response = underTest.findByEmail("test@user.com");
        assertThat(response).isPresent();
        assertThat(response).contains(newUser);
    }

    @Test
    void shouldNotFindByEmailIfUserDoesNotExist() {
        Optional<User> response = underTest.findByEmail("invalid@user.com");
        assertThat(response).isEmpty();
    }
}