import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/remote/endpoints.dart';
import '../../state/providers.dart';

class AuthRepository {
  AuthRepository(this.ref);
  final Ref ref;

  Future<bool> login(String username, String password) async {
        // Permitir acceso en DEBUG sin tocar API
    if (kDebugMode && username == 'demo' && password == '1234') {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: 'dev-token');
      ref.read(authStateProvider.notifier).state = true;
      ref.read(usernameProvider.notifier).state = username;
      return true;
    }


    final dio = ref.read(apiClientProvider).dio;
    try {
      final res = await dio.post(
        Endpoints.login,
        data: {'username': username, 'password': password},
      );
      final token = (res.data is Map && res.data['token'] != null)
          ? res.data['token'] as String
          : null;
      if (token != null && token.isNotEmpty) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: token);
        ref.read(authStateProvider.notifier).state = true;
        ref.read(usernameProvider.notifier).state = username;
        return true;
      }
      return false;
    } on DioException {
      return false;
    }
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    ref.read(authStateProvider.notifier).state = false;
    ref.read(usernameProvider.notifier).state = null;
  }

  Future<void> forgotPassword(String userOrEmail) async {
    final dio = ref.read(apiClientProvider).dio;
    await dio.post(Endpoints.forgotPassword, data: {'user': userOrEmail});
  }

  Future<void> switchAccount() async {
    await logout();
  }
}
