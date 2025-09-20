import 'package:aws/state/providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import '../../data/remote/api_client.dart';
import '../../data/remote/endpoints.dart';
import '../../dev/dev_fixtures.dart';

final syncRepositoryProvider = Provider<SyncRepository>((ref) => SyncRepository(ref));

class SyncRepository {
  SyncRepository(this.ref);
  final Ref ref;
  Dio get _dio => ref.read(apiClientProvider).dio;

  Future<void> pushQueue(List<Map<String, dynamic>> batch) async {
    if (kDebugMode) {
      DevFixtures.offlineQueue.clear();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return;
    }
    await _dio.post(Endpoints.syncBatch, data: {'batch': batch});
  }
}
