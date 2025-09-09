class Order {
  final String orderNumber;
  final String supplier;
  final String date;
  final String status;
  final List<Product> products;

  Order({
    required this.orderNumber,
    required this.supplier,
    required this.date,
    required this.status,
    required this.products,
  });
}

class Product {
  final String name;
  final String sku;
  final String quantity;
  final String uom;

  Product({
    required this.name,
    required this.sku,
    required this.quantity,
    required this.uom,
  });
}

final List<Order> mockOrders = [
  Order(
    orderNumber: '00001',
    supplier: 'SuKarne',
    date: '08/07/2024',
    status: 'En espera',
    products: [
      Product(
        name: 'Pulpa Paleta',
        sku: '010240001',
        quantity: '2,368.34',
        uom: 'Kg',
      ),
    ],
  ),
  Order(
    orderNumber: '00002',
    supplier: 'CarnEncanto',
    date: '08/07/2024',
    status: 'En espera',
    products: [
      Product(
        name: 'Pulpa Paleta',
        sku: '010240001',
        quantity: '2,368.34',
        uom: 'Kg',
      ),
    ],
  ),
  Order(
    orderNumber: '00003',
    supplier: 'SuKarne',
    date: '08/07/2024',
    status: 'En espera',
    products: [
      Product(
        name: 'Pulpa Paleta',
        sku: '010240001',
        quantity: '2,368.34',
        uom: 'Kg',
      ),
      Product(
        name: 'Diezmillo',
        sku: '010240001',
        quantity: '7,268.34',
        uom: 'Kg',
      ),
    ],
  ),
  Order(
    orderNumber: '00004',
    supplier: 'CarnEncanto',
    date: '08/07/2024',
    status: 'Finalizado',
    products: [
      Product(
        name: 'Pulpa Paleta',
        sku: '010240001',
        quantity: '2,368.34',
        uom: 'Kg',
      ),
    ],
  ),
];
