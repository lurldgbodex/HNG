package tech.sgcor.hng.user.controller;

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
import tech.sgcor.hng.user.dto.response.GetUser;
import tech.sgcor.hng.user.dto.response.UserDto;
import tech.sgcor.hng.user.service.UserService;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
@AutoConfigureMockMvc(addFilters = false)
@ExtendWith(MockitoExtension.class)
class UserControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private UserService userService;
    @MockBean
    private JwtService jwtService;

    @Test
    void shouldCreateMockMvc() {
        assertThat(mockMvc).isNotNull();
    }

    @Test
    void shouldGetUserDetailsTest() throws Exception {
        UserDto data = UserDto.builder()
                .userId("10")
                .email("test@user.com")
                .firstName("test")
                .lastName("user")
                .phone("888")
                .build();

        GetUser response = new GetUser("success", "user data", data);

        when(userService.getUserById("10")).thenReturn(response);
        mockMvc.perform(get("/api/users/10"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.status").value(response.status()))
                .andExpect(jsonPath("$.message").value(response.message()))
                .andExpect(jsonPath("$.data.userId").value(response.data().getUserId()))
                .andExpect(jsonPath("$.data.firstName").value(response.data().getFirstName()))
                .andExpect(jsonPath("$.data.lastName").value(response.data().getLastName()))
                .andExpect(jsonPath("$.data.phone").value(response.data().getPhone()));
    }
}