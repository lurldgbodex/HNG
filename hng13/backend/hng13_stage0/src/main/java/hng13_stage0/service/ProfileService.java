package hng13_stage0.service;

import hng13_stage0.dto.FactResponse;
import hng13_stage0.dto.ProfileResponse;
import hng13_stage0.dto.UserData;
import hng13_stage0.exception.ApiException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.Instant;

@Service
@RequiredArgsConstructor
public class ProfileService {

    private final RestTemplate restTemplate;

    @Value("${user.email}")
    private String email;

    @Value("${user.name}")
    private String name;

    @Value("${user.stack}")
    private String stack;

    public ProfileResponse getProfile() {
        UserData data = getUserData();

        String timeStamp = Instant.now().toString();
        String fact = fetchFact();

        return ProfileResponse.builder()
                .status("success")
                .user(data)
                .timestamp(timeStamp)
                .fact(fact)
                .build();
    }

    private UserData getUserData() {
        return UserData.builder()
                .email(email)
                .name(name)
                .stack(stack)
                .build();
    }

    private String fetchFact() {
        try {
            FactResponse response = restTemplate.getForObject("https://catfact.ninja/fact", FactResponse.class);

            if (response == null) {
                throw new ApiException("failed to fetch fact response");
            }

            if (response.fact().isEmpty()) {
                throw new ApiException("fact response is empty");
            }

            return response.fact();
        } catch (Exception ex) {
            throw new ApiException("Error fetching fact response: " + ex.getMessage());
        }
    }
}
