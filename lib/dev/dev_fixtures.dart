import 'package:flutter/foundation.dart';

bool get isDev => kDebugMode;

class DevFixtures {
  static const locations = <String>['Bodega MTY','Bodega CUL','Bodega GDL'];

  static final receptionOrders = <Map<String, dynamic>>[
    {'id':'RX-1001','proveedor':'Frutas del Norte','fecha':'2025-09-18','cajas':24,'estado':'En proceso'},
    {'id':'RX-1002','proveedor':'AgroExport MX','fecha':'2025-09-19','cajas':18,'estado':'Pendiente'},
  ];

  static final receptionDetail = <String, List<Map<String, dynamic>>>{
    'RX-1001':[
      {'code':'BX-0001','weight':12.3,'date':DateTime.now().toIso8601String()},
      {'code':'BX-0002','weight':11.7,'date':DateTime.now().toIso8601String()},
    ],
    'RX-1002':[],
  };

  static final palletsByOrder = <String, List<Map<String, dynamic>>>{
    'RX-1001':[{'id':'TAR-001','cajas':12},{'id':'TAR-002','cajas':12}],
  };

  static final deliveries = <Map<String, dynamic>>[
    {'id':'DL-2001','cliente':'Mercado Central','fecha':'2025-09-19','cajas':30,'estado':'Listo para salir'},
    {'id':'DL-2002','cliente':'Retail MX','fecha':'2025-09-20','cajas':12,'estado':'Preparando'},
  ];

  static final deliveryScans = <String, List<String>>{
    'DL-2001':['BX-0001','BX-0002'],
  };

  static final weighLog = <Map<String, dynamic>>[
    {'codigo':'BX-1001','peso':12.0,'fecha':DateTime.now().toIso8601String()},
    {'codigo':'BX-1002','peso':10.9,'fecha':DateTime.now().toIso8601String()},
  ];

  static final offlineQueue = <Map<String, dynamic>>[
    {'op':'scan','code':'BX-1234','ts':DateTime.now().toIso8601String()},
    {'op':'weigh','code':'BX-1250','peso':11.2,'ts':DateTime.now().toIso8601String()},
  ];
}
