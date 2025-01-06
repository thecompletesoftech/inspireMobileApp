import 'package:public_housing/api/api_helper/api_base_helper.dart';
import 'package:public_housing/commons/all.dart';

class ApiBaseHelperImplementation extends ApiBaseHelper {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: '${Constants.baseUrl}'
          '${GetStorageData().readString(GetStorageData().baseURL)}',
      followRedirects: true));

  final Dio _dio1 = Dio(BaseOptions(
      baseUrl: '${Constants.baseUrl}'
          // '31f6-45-249-10-232.ngrok-free.app',
          '0f06-39-62-199-73.ngrok-free.app',
      followRedirects: true));

  @override
  Future<dynamic> get(
      {String? endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter,
      bool isTrue = false}) async {
    final Response response = isTrue
        ? await _dio1.get(
            endPoint!,
            queryParameters: queryParameter ?? {},
            options: Options(headers: headers ?? {}),
          )
        : await _dio.get(
            endPoint!,
            queryParameters: queryParameter ?? {},
            options: Options(headers: headers ?? {}),
          );

    return response.data is String ? response : response;
  }

  @override
  Future<dynamic> download(
      {String? endPoint,
      String? path,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter}) async {
    final Response response = await Dio().download(endPoint!, path,
        queryParameters: queryParameter ?? {},
        options: Options(headers: headers ?? {}));

    /*OpenFile.open(path);*/
    return response.data is String ? response : response;
  }

  @override
  Future delete({
    body,
    String? endPoint,
    String? pathParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    String fullUrl = pathParameters == null || pathParameters.isEmpty
        ? endPoint!
        : "$endPoint/$pathParameters";
    final Response response = await _dio.delete(fullUrl,
        data: body,
        queryParameters: queryParameter ?? {},
        options: Options(headers: headers ?? {}));

    return response;
  }

  @override
  Future patch(
      {String? endPoint,
      dynamic body,
      String? pathParameter,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter}) async {
    String fullUrl = pathParameter == null || pathParameter.isEmpty
        ? endPoint!
        : "$endPoint/$pathParameter";

    final Response response = await _dio.patch(fullUrl,
        queryParameters: queryParameter ?? {},
        data: body,
        options: Options(headers: headers ?? {}));

    return response;
  }

  @override
  Future<dynamic> post(
      {String? endPoint,
      dynamic body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter,
      String? contentType}) async {
    final Response response = await _dio.post(endPoint!,
        queryParameters: queryParameter ?? {},
        data: body,
        options: Options(headers: headers ?? {}));
    print(response.statusCode.toString());
    return response;
  }

  @override
  Future put(
      {String? endPoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameter}) async {
    final Response response = await _dio.put(endPoint!,
        queryParameters: queryParameter ?? {},
        data: body,
        options: Options(headers: headers ?? {}));

    return response;
  }

  @override
  Future<dynamic> userPost({
    String? endPoint,
    Map<String, dynamic>? body,
  }) async {
    final Response response = await Dio().post(endPoint!,
        options: Options(contentType: 'application/x-www-form-urlencoded'),
        data: body);

    return response;
  }

  @override
  void cancelRequest() {}

  @override
  uploadFileToServer(
      String fileName, String directoryPath, String? authenticationToken) {
    // TODO: implement uploadFileToServer
    throw UnimplementedError();
  }

/*  @override
  uploadFileToServer(
      String fileName, String directoryPath, String? authenticationToken) {
    try {
      uploader.enqueue(
        MultipartFormDataUpload(
          url: EndPoints.baseUrl() + EndPoints.ORDER_UPLOAD,
          files: [
            FileItem(path: directoryPath, field: "order_upload[order_file]")
          ], // required: list of files that you want to upload
          method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
          headers: {"Authorization": "Bearer $authenticationToken"},
        ),
      );
    } catch (e) {
      throw getCurrentFailure(e)!;
    }
  }*/
}
