package tech.sgcor.hng.user;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.DirtiesContext;
import tech.sgcor.hng.config.JwtService;
import tech.sgcor.hng.exception.CustomError;
import tech.sgcor.hng.exception.ValidationException;
import tech.sgcor.hng.exception.ValidationField;
import tech.sgcor.hng.organisation.dto.response.OrganisationResponse;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.organisation.repository.OrganisationRepository;
import tech.sgcor.hng.user.dto.request.AuthRequest;
import tech.sgcor.hng.user.dto.request.CreateUserRequest;
import tech.sgcor.hng.user.dto.response.GetUser;
import tech.sgcor.hng.user.dto.response.UserResponse;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.HashSet;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@AutoConfigureTestDatabase
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class UserIntegrationTest {
    @Autowired
    private TestRestTemplate restTemplate;
    @Autowired
    private OrganisationRepository organisationRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JwtService jwtService;

    private User customUser;
    private String jwtToken;

    @BeforeEach
    void setUp() {
        Set<Organisation> orgSet = new HashSet<>();
        Organisation newOrg = Organisation.builder()
                .name("John's organisation")
                .description("John Doe's organisation")
                .users(new HashSet<>())
                .build();

        organisationRepository.save(newOrg);
        orgSet.add(newOrg);

        String hashPassword = passwordEncoder.encode("password");
        customUser = User.builder()
                .userId(1L)
                .firstName("John")
                .lastName("Doe")
                .email("John@doe.com")
                .password(hashPassword)
                .role(Role.USER)
                .phone("897374")
                .organisations(orgSet)
                .build();

        User otherUser = User.builder()
                .userId(2L)
                .firstName("Jane")
                .lastName("Doe")
                .email("jane.doe@example.com")
                .password(passwordEncoder.encode("password"))
                .build();

        userRepository.save(otherUser);
        userRepository.save(customUser);

        // generate jwt token for authUser
        jwtToken = jwtService.generateToken(customUser);
    }

    @Test
    void ShouldRegisterUserTest() {
        CreateUserRequest request = CreateUserRequest.builder()
                .firstName("test")
                .lastName("user")
                .email("test@user.com")
                .password("password")
                .phone("123")
                .build();

        // create a new user
        ResponseEntity<UserResponse> res = restTemplate.postForEntity("/auth/register", request, UserResponse.class);
        UserResponse resBody = res.getBody();

        assertThat(res.getStatusCode()).isEqualTo(HttpStatus.CREATED);

        assertThat(resBody).isNotNull();
        assertThat(resBody).hasFieldOrPropertyWithValue("status", "success");
        assertThat(resBody).hasFieldOrPropertyWithValue("message", "Registration successful");
        assertThat(resBody.data().accessToken()).isNotNull();
        assertThat(resBody.data().accessToken()).isInstanceOf(String.class);
        assertThat(resBody.data().user()).hasFieldOrProperty("userId");
        assertThat(resBody.data().user().getUserId()).isInstanceOf(String.class);
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("firstName", request.getFirstName());
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("lastName", request.getLastName());
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("email", request.getEmail());
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("phone", request.getPhone());

        // verify a default organisation was created
        ResponseEntity<OrganisationResponse> getResponse = restTemplate.getForEntity("/api/organisations", OrganisationResponse.class);
        OrganisationResponse getResBody = getResponse.getBody();

        assertThat(getResponse.getStatusCode()).isEqualTo(HttpStatus.OK);

        assertThat(getResBody).isNotNull();
        assertThat(getResBody.data().getOrganisations()).hasSize(1);
        assertThat(getResBody.data().getOrganisations().get(0)).hasFieldOrPropertyWithValue("name", "test's Organisation");
    }

    @Test
    void shouldNotRegisterUserWhenMissingFields() {
        CreateUserRequest request = CreateUserRequest.builder().build();

        ResponseEntity<ValidationException> errRes = restTemplate.postForEntity("/auth/register", request, ValidationException.class);
        ValidationException errResBody = errRes.getBody();

        ValidationField field1 = ValidationField.builder()
                .field("firstName")
                .message("firstName is required")
                .build();
        ValidationField field2 = ValidationField.builder()
                .field("lastName")
                .message("lastName is required")
                .build();
        ValidationField field3 = ValidationField.builder()
                .field("email")
                .message("email is required")
                .build();
        ValidationField field4= ValidationField.builder()
                .field("password")
                .message("password is required")
                .build();

        assertThat(errRes.getStatusCode()).isEqualTo(HttpStatus.UNPROCESSABLE_ENTITY);
        assertThat(errResBody).isNotNull();

        assertThat(errResBody.errors()).hasSize(4);
        assertThat(errResBody.errors()).contains(field1);
        assertThat(errResBody.errors()).contains(field2);
        assertThat(errResBody.errors()).contains(field3);
        assertThat(errResBody.errors()).contains(field4);
    }

    @Test
    void shouldNotRegisterWhenUserWithEmailExist() {
        CreateUserRequest request = CreateUserRequest.builder()
                .firstName("test")
                .lastName("user")
                .password("password")
                .phone("123")
                .email(customUser.getEmail())
                .build();

        ResponseEntity<CustomError> errRes = restTemplate.postForEntity("/auth/register", request, CustomError.class);
        CustomError errResBody = errRes.getBody();

        assertThat(errRes.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);

        assertThat(errResBody).isNotNull();
        assertThat(errResBody.status()).isEqualTo("Bad request");
        assertThat(errResBody.message()).isEqualTo("Registration unsuccessful");
        assertThat(errResBody.statusCode()).isEqualTo(400);
    }

    @Test
    void shouldAuthenticateUserTest() {
        AuthRequest request = AuthRequest.builder()
                .email(customUser.getEmail())
                .password("password")
                .build();

        ResponseEntity<UserResponse> res = restTemplate.postForEntity("/auth/login", request, UserResponse.class);
        UserResponse resBody = res.getBody();

        assertThat(res.getStatusCode()).isEqualTo(HttpStatus.OK);

        assertThat(resBody).isNotNull();
        assertThat(resBody).hasFieldOrPropertyWithValue("status", "success");
        assertThat(resBody).hasFieldOrPropertyWithValue("message", "Login successful");
        assertThat(resBody.data().accessToken()).isNotNull();
        assertThat(resBody.data().accessToken()).isInstanceOf(String.class);
        assertThat(resBody.data().user()).hasFieldOrProperty("userId");
        assertThat(resBody.data().user().getUserId()).isInstanceOf(String.class);
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("firstName", customUser.getFirstName());
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("lastName", customUser.getLastName());
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("email", customUser.getEmail());
        assertThat(resBody.data().user()).hasFieldOrPropertyWithValue("phone", customUser.getPhone());
    }

    @Test
    void shouldNotAuthenticateWhenMissingField() {
        AuthRequest request = AuthRequest.builder().build();

        ResponseEntity<ValidationException> errRes = restTemplate.postForEntity("/auth/login", request, ValidationException.class);
        ValidationException errResBody = errRes.getBody();

        ValidationField field1 = ValidationField.builder()
                .field("email")
                .message("email is required")
                .build();
        ValidationField field2 = ValidationField.builder()
                .field("password")
                .message("password is required")
                .build();

        assertThat(errRes.getStatusCode()).isEqualTo(HttpStatus.UNPROCESSABLE_ENTITY);
        assertThat(errResBody).isNotNull();

        assertThat(errResBody.errors()).hasSize(2);
        assertThat(errResBody.errors()).contains(field1);
        assertThat(errResBody.errors()).contains(field2);
    }

    @Test
    void shouldGetOwnDetailsById() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + jwtToken);
        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);

        ResponseEntity<GetUser> response = restTemplate.exchange("/api/users/1", HttpMethod.GET,
                requestEntity, GetUser.class);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().status()).isEqualTo("success");
        assertThat(response.getBody().message()).isEqualTo("user data");
        assertThat(response.getBody().data().getUserId()).isEqualTo("1");
        assertThat(response.getBody().data().getFirstName()).isEqualTo("John");
        assertThat(response.getBody().data().getLastName()).isEqualTo("Doe");
        assertThat(response.getBody().data().getEmail()).isEqualTo(customUser.getEmail());
    }
}
