import 'package:flutter/material.dart';
import 'auth/login_page.dart';
import 'home/home_page.dart';
import 'reception/reception_page.dart';
import 'reception/reception_detail_page.dart';
import 'reception/escaneo_page.dart';
import 'reception/tarima_page.dart';
import 'reception/manual_entry_page.dart';
import 'delivery/entrega_list_page.dart';
import 'delivery/entrega_scan_page.dart';
import 'delivery/entrega_tarima_page.dart';
import 'pesaje/pesaje_page.dart';
import 'sync/sync_page.dart';

void main() {
  runApp(const WMSApp());
}

class WMSApp extends StatelessWidget {
  const WMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App WMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginPage(),
        "/home": (context) => const HomePage(usuario: 'Usuario'),

        // Recepción
        "/recepcion": (context) => const ReceptionPage(),
        "/recepcion/detail": (context) => const ReceptionDetailPage(),
        "/recepcion/escaneo": (context) => const EscaneoPage(pedidoId: "1"),
        "/recepcion/tarima": (context) => const TarimaPage(pedidoId: "1"),
        "/recepcion/manual": (context) => const ManualEntryPage(pedidoId: "1"),

        // Entrega
        "/entregas": (context) => const EntregaListPage(),
        "/entregas/scan": (context) => const EntregaScanPage(entregaId: "1"),
        "/entregas/tarima": (context) =>
            const EntregaTarimaPage(entregaId: "1"),

        // Pesaje
        "/pesaje": (context) => const PesajePage(),

        // Sincronización
        "/sync": (context) => const SyncPage(),
      },
    );
  }
}
