/// Base class for application exceptions
abstract class ApiException implements Exception {
  final dynamic _error;
  final String? _prefix;

  ApiException([this._error, this._prefix]);

  Map<String, dynamic>? toMap() {
    return {
      "error": "$_prefix$_error",
      "object": _error,
    };
  }
}

/// Default HTTP exception for undefined status error
class FetchDataException extends ApiException {
  FetchDataException(dynamic error)
      : super(error, "[ERROR] Error During Communication: ");
}

/// HTTP exception for error status 400
class BadRequestException extends ApiException {
  BadRequestException(dynamic error) : super(error, "[ERROR] Invalid Request: ");
}

/// HTTP exception for error status 401
class UnauthorizedException extends ApiException {
  UnauthorizedException(dynamic error) : super(error, "[ERROR] Unauthorized: ");
}

/// HTTP exception for error status 403
class ForbiddenException extends ApiException {
  ForbiddenException(dynamic error) : super(error, "[ERROR] Forbidden: ");
}

/// Exception for wrong input in forms
class InvalidInputException extends ApiException {
  InvalidInputException(dynamic error) : super(error, "[ERROR] Invalid Input: ");
}

/// HTTP exception for error status 504 and request timeout
class TimeoutException extends ApiException {
  TimeoutException(dynamic error) : super(error, "[ERROR] Connection Timeout: ");
}

/// HTTP exception for error status 503
class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException(dynamic error)
      : super(error, "[ERROR] Service Unavailable : ");
}

/// HTTP exception for error status 404
class NotFoundException extends ApiException {
  NotFoundException(dynamic error) : super(error, "[ERROR] Not Found: ");
}

/// HTTP exception for error status 500
class InternalServerErrorException extends ApiException {
  InternalServerErrorException(dynamic error)
      : super(error, "[ERROR] Internal Server Error: ");
}