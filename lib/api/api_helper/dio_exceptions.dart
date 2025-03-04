import 'package:dio/dio.dart';
import 'package:public_housing/api/provider/status_objects.dart';

Failure createFailure(DioException e) {
  String errorMessage = "An unknown error occurred";

  if (e.response != null) {
    if (e.response!.data is Map<String, dynamic> &&
        e.response!.data.containsKey("message")) {
      errorMessage = e.response!.data["message"].toString();
    } else if (e.response!.statusMessage != null) {
      errorMessage = e.response!.statusMessage!;
    } else {
      errorMessage = "Server error: ${e.response!.statusCode}";
    }
  } else if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout) {
    errorMessage = "Connection timeout, Please try again.";
  } else if (e.type == DioExceptionType.connectionError) {
    errorMessage = "No internet connection. Please check your network.";
  } else if (e.type == DioExceptionType.cancel) {
    errorMessage = "Request was cancelled.";
  } else {
    errorMessage = e.message ?? "Something went wrong.";
  }

  return Failure(errorMessage: errorMessage);
}
