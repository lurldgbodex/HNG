package tech.sgcor.hng.organisation.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tech.sgcor.hng.organisation.dto.request.AddToOrgRequest;
import tech.sgcor.hng.organisation.dto.request.CreateOrgRequest;
import tech.sgcor.hng.organisation.dto.response.AddToOrgRes;
import tech.sgcor.hng.organisation.dto.response.GetOrganisation;
import tech.sgcor.hng.organisation.dto.response.OrganisationResponse;
import tech.sgcor.hng.organisation.service.OrganisationService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/organisations")
public class OrganisationController {
    private final OrganisationService organisationService;

    @GetMapping
    public ResponseEntity<OrganisationResponse> getAllOrg() {
        return ResponseEntity.ok(organisationService.getAllUserOrganisation());
    }

    @GetMapping("/{orgId}")
    public ResponseEntity<GetOrganisation> getOrgById(@PathVariable String orgId) {
        return ResponseEntity.ok(organisationService.getOrganisationById(orgId));
    }

    @PostMapping()
    public ResponseEntity<GetOrganisation> createNewOrg(@RequestBody @Valid CreateOrgRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(organisationService.createOrganisation(request));
    }

    @PostMapping("/{orgId}/users")
    public ResponseEntity<AddToOrgRes> addUserToOrg(@RequestBody @Valid AddToOrgRequest request, @PathVariable String orgId) {
        return ResponseEntity.ok(organisationService.addUserToOrganisation(request, orgId));
    }
}
