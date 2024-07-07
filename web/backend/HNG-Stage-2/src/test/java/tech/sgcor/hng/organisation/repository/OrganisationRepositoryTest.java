package tech.sgcor.hng.organisation.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.transaction.annotation.Transactional;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase
class OrganisationRepositoryTest {
    @Autowired
    private OrganisationRepository underTest;
    @Autowired
    private UserRepository userRepository;

    @Test
    @Transactional
    void shouldFindAllByUserTest() {
        // create organisations
        Organisation org1 = Organisation.builder().name("Org 1").build();
        Organisation org2 = Organisation.builder().name("Org 2").build();
        Organisation org3 = Organisation.builder().name("Org 3").build();
        Organisation org4 = Organisation.builder().name("Org 4").build();
        Organisation org5 = Organisation.builder().name("Org 5").build();
        Organisation org6 = Organisation.builder().name("Org 6").build();
        Organisation org7 = Organisation.builder().name("Org 7").build();
        Organisation org8 = Organisation.builder().name("Org 8").build();
        Organisation org9 = Organisation.builder().name("Org 9").build();
        Organisation org10 = Organisation.builder().name("Org 10").build();

        // save organisations
        org1 = underTest.save(org1);
        org2 = underTest.save(org2);
        org3 = underTest.save(org3);
        org4 = underTest.save(org4);
        org5 = underTest.save(org5);
        org6 = underTest.save(org6);
        org7 = underTest.save(org7);
        org8 = underTest.save(org8);
        org9 = underTest.save(org9);
        org10 = underTest.save(org10);


        // Assign organisations to users
        Set<Organisation> user1Orgs = new HashSet<>(Set.of(org1, org4, org7, org8, org9, org10));
        Set<Organisation> user2Orgs = new HashSet<>(Set.of(org2, org3, org4, org5, org6, org8, org10));

        User newUser1 = User.builder()
                .firstName("test")
                .lastName("user")
                .email("test@user.com")
                .role(Role.USER)
                .password("encoded-password")
                .organisations(user1Orgs)
                .build();

        User newUser2 = User.builder()
                .firstName("test2")
                .lastName("user2")
                .email("test@user2.com")
                .role(Role.USER)
                .password("encoded-password")
                .organisations(user2Orgs)
                .build();

        // Save users
        newUser1 = userRepository.saveAndFlush(newUser1);
        newUser2 = userRepository.saveAndFlush(newUser2);

        // Verify the organizations are saved properly
        List<Organisation> user1Org = underTest.findAllByUser(newUser1.getUserId());
        List<Organisation> user2Org = underTest.findAllByUser(newUser2.getUserId());

        assertThat(user1Org).hasSize(6);
        assertThat(user2Org).hasSize(7);
    }
}