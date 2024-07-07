package tech.sgcor.hng.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import tech.sgcor.hng.user.entity.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String userEmail);
}
