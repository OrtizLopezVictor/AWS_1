import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/delivery_model.dart';
import 'barcode_scanner.dart';
import 'delivery_card.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  List<DeliveryOrder> filteredOrders = deliveryOrders;
  final TextEditingController _searchController = TextEditingController();
  DeliveryStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterOrders);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredOrders = deliveryOrders.where((order) {
        final matchesSearch =
            order.orderNumber.toLowerCase().contains(query) ||
            order.client.toLowerCase().contains(query);
        final matchesStatus =
            _selectedStatus == null || order.status == _selectedStatus;
        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  void _scanBarcode() async {
    final scannedCode = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (scannedCode != null) {
      _searchController.text = scannedCode;
      _filterOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Órdenes de Entrega'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              _showStatusFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por orden o cliente...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: _scanBarcode,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_selectedStatus != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Chip(
                    label: Text(
                      'Filtro: ${_selectedStatus!.name}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _selectedStatus?.statusColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      setState(() {
                        _selectedStatus = null;
                        _filterOrders();
                      });
                    },
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return DeliveryCard(
                  order: order,
                  onStatusChanged: (newStatus) {
                    setState(() {
                      order.status = newStatus;
                      _filterOrders();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtrar por estado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: DeliveryStatus.values.map((status) {
              return ListTile(
                title: Text(status.name),
                leading: Icon(Icons.circle, color: status.statusColor),
                onTap: () {
                  setState(() {
                    _selectedStatus = status;
                    _filterOrders();
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

extension on DeliveryStatus? {
  get statusColor => null;
}
