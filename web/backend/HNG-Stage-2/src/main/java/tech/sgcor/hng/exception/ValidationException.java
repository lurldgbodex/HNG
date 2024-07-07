package tech.sgcor.hng.exception;

import java.util.List;

public record ValidationException(List<ValidationField> errors) {
}
