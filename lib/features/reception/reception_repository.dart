import 'package:aws/state/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// ignore: unused_import
import '../../data/remote/api_client.dart';
import '../../data/remote/endpoints.dart';
import '../../dev/dev_fixtures.dart';

final receptionRepositoryProvider = Provider<ReceptionRepository>(
  (ref) => ReceptionRepository(ref),
);

class ReceptionRepository {
  ReceptionRepository(this.ref);
  final Ref ref;

  Dio get _dio => ref.read(apiClientProvider).dio;

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    if (kDebugMode) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return List<Map<String, dynamic>>.from(DevFixtures.receptionOrders);
    }
    final res = await _dio.get('/api/recepcion');
    return (res.data as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchOrderDetail(String orderId) async {
    if (kDebugMode) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return List<Map<String, dynamic>>.from(DevFixtures.receptionDetail[orderId] ?? []);
    }
    final res = await _dio.get('/api/recepcion/$orderId');
    return (res.data as List).cast<Map<String, dynamic>>();
  }

  Future<void> sendScans({required String orderId, required List<Map<String, dynamic>> scans}) async {
    if (kDebugMode) {
      DevFixtures.receptionDetail.putIfAbsent(orderId, () => []);
      DevFixtures.receptionDetail[orderId]!.addAll(scans);
      return;
    }
    await _dio.post(Endpoints.recepcionScanCaja, data: {'pedidoId': orderId, 'cajas': scans});
  }

  Future<void> manualEntry({required String orderId, required String code, required String date, double? weight}) async {
    if (kDebugMode) {
      DevFixtures.receptionDetail.putIfAbsent(orderId, () => []);
      DevFixtures.receptionDetail[orderId]!.add({'code': code, 'weight': weight, 'date': date});
      return;
    }
    await _dio.post(Endpoints.recepcionCajaManual, data: {
      'pedidoId': orderId, 'codigo': code, 'fecha': date, if (weight != null) 'peso': weight,
    });
  }

  Future<String> generateMasterPallet({required String orderId}) async {
    if (kDebugMode) {
      final next = (DevFixtures.palletsByOrder[orderId]?.length ?? 0) + 1;
      final id = 'TAR-${next.toString().padLeft(3, '0')}';
      DevFixtures.palletsByOrder.putIfAbsent(orderId, () => []);
      DevFixtures.palletsByOrder[orderId]!.add({'id': id, 'cajas': 0});
      return id;
    }
    final res = await _dio.post(Endpoints.generarTarima, data: {'pedidoId': orderId});
    return (res.data as Map)['tarimaId'].toString();
  }

  Future<void> reprintMasterPallet(String tarimaId) async {
    if (kDebugMode) return;
    await _dio.get(Endpoints.reimprimirTarima(tarimaId));
  }

  Future<void> confirmReception(String orderId) async {
    if (kDebugMode) {
      final idx = DevFixtures.receptionOrders.indexWhere((e) => e['id'] == orderId);
      if (idx != -1) DevFixtures.receptionOrders[idx]['estado'] = 'Confirmado';
      return;
    }
    await _dio.post(Endpoints.recepcionConfirmar(orderId));
  }
}
