package tech.sgcor.hng.organisation.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OrgData {
    private String orgId;
    private String name;
    private String description;
}
