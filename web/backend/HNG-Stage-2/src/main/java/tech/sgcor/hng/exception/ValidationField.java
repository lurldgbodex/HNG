package tech.sgcor.hng.exception;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ValidationField {
    private String field;
    private String message;
}
