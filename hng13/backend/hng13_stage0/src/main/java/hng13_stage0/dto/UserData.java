package hng13_stage0.dto;

import lombok.Builder;

@Builder
public record UserData(String email, String name, String stack) {
}
