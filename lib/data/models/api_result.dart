abstract class ApiResult {}

class SuccessResult extends ApiResult {
  final dynamic data;
  SuccessResult({this.data});
}

class FailedResult extends ApiResult {
  final String message;
  FailedResult({required this.message});
}

class ErrorResult extends ApiResult {
  final String message;
  ErrorResult({required this.message});
}

class EmptyResult extends ApiResult {}
