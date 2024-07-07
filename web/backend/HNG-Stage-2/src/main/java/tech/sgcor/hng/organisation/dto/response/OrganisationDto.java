package tech.sgcor.hng.organisation.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class OrganisationDto {
    List<OrgData> organisations;
}
