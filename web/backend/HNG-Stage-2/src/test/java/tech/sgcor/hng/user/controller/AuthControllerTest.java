package tech.sgcor.hng.user.controller;

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
import tech.sgcor.hng.user.dto.request.AuthRequest;
import tech.sgcor.hng.user.dto.request.CreateUserRequest;
import tech.sgcor.hng.user.dto.response.ResponseData;
import tech.sgcor.hng.user.dto.response.UserDto;
import tech.sgcor.hng.user.dto.response.UserResponse;
import tech.sgcor.hng.user.service.AuthService;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(AuthController.class)
@AutoConfigureMockMvc(addFilters = false)
@ExtendWith(MockitoExtension.class)
class AuthControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private AuthService authService;
    @MockBean
    private JwtService jwtService;

    private UserResponse response;

    @Test
    void shouldCreateMockMvc() {
        assertThat(mockMvc).isNotNull();
    }

    @BeforeEach
    void setUp() {
        UserDto user = UserDto.builder()
                .firstName("test")
                .lastName("user")
                .email("test@user.com")
                .userId("3784")
                .phone("8883984")
                .build();

        ResponseData data = new ResponseData("dummy-token", user);
        response = new UserResponse("success", "Registration successful", data);
    }

    @Test
    void shouldRegisterUserTest() throws Exception {
        CreateUserRequest request = CreateUserRequest.builder()
                .firstName("test")
                .lastName("user")
                .email("test@user.com")
                .password("password")
                .phone(response.data().user().getPhone())
                .build();

        when(authService.registerUser(request)).thenReturn(response);

        ObjectMapper objectMapper = new ObjectMapper();
        String createRequest = objectMapper.writeValueAsString(request);

        mockMvc.perform(post("/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(createRequest))
                .andExpect(status().isCreated())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value(response.status()))
                .andExpect(jsonPath("$.message").value(response.message()))
                .andExpect(jsonPath("$.data.accessToken").value(response.data().accessToken()))
                .andExpect(jsonPath("$.data.user.userId").value(response.data().user().getUserId()))
                .andExpect(jsonPath("$.data.user.firstName").value(response.data().user().getFirstName()))
                .andExpect(jsonPath("$.data.user.lastName").value(response.data().user().getLastName()))
                .andExpect(jsonPath("$.data.user.email").value(response.data().user().getEmail()))
                .andExpect(jsonPath("$.data.user.phone").value(response.data().user().getPhone()));
    }

    @Test
    void shouldLoginTest() throws Exception {
        AuthRequest request = AuthRequest.builder()
                .email("test@user.com")
                .password("password")
                .build();

        when(authService.authenticate(request)).thenReturn(response);

        ObjectMapper objectMapper = new ObjectMapper();
        String requestString = objectMapper.writeValueAsString(request);

        mockMvc.perform(post("/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestString))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value(response.status()))
                .andExpect(jsonPath("$.message").value(response.message()))
                .andExpect(jsonPath("$.data.accessToken").value(response.data().accessToken()))
                .andExpect(jsonPath("$.data.user.userId").value(response.data().user().getUserId()))
                .andExpect(jsonPath("$.data.user.firstName").value(response.data().user().getFirstName()))
                .andExpect(jsonPath("$.data.user.lastName").value(response.data().user().getLastName()))
                .andExpect(jsonPath("$.data.user.email").value(response.data().user().getEmail()))
                .andExpect(jsonPath("$.data.user.phone").value(response.data().user().getPhone()));
    }
}