package tech.sgcor.hng.organisation.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CreateOrgRequest {
    @NotBlank
    private String name;
    private String description;
}
