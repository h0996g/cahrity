import 'dart:io';

import 'package:charity/api/api_const.dart';
import 'package:charity/const/const.dart';
import 'package:dio/dio.dart';

class VPSDio {
  static late Dio _dio;

  /// Initialize Dio with default configuration
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $TOKEN',
        },
        validateStatus: (status) {
          if (status == 401 || status == 403) {
            // HomeCubit.get(navigatorKey.currentContext).resetValue();
            // navigatorKey.currentContext?.go(RouteConstants.login);
          }

          return status! < 500;
        },
      ),
    );
  }

  /// Update authorization token
  static void updateToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Remove authorization token
  static void removeToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// POST request
  static Future<Response> post({
    required String path,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// GET request
  static Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  static Future<Response> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  static Future<Response> put({
    required String path,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.put(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PATCH request
  static Future<Response> patch({
    required String path,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      // For multipart/form-data requests
      if (data is FormData) {
        _dio.options.headers['Content-Type'] = 'multipart/form-data';
      }

      return await _dio.patch(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } finally {
      // Reset Content-Type to default
      _dio.options.headers['Content-Type'] = 'application/json';
    }
  }

  /// Upload file(s)
  static Future<Response> upload({
    required String path,
    required List<MapEntry<String, MultipartFile>> files,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final formData = FormData();

      // Add files to form data
      for (var file in files) {
        formData.files.add(file);
      }

      // Add additional data if provided
      if (data != null) {
        formData.fields.addAll(
          data.entries.map((e) => MapEntry(e.key, e.value.toString())),
        );
      }

      return await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options?.copyWith(contentType: 'multipart/form-data'),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Download file
  static Future<Response> download({
    required String url,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio Errors
  static Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.sendTimeout:
        return Exception('Send timeout. Please try again.');

      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout. Please try again.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;

        switch (statusCode) {
          case 400:
            return Exception(
              'Bad request: ${data?['message'] ?? 'Unknown error'}',
            );
          case 401:
            return Exception(
              'Unauthorized: ${data?['message'] ?? 'Please login again'}',
            );
          case 403:
            return Exception(
              'Forbidden: ${data?['message'] ?? 'Access denied'}',
            );
          case 404:
            return Exception(
              'Not found: ${data?['message'] ?? 'Resource not found'}',
            );
          case 422:
            return Exception(
              'Validation error: ${data?['message'] ?? 'Invalid data'}',
            );
          default:
            return Exception(
              'Server error: ${data?['message'] ?? 'Unknown error'}',
            );
        }

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return Exception('No internet connection');
        }
        return Exception('Network error occurred: ${e.message}');

      default:
        return Exception('Something went wrong: ${e.message}');
    }
  }

  /// Create CancelToken for cancelling requests
  static CancelToken createCancelToken() {
    return CancelToken();
  }

  /// Create Options for requests
  static Options createOptions({
    String? contentType,
    ResponseType? responseType,
    Map<String, dynamic>? headers,
    int? sendTimeout,
    int? receiveTimeout,
  }) {
    return Options(
      contentType: contentType,
      responseType: responseType,
      headers: headers,
      sendTimeout:
          sendTimeout != null ? Duration(milliseconds: sendTimeout) : null,
      receiveTimeout:
          receiveTimeout != null
              ? Duration(milliseconds: receiveTimeout)
              : null,
    );
  }
}
