package tech.sgcor.hng.exception;

public record CustomError(String status, String message, int statusCode) {
}
