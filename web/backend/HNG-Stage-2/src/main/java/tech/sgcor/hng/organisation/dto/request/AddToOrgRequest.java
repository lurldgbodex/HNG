package tech.sgcor.hng.organisation.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class AddToOrgRequest {
    @NotBlank(message = "userId is required")
    private String userId;
}
