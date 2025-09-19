
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/remote/api_client.dart';
import '../features/auth/auth_repository.dart';

// Singletons base
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

// Estado global simple
final authStateProvider = StateProvider<bool>((ref) => false);
final usernameProvider = StateProvider<String?>((ref) => null);
final activeLocationProvider = StateProvider<String?>((ref) => null);
final notificationsCountProvider = StateProvider<int>((ref) => 0);

// Repo auth
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref));
