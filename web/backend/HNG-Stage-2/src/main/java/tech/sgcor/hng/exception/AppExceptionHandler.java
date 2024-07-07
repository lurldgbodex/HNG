package tech.sgcor.hng.exception;

import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.ArrayList;
import java.util.List;

@RestControllerAdvice
public class AppExceptionHandler {
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.UNPROCESSABLE_ENTITY)
    public ValidationException handleValidationError(MethodArgumentNotValidException ex) {
        List<ValidationField> errors = new ArrayList<>();
        for (FieldError error: ex.getBindingResult().getFieldErrors()) {
            ValidationField field = ValidationField.builder()
                    .field(error.getField())
                    .message(error.getDefaultMessage())
                    .build();
            errors.add(field);
        }
        return new ValidationException(errors);
    }

    @ExceptionHandler(BadRequestException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public CustomError handleBadRequest(BadRequestException ex) {
        return new CustomError("Bad request", ex.getMessage(), 400);
    }

    @ExceptionHandler(UnauthorizedException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public CustomError handleUnauthorized(UnauthorizedException ex) {
        return new CustomError("Bad request", ex.getMessage(), 401);
    }

    @ExceptionHandler(ForbiddenException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public CustomError handleForbidden(ForbiddenException ex) {
        return new CustomError("Forbidden", ex.getMessage(), 403);
    }
}
