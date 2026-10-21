import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/consts/api_service_consts.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiServiceConsts.baseUrl));
  ApiService() {
    _dio.interceptors.add(PrettyDioLogger());

    // customization
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }

  Future<Response> post({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }

  Future<Response> put({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }

  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.delete(
      endpoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  }
}
