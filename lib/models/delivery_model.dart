import 'package:flutter/material.dart';

enum DeliveryStatus { pending, inProgress, onTheWay, delivered, cancelled }

class DeliveryOrder {
  final String id;
  final String orderNumber;
  final String client;
  final DateTime date;
  final List<String> products;
  late final DeliveryStatus status;
  final String? barcode;

  DeliveryOrder({
    required this.id,
    required this.orderNumber,
    required this.client,
    required this.date,
    required this.products,
    required this.status,
    this.barcode,
  });

  String get statusText {
    switch (status) {
      case DeliveryStatus.pending:
        return 'Pendiente';
      case DeliveryStatus.inProgress:
        return 'En preparación';
      case DeliveryStatus.onTheWay:
        return 'En camino';
      case DeliveryStatus.delivered:
        return 'Entregado';
      case DeliveryStatus.cancelled:
        return 'Cancelado';
    }
  }

  Color get statusColor {
    switch (status) {
      case DeliveryStatus.pending:
        return Colors.orange;
      case DeliveryStatus.inProgress:
        return Colors.blue;
      case DeliveryStatus.onTheWay:
        return Colors.purple;
      case DeliveryStatus.delivered:
        return Colors.green;
      case DeliveryStatus.cancelled:
        return Colors.red;
    }
  }
}

// Datos de ejemplo
final List<DeliveryOrder> deliveryOrders = [
  DeliveryOrder(
    id: '1',
    orderNumber: 'ORD-1001',
    client: 'Restaurante Los Sabores',
    date: DateTime.now().subtract(const Duration(days: 1)),
    products: ['Pulpa de res (10kg)', 'Pollo entero (5un)'],
    status: DeliveryStatus.delivered,
    barcode: '1001',
  ),
  DeliveryOrder(
    id: '2',
    orderNumber: 'ORD-1002',
    client: 'Carnicería Don Juan',
    date: DateTime.now(),
    products: ['Costillas de cerdo (15kg)', 'Chorizos (20un)'],
    status: DeliveryStatus.onTheWay,
    barcode: '1002',
  ),
  DeliveryOrder(
    id: '3',
    orderNumber: 'ORD-1003',
    client: 'Supermercado Central',
    date: DateTime.now().add(const Duration(days: 1)),
    products: ['Filete de pescado (8kg)', 'Camarones (5kg)'],
    status: DeliveryStatus.inProgress,
    barcode: '1003',
  ),
  DeliveryOrder(
    id: '4',
    orderNumber: 'ORD-1004',
    client: 'Hotel Plaza',
    date: DateTime.now().add(const Duration(days: 2)),
    products: ['Lomo fino (12kg)', 'Salchichas (30un)'],
    status: DeliveryStatus.pending,
    barcode: '1004',
  ),
];
