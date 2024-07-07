package tech.sgcor.hng.organisation.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import tech.sgcor.hng.exception.BadRequestException;
import tech.sgcor.hng.exception.ForbiddenException;
import tech.sgcor.hng.organisation.dto.request.AddToOrgRequest;
import tech.sgcor.hng.organisation.dto.request.CreateOrgRequest;
import tech.sgcor.hng.organisation.dto.response.*;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.organisation.repository.OrganisationRepository;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrganisationServiceTest {
    @Mock
    private OrganisationRepository organisationRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private SecurityContext securityContext;
    @Mock
    private Authentication authentication;
    @InjectMocks
    private OrganisationService underTest;

    private User user;
    private Organisation org1;
    private Organisation org2;

    @BeforeEach()
    void setUp() {
        SecurityContextHolder.setContext(securityContext);

        // create a custom user
        user = User.builder()
                .userId(10L)
                .firstName("test")
                .lastName("user")
                .email("test@user.ocm")
                .role(Role.USER)
                .password("encoded-password")
                .organisations(new HashSet<>())
                .build();

        Set<User> users = new HashSet<>();
        users.add(user);

        // create 2 custom organisations (org1 and org2)
        org1 = Organisation.builder()
                .orgId(1L)
                .name("Organisation 1")
                .description("Description 1")
                .users(users)
                .build();

        org2 = Organisation.builder()
                .orgId(2L)
                .name("Organisation 2")
                .description("Description 2")
                .users(users)
                .build();
    }

    @Test
    void shouldCreateOrganisationTest() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);

        CreateOrgRequest request = CreateOrgRequest.builder()
                .name("John's Organisation")
                .description("Organisation for John Doe")
                .build();

        when(organisationRepository.saveAndFlush(any(Organisation.class))).thenAnswer(invocation -> {
            Organisation org = invocation.getArgument(0);
            org.setOrgId(1L);
            return org;
        });

        GetOrganisation result = underTest.createOrganisation(request);

        ArgumentCaptor<Organisation> organisationCaptor = ArgumentCaptor.forClass(Organisation.class);
        verify(organisationRepository, times(1)).saveAndFlush(organisationCaptor.capture());
        Organisation savedOrg = organisationCaptor.getValue();

        assertThat(result).isNotNull();
        assertThat(result.status()).isEqualTo("success");
        assertThat(result.message()).isEqualTo("Organisation created successfully");
        assertThat(result.data()).isNotNull();
        assertThat(result.data().getOrgId()).isEqualTo("1");

        assertThat(savedOrg).isNotNull();
        assertThat(savedOrg.getName()).isEqualTo(request.getName());
        assertThat(savedOrg.getDescription()).isEqualTo(request.getDescription());
        assertThat(savedOrg.getUsers()).contains(user);
    }

    @Test
    void shouldGetAllUserOrganisation() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);
        when(organisationRepository.findAllByUser(user.getUserId())).thenReturn(List.of(org1, org2));

        OrganisationResponse response = underTest.getAllUserOrganisation();

        assertThat(response.status()).isEqualTo("success");
        assertThat(response.message()).isEqualTo("list of organisations");
        assertThat(response.data().getOrganisations()).hasSize(2);

        OrgData orgDto1 = response.data().getOrganisations().get(0);
        assertThat(orgDto1.getOrgId()).isEqualTo(org1.getOrgId().toString());
        assertThat(orgDto1.getName()).isEqualTo(org1.getName());
        assertThat(orgDto1.getDescription()).isEqualTo(org1.getDescription());

        OrgData orgDto2 = response.data().getOrganisations().get(1);
        assertThat(orgDto2.getOrgId()).isEqualTo(org2.getOrgId().toString());
        assertThat(orgDto2.getName()).isEqualTo(org2.getName());
        assertThat(orgDto2.getDescription()).isEqualTo(org2.getDescription());
    }

    @Test
    void shouldGetOrganisationById() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);
        when(organisationRepository.findById(1L)).thenReturn(Optional.ofNullable(org1));


        GetOrganisation response = underTest.getOrganisationById("1");

        assertThat(response.status()).isEqualTo("success");
        assertThat(response.message()).isEqualTo("organisation retrieved");

        OrgData orgDto = response.data();
        assertThat(orgDto.getOrgId()).isEqualTo(org1.getOrgId().toString());
        assertThat(orgDto.getName()).isEqualTo(org1.getName());
        assertThat(orgDto.getDescription()).isEqualTo(org1.getDescription());
    }

    @Test
    void shouldThrowBadRequestExceptionForInvalidFormatWhenGettingOrg() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);

        assertThatThrownBy(() -> underTest.getOrganisationById("invalid-id"))
                .isInstanceOf(BadRequestException.class)
                .hasMessageContaining("Client error");
    }

    @Test
    void shouldThrowForbiddenExceptionForUnauthorizedAccessWhenGetting() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(new User());
        when(organisationRepository.findById(1L)).thenReturn(Optional.of(org1));

        assertThatThrownBy(() -> underTest.getOrganisationById("1"))
                .isInstanceOf(ForbiddenException.class)
                .hasMessageContaining("you cannot access resource");
    }

    @Test
    void shouldAddUserToOrganisation() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);

        // user to add
        User userToAdd = User.builder()
                .userId(2L)
                .firstName("Jane")
                .lastName("Doe")
                .email("jane.doe@example.com")
                .password("encoded-password")
                .organisations(new HashSet<>())
                .role(Role.USER)
                .build();
        when(organisationRepository.findById(1L)).thenReturn(Optional.of(org1));
        when(userRepository.findById(2L)).thenReturn(Optional.of(userToAdd));

        AddToOrgRequest request = new AddToOrgRequest();
        request.setUserId("2");

        AddToOrgRes response = underTest.addUserToOrganisation(request, "1");

        // Assert
        assertThat(response.status()).isEqualTo("success");
        assertThat(response.message()).isEqualTo("User added to organisation successfully");
        assertThat(org1.getUsers()).contains(userToAdd);

    }

    @Test
    void shouldThrowBadRequestExceptionForInvalidIdFormatWhenAddingUserToOrg() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);

        AddToOrgRequest request = new AddToOrgRequest();
        request.setUserId("invalid-id");

        assertThatThrownBy(() -> underTest.addUserToOrganisation(request, "1"))
                .isInstanceOf(BadRequestException.class)
                .hasMessageContaining("Client error");
    }

    @Test
    void shouldThrowBadRequestExceptionWhenOrganisationNotFound() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);
        when(organisationRepository.findById(1L)).thenReturn(Optional.empty());

        AddToOrgRequest request = new AddToOrgRequest();
        request.setUserId("1");

        assertThatThrownBy(() -> underTest.addUserToOrganisation(request, "1"))
                .isInstanceOf(BadRequestException.class)
                .hasMessageContaining("Client error");
    }

    @Test
    void shouldThrowBadRequestExceptionWhenUserNotFound() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(user);
        when(organisationRepository.findById(1L)).thenReturn(Optional.of(org1));
        when(userRepository.findById(2L)).thenReturn(Optional.empty());

        AddToOrgRequest request = new AddToOrgRequest();
        request.setUserId("2");

        assertThatThrownBy(() -> underTest.addUserToOrganisation(request, "1"))
                .isInstanceOf(BadRequestException.class)
                .hasMessageContaining("Client error");
    }

    @Test
    void shouldThrowForbiddenExceptionForUnauthorizedAccessWhenAddingUser() {
        when(securityContext.getAuthentication()).thenReturn(authentication);
        when(authentication.getPrincipal()).thenReturn(new User());

        when(organisationRepository.findById(2L)).thenReturn(Optional.of(org2));
        when(userRepository.findById(5L)).thenReturn(Optional.of(new User()));

        AddToOrgRequest request = new AddToOrgRequest();
        request.setUserId("5");

        assertThatThrownBy(() -> underTest.addUserToOrganisation(request, "2"))
                .isInstanceOf(ForbiddenException.class)
                .hasMessageContaining("you cannot access resource");
    }
}