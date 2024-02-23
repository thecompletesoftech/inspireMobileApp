abstract class ApiBaseHelper {
  Future<dynamic> get(
      {String? endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter});

  Future<dynamic> download(
      {String? endPoint,
      String? path,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter});

  Future<dynamic> post(
      {String? endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter});

  Future<dynamic> patch(
      {String? endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      String? pathParameter,
      Map<String, dynamic>? queryParameter});

  Future<dynamic> delete(
      {String? endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter,
      String? pathParameters});

  Future<dynamic> put(
      {String? endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter});

  Future<dynamic> userPost({
    String? endPoint,
    Map<String, dynamic>? body,
  });

  void cancelRequest();

  uploadFileToServer(
      String fileName, String directoryPath, String? authenticationToken);
}
