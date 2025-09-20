import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/remote/api_client.dart';
import '../features/auth/auth_repository.dart';
import '../dev/dev_fixtures.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authStateProvider = StateProvider<bool>((ref) => false);
final usernameProvider = StateProvider<String?>((ref) => isDev ? 'demo' : null);
final activeLocationProvider = StateProvider<String?>(
  (ref) => isDev ? DevFixtures.locations.first : null,
);
final notificationsCountProvider = StateProvider<int>((ref) => isDev ? 3 : 0);

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref));

// Data providers for UI (DEV lists)
final locationsProvider = Provider<List<String>>((ref) => DevFixtures.locations);

final receptionOrdersProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => isDev ? DevFixtures.receptionOrders : <Map<String, dynamic>>[],
);

final deliveriesProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => isDev ? DevFixtures.deliveries : <Map<String, dynamic>>[],
);

final weighLogProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => isDev ? DevFixtures.weighLog : <Map<String, dynamic>>[],
);

final offlineQueueProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => isDev ? DevFixtures.offlineQueue : <Map<String, dynamic>>[],
);
