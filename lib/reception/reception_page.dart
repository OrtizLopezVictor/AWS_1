import 'package:flutter/material.dart';
import 'reception_summary_page.dart';
import 'reception_detail_page.dart';

class ReceptionPage extends StatelessWidget {
  const ReceptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recepción'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Total Recibidas'),
              Tab(text: 'Buscar pedido'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [ReceptionSummaryPage(), ReceptionDetailPage()],
        ),
      ),
    );
  }
}
