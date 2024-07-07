package tech.sgcor.hng.organisation.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tech.sgcor.hng.exception.BadRequestException;
import tech.sgcor.hng.exception.ForbiddenException;
import tech.sgcor.hng.organisation.dto.request.AddToOrgRequest;
import tech.sgcor.hng.organisation.dto.request.CreateOrgRequest;
import tech.sgcor.hng.organisation.dto.response.*;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.organisation.repository.OrganisationRepository;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;
import tech.sgcor.hng.user.service.AuthService;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
@RequiredArgsConstructor
public class OrganisationService {
    private final OrganisationRepository organisationRepository;
    private final UserRepository userRepository;

    public GetOrganisation createOrganisation(CreateOrgRequest request) {
        // get authenticated user
        User authUser = AuthService.getAuthenticatedUser();

        Set<User> users = new HashSet<>();
        users.add(authUser);

        // create a new organisation
        Organisation organisation = Organisation.builder()
                .name(request.getName())
                .description(request.getDescription())
                .users(users)
                .build();

        organisationRepository.saveAndFlush(organisation);
        authUser.getOrganisations().add(organisation);
        userRepository.save(authUser);

        // map organisation details to dto and return response
        OrgData data = OrgData.builder()
                .orgId(organisation.getOrgId().toString())
                .name(organisation.getName())
                .description(organisation.getDescription())
                .build();

        return new GetOrganisation("success", "Organisation created successfully", data);
    }

    public OrganisationResponse getAllUserOrganisation() {
        // get authenticate user
        User authUser = AuthService.getAuthenticatedUser();

        // get list of organisations the user belongs
        List<Organisation> listOfOrg = organisationRepository
                .findAllByUser(authUser.getUserId());

        // map the organisation to dto and return
        List<OrgData> data = listOfOrg.stream().map((org) -> OrgData.builder()
                .orgId(org.getOrgId().toString())
                .name(org.getName())
                .description(org.getDescription())
                .build()).toList();

        OrganisationDto orgData = OrganisationDto.builder()
                .organisations(data).build();

        return new OrganisationResponse("success", "list of organisations", orgData);
    }

    public GetOrganisation getOrganisationById(String reqId) {
        // get authenticated user
        User authUser = AuthService.getAuthenticatedUser();

        // convert the orgId to long and handle potential exception
        try {
            Long orgId = Long.parseLong(reqId);

            Organisation organisation = organisationRepository.findById(orgId)
                    .orElseThrow(() -> new BadRequestException("Client error"));

            if (organisation.getUsers().contains(authUser)) {
                OrgData data = OrgData.builder()
                        .orgId(organisation.getOrgId().toString())
                        .name(organisation.getName())
                        .description(organisation.getDescription())
                        .build();

                return new GetOrganisation("success", "organisation retrieved", data);
            } else throw new ForbiddenException("you cannot access resource");
        } catch (NumberFormatException nfe) {
            throw new BadRequestException("Client error");
        }
    }

    public AddToOrgRes addUserToOrganisation(AddToOrgRequest req, String orgId) {
        User authUser = AuthService.getAuthenticatedUser();

        try {
            long id = Long.parseLong(orgId);
            long userId = Long.parseLong(req.getUserId());

            Organisation organisation = organisationRepository.findById(id)
                    .orElseThrow(() -> new BadRequestException("Client error"));

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new BadRequestException("Client error"));

            if (organisation.getUsers().contains(authUser)) {
                organisation.getUsers().add(user);
                organisationRepository.save(organisation);
                user.getOrganisations().add(organisation);
                userRepository.save(user);
                return new AddToOrgRes("success", "User added to organisation successfully");
            } else throw new ForbiddenException("you cannot access resource");
        } catch (NumberFormatException nfe) {
            throw new BadRequestException("Client error");
        }
    }
}
