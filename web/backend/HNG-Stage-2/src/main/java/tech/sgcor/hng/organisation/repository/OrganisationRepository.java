package tech.sgcor.hng.organisation.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import tech.sgcor.hng.organisation.entity.Organisation;

import java.util.List;

public interface OrganisationRepository extends JpaRepository<Organisation, Long> {
    @Query("SELECT o FROM Organisation o JOIN FETCH o.users u WHERE u.userId = :userId")
    List<Organisation> findAllByUser(@Param("userId") Long userId);
}
