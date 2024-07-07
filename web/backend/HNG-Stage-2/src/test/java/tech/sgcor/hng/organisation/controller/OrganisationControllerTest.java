package tech.sgcor.hng.organisation.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import tech.sgcor.hng.config.JwtService;
import tech.sgcor.hng.organisation.dto.request.AddToOrgRequest;
import tech.sgcor.hng.organisation.dto.request.CreateOrgRequest;
import tech.sgcor.hng.organisation.dto.response.*;
import tech.sgcor.hng.organisation.service.OrganisationService;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@AutoConfigureMockMvc(addFilters = false)
@WebMvcTest(OrganisationController.class)
class OrganisationControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private OrganisationService organisationService;
    @MockBean
    private JwtService jwtService;
    private OrganisationResponse response;
    private OrgData orgDto;


    @Test
    void shouldCreateMockMvc() {
        assertThat(mockMvc).isNotNull();
    }

    @BeforeEach
    void setUp() {
        orgDto = OrgData.builder()
                .orgId("1")
                .name("john's organisation")
                .description("John Doe organisation")
                .build();

        List<OrgData> orgDataLists = new ArrayList<>();
        orgDataLists.add(orgDto);

        OrganisationDto organisations = OrganisationDto.builder()
                .organisations(orgDataLists)
                .build();
        response = new OrganisationResponse("success", "operation successful", organisations);
    }

    @Test
    void shouldGetAllOrg() throws Exception {
        when(organisationService.getAllUserOrganisation()).thenReturn(response);

        mockMvc.perform(get("/api/organisations"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value(response.status()))
                .andExpect(jsonPath("$.message").value(response.message()))
                .andExpect(jsonPath("$.data.organisations").isArray());

    }

    @Test
    void shouldGetOrgById() throws Exception {
        GetOrganisation orgRes = new GetOrganisation("success", "get org", orgDto);

        when(organisationService.getOrganisationById("1")).thenReturn(orgRes);

        mockMvc.perform(get("/api/organisations/1"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value("success"))
                .andExpect(jsonPath("$.message").value("get org"))
                .andExpect(jsonPath("$.data.orgId").value(orgDto.getOrgId()))
                .andExpect(jsonPath("$.data.name").value(orgDto.getName()))
                .andExpect(jsonPath("$.data.description").value(orgDto.getDescription()));
    }

    @Test
    void shouldCreateNewOrg() throws Exception {
        CreateOrgRequest request = CreateOrgRequest.builder()
                .name("Johnny")
                .description("Springboard")
                .build();

        GetOrganisation orgRes = new GetOrganisation("success", "get org", orgDto);

        when(organisationService.createOrganisation(request)).thenReturn(orgRes);

        ObjectMapper objectMapper = new ObjectMapper();
        String requestString = objectMapper.writeValueAsString(request);

        mockMvc.perform(post("/api/organisations")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestString))
                .andExpect(status().isCreated())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value("success"))
                .andExpect(jsonPath("$.message").value("get org"))
                .andExpect(jsonPath("$.data.orgId").value(orgDto.getOrgId()))
                .andExpect(jsonPath("$.data.name").value(orgDto.getName()))
                .andExpect(jsonPath("$.data.description").value(orgDto.getDescription()));
    }

    @Test
    void shouldAddUserToOrg() throws Exception {
        AddToOrgRequest request = new AddToOrgRequest();
        request.setUserId("5");

        AddToOrgRes orgRes = new AddToOrgRes("success", "added to user");

        when(organisationService.addUserToOrganisation(request, "5")).thenReturn(orgRes);

        ObjectMapper objectMapper = new ObjectMapper();
        String requestString = objectMapper.writeValueAsString(request);

        mockMvc.perform(post("/api/organisations/5/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(requestString))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value("success"))
                .andExpect(jsonPath("$.message").value("added to user"));
    }
}