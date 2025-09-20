
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    responseType: ResponseType.json,
    //esto cambiara dependiendo de donde este tu backend
    baseUrl: 'https://tu-backend.example.com',
  ));
  final _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: false,
      responseHeader: false,
      compact: true,
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;
}
