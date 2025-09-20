import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/reception/reception_list_screen.dart';
import 'features/reception/reception_detail_screen.dart';
import 'features/delivery/delivery_list_screen.dart';
import 'features/delivery/delivery_detail_screen.dart';
import 'features/weigh/weigh_screen.dart';
import 'features/storage_requests/storage_requests_screen.dart';
import 'features/offline/sync_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/', builder: (c, s) => const DashboardScreen()),
    GoRoute(path: '/recepcion', builder: (c, s) => const ReceptionListScreen()),
    GoRoute(
      path: '/recepcion/:id',
      builder: (c, s) => ReceptionDetailScreen(orderId: s.pathParameters['id']!),
    ),
    GoRoute(path: '/entregas', builder: (c, s) => const DeliveryListScreen()),
    GoRoute(
      path: '/entregas/:id',
      builder: (c, s) => DeliveryDetailScreen(deliveryId: s.pathParameters['id']!),
    ),
    GoRoute(path: '/pesaje', builder: (c, s) => const WeighScreen()),
    GoRoute(path: '/almacenaje', builder: (c, s) => const StorageRequestsScreen()),
    GoRoute(path: '/sync', builder: (c, s) => const SyncScreen()),
  ],
  errorBuilder: (c, s) => const Scaffold(
    body: Center(child: Text('Error de ruteo: verifica tus rutas')),
  ),
);
