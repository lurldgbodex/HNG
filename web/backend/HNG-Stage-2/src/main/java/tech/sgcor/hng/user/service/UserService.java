package tech.sgcor.hng.user.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import tech.sgcor.hng.exception.BadRequestException;
import tech.sgcor.hng.exception.ForbiddenException;
import tech.sgcor.hng.organisation.entity.Organisation;
import tech.sgcor.hng.user.dto.response.GetUser;
import tech.sgcor.hng.user.dto.response.UserDto;
import tech.sgcor.hng.user.entity.User;
import tech.sgcor.hng.user.repository.UserRepository;

import java.util.Set;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public GetUser getUserById(String id) {
        User authUser = AuthService.getAuthenticatedUser();

        try {
            Long userId = Long.parseLong(id);
            User otherUser = userRepository.findById(userId)
                    .orElseThrow(() -> new BadRequestException("Bad request"));

            // allow user data retrieval if user in authUser organisation
            boolean inSameOrganisation = authUser.getOrganisations().stream()
                    .anyMatch(org -> otherUser.getOrganisations().contains(org));

            if (authUser.getUserId().equals(userId) || inSameOrganisation) {
                UserDto data = UserDto.builder()
                        .firstName(otherUser.getFirstName())
                        .lastName(otherUser.getLastName())
                        .userId(otherUser.getUserId().toString())
                        .email(otherUser.getEmail())
                        .phone(otherUser.getPhone())
                        .build();

                return new GetUser("success", "user data", data);
            } else throw new ForbiddenException("you cannot access resource");
        } catch (NumberFormatException nfe) {
            throw new BadRequestException("Id must be parsable to number");
        }
    }
}
