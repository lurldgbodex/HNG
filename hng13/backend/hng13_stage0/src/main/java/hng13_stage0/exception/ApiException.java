package hng13_stage0.exception;

public class ApiException extends RuntimeException {

    public ApiException(String message) {
        super(message);
    }
}
