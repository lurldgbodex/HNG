package hng13_stage0.dto;

import lombok.Builder;

@Builder
public record ProfileResponse(
        String status,
        UserData user,
        String timestamp,
        String fact
) {}
