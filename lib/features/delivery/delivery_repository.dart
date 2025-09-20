import 'package:aws/state/providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import '../../data/remote/api_client.dart';
import '../../data/remote/endpoints.dart';
import '../../dev/dev_fixtures.dart';

final deliveryRepositoryProvider = Provider<DeliveryRepository>(
  (ref) => DeliveryRepository(ref),
);

class DeliveryRepository {
  DeliveryRepository(this.ref);
  final Ref ref;

  Dio get _dio => ref.read(apiClientProvider).dio;

  Future<List<Map<String, dynamic>>> fetchDeliveries() async {
    if (kDebugMode) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return List<Map<String, dynamic>>.from(DevFixtures.deliveries);
    }
    final res = await _dio.get('/api/entregas');
    return (res.data as List).cast<Map<String, dynamic>>();
  }

  Future<List<String>> fetchDeliveryScans(String deliveryId) async {
    if (kDebugMode) {
      return List<String>.from(DevFixtures.deliveryScans[deliveryId] ?? []);
    }
    final res = await _dio.get(Endpoints.entregaScan(deliveryId));
    return (res.data as List).cast<String>();
  }

  Future<void> scanToDelivery({required String deliveryId, required String code}) async {
    if (kDebugMode) {
      DevFixtures.deliveryScans.putIfAbsent(deliveryId, () => []);
      DevFixtures.deliveryScans[deliveryId]!.add(code);
      return;
    }
    await _dio.post(Endpoints.entregaScan(deliveryId), data: {'codigo': code});
  }

  Future<void> confirmDelivery({required String deliveryId, required List<String> codes}) async {
    if (kDebugMode) {
      final idx = DevFixtures.deliveries.indexWhere((e) => e['id'] == deliveryId);
      if (idx != -1) DevFixtures.deliveries[idx]['estado'] = 'Despachado';
      return;
    }
    await _dio.post(Endpoints.entregaConfirmar(deliveryId), data: {'cajas': codes});
  }
}
