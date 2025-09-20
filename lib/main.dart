import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Captura errores sincrónicos de Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // Muestra también en consola
    // ignore: avoid_print
    print('FlutterError ► ${details.exception}');
  };

  // Zona que captura errores asíncronos
  runZonedGuarded(() {
    // Marca que main() arrancó
    debugPrint('>>> main() started');
    runApp(const ProviderScope(child: AwsApp()));
  }, (e, st) {
    debugPrint('Uncaught zone error: $e\n$st');
  });
}

class AwsApp extends StatelessWidget {
  const AwsApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('>>> AwsApp.build()'); // para confirmar que pinta el árbol
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AWS App',
      routerConfig: appRouter,
      locale: const Locale('es', 'MX'),
      supportedLocales: const [Locale('es', 'MX'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
