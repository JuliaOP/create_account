class ResponseData<T> {
  T? data;
  bool success;
  int httpCode;
  String httpStatusMessage;
  String errorCode;
  String errorMessage;

  ResponseData(
      {data,
      required success,
      required httpCode,
      required httpStatusMessage,
      errorCode = '',
      errorMessage = ''})
      : data = data,
        success = success,
        httpCode = httpCode,
        httpStatusMessage = httpStatusMessage,
        errorCode = errorCode,
        errorMessage = errorMessage;
}
