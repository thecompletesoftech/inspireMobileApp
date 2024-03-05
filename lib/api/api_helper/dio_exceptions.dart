import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';

Failure createFailure(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      return Failure(
          errorMessage: "Request to server was cancelled", error: '');
    case DioErrorType.connectionTimeout:
      return Failure(errorMessage: "Connection timeout with server");
    case DioErrorType.sendTimeout:
      return Failure(errorMessage: "Send timeout in connection with server");
    case DioErrorType.receiveTimeout:
      return Failure(errorMessage: "Receive timeout in connection with server");
    case DioErrorType.badResponse:
      {
        try {
          int errCode =
              error.response != null ? error.response!.statusCode! : 00;
          switch (errCode) {
            case 400:
              return Failure(errorMessage: "Request syntax error");
            case 401:
              return Failure(errorMessage: "Permission denied");
            case 403:
              return Failure(errorMessage: "Server refuses to execute");
            case 404:
              return Failure(errorMessage: "Can not reach server");
            case 405:
              return Failure(errorMessage: "Request method is forbidden");
            case 500:
              return Failure(errorMessage: "Internal server error");
            case 502:
              return Failure(errorMessage: "Invalid request");
            case 503:
              return Failure(errorMessage: "Server hangs");
            case 505:
              return Failure(
                  errorMessage: "HTTP protocol requests are not supported");
            default:
              return Failure(
                  errorMessage: error.response != null
                      ? error.response!.data!['detail']
                      : "");
          }
        } on Exception catch (_) {
          return Failure(errorMessage: "Unknown mistake");
        }
      }
    case DioErrorType.unknown:
      if (error.message != null) {
        if (error.message!.contains("SocketException")) {
          return Failure(
              errorMessage:
                  "Your internet is not available, please try again later");
        } else if (error.message!
            .contains("Software caused connection abort")) {
          return Failure(
              errorMessage:
                  "Your internet is not available, please try again later");
        }
      }
      return Failure(errorMessage: "Oops something went wrong");
    default:
      return Failure(errorMessage: "Oops something went wrong");
  }
}
