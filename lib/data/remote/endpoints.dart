class Endpoints {
  // Auth
  static const String login = '/api/auth/login';
  static const String forgotPassword = '/api/auth/forgot';
  static const String switchAccount = '/api/auth/switch';

  // Recepción
  static const String recepcionScanCaja = '/api/recepcion/cajas/scan';
  static const String recepcionCajaManual = '/api/recepcion/cajas/manual';
  static String recepcionConfirmar(String orderId) => '/api/recepcion/$orderId/confirmar';

  // Tarima (master pallet)
  static const String generarTarima = '/api/etiquetas/tarima';
  static String reimprimirTarima(String id) => '/api/etiquetas/tarima/$id/reimprimir';

  // Entregas
  static String entregaScan(String deliveryId) => '/api/entregas/$deliveryId/scan';
  static String entregaConfirmar(String deliveryId) => '/api/entregas/$deliveryId/confirmar';

  // Pesaje
  static const String pesaje = '/api/pesaje';

  // Offline / Sync
  static const String syncBatch = '/api/sync/batch';

  // Búsqueda por folio
  static const String operationsByFolio = '/api/ops/by_folio'; // ?folio=...
}
