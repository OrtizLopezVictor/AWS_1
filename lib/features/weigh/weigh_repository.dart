import 'package:aws/state/providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import '../../data/remote/api_client.dart';
import '../../data/remote/endpoints.dart';
import '../../dev/dev_fixtures.dart';

final weighRepositoryProvider = Provider<WeighRepository>((ref) => WeighRepository(ref));

class WeighRepository {
  WeighRepository(this.ref);
  final Ref ref;
  Dio get _dio => ref.read(apiClientProvider).dio;

  Future<void> registerWeight({required String code, required double weight}) async {
    if (kDebugMode) {
      DevFixtures.weighLog.add({'codigo': code, 'peso': weight, 'fecha': DateTime.now().toIso8601String()});
      return;
    }
    await _dio.post(Endpoints.pesaje, data: {'codigo': code, 'peso': weight});
  }
}
