class AppExcetion implements Exception {
  
  final _message;
  final _prefix;

  AppExcetion([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }

}

class FetchDataException extends AppExcetion {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
  
}

class BadRequestException extends AppExcetion {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppExcetion {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppExcetion {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class NoInternetException extends AppExcetion {
  NoInternetException([String? message]) : super(message, "No Internet: ");
}

class NoServiceFoundException extends AppExcetion {
  NoServiceFoundException([String? message]) : super(message, "No Service Found: ");
}

class InvalidFormatException extends AppExcetion {
  InvalidFormatException([String? message]) : super(message, "Invalid Format: ");
}

class UnknownException extends AppExcetion {
  UnknownException([String? message]) : super(message, "Unknown Error: ");
}

class NoDataException extends AppExcetion {
  NoDataException([String? message]) : super(message, "No Data: ");
}