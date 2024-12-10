
import 'package:dio/dio.dart';
import 'package:ilham_kata_data_test/module/shareds/exception.dart';

class DioClient {
  final Dio dio;
  final String baseUrl;

  DioClient({
    required this.dio,
    required this.baseUrl,
  }) {
    dio.interceptors.add(LogInterceptor());
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
    );
  }


  Future<Response> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      int statusCode = e.response?.statusCode ?? 0;
      if (statusCode >= 400 && statusCode <= 499) {
        String? errorMessage = e.response?.statusMessage;
        throw ServerException(errorMessage.toString(),statusCode);
      } else {
        throw ServerException('There is something went wrong',statusCode);
      }
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      int statusCode = e.response?.statusCode ?? 0;
      if (statusCode >= 400 && statusCode <= 499) {
        String? errorMessage = e.response?.statusMessage;
        throw ServerException(errorMessage.toString(),statusCode);
      } else {
        throw ServerException('There is something went wrong',statusCode);
      }
    }
  }

  // Download:----------------------------------------------------------------------
  Future<Response<dynamic>> download(
      String uri,
      String savePath, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await dio.download(
        uri,
        savePath,
        options: options,
        data: data,
      );

      return response;
    } on DioException catch (e) {
      int statusCode = e.response?.statusCode ?? 0;
      if (statusCode >= 400 && statusCode <= 499) {
        String? errorMessage = e.response?.statusMessage;
        throw ServerException(errorMessage.toString(),statusCode);
      } else {
        throw ServerException('There is something went wrong',statusCode);
      }
    }
  }

}
