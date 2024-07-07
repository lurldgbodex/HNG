package tech.sgcor.hng.user.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tech.sgcor.hng.config.JwtService;
import tech.sgcor.hng.exception.BadRequestException;
import tech.sgcor.hng.exception.UnauthorizedException;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.organisation.repository.OrganisationRepository;
import tech.sgcor.hng.user.dto.request.AuthRequest;
import tech.sgcor.hng.user.dto.request.CreateUserRequest;
import tech.sgcor.hng.user.dto.response.ResponseData;
import tech.sgcor.hng.user.dto.response.UserDto;
import tech.sgcor.hng.user.dto.response.UserResponse;
import tech.sgcor.hng.user.entity.Role;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final OrganisationRepository organisationRepository;

    @Transactional
    public UserResponse registerUser(CreateUserRequest userRequest) {
        Optional<User> user = userRepository.findByEmail(userRequest.getEmail());

        if (user.isPresent()) throw new BadRequestException("Registration unsuccessful");

        String hashPassword = passwordEncoder.encode(userRequest.getPassword());

        // create a default organisation for the new user
        String orgName = userRequest.getFirstName() + "'s " + "Organisation";
        Organisation newOrganisation = Organisation.builder()
                .name(orgName).build();
        organisationRepository.save(newOrganisation);

        // create and save new user with the organisation
        User newUser = User.builder()
                .firstName(userRequest.getFirstName())
                .lastName(userRequest.getLastName())
                .email(userRequest.getEmail())
                .phone(userRequest.getPhone())
                .organisations(new HashSet<>())
                .password(hashPassword)
                .role(Role.USER)
                .build();

        newUser.getOrganisations().add(newOrganisation);
        userRepository.saveAndFlush(newUser);

        log.info("New User Id: {}", newUser.getUserId());

        String token = jwtService.generateToken(newUser);
        UserDto newUserDto = UserDto.builder()
                .userId(newUser.getUserId().toString())
                .firstName(newUser.getFirstName())
                .lastName(newUser.getLastName())
                .email(newUser.getEmail())
                .phone(newUser.getPhone())
                .build();

        ResponseData data = new ResponseData(token, newUserDto);

        return new UserResponse("success", "Registration successful", data);
    }

    @Transactional
    public UserResponse authenticate(AuthRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new UnauthorizedException("Authentication failed"));

        if (passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            String token = jwtService.generateToken(user);
            UserDto newUserDto = UserDto.builder()
                    .userId(user.getUserId().toString())
                    .firstName(user.getFirstName())
                    .lastName(user.getLastName())
                    .email(user.getEmail())
                    .phone(user.getPhone())
                    .build();

            ResponseData data = new ResponseData(token, newUserDto);

            return new UserResponse("success", "Login successful", data);
        } else throw new UnauthorizedException("Authentication failed");
    }

    public static User getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof  User) {
            return (User) authentication.getPrincipal();
        } throw new UnauthorizedException("Client error");
    }
}
