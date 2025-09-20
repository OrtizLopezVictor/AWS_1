
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanPreview extends StatefulWidget {
  final void Function(String code) onDetect;
  const BarcodeScanPreview({super.key, required this.onDetect});

  @override
  State<BarcodeScanPreview> createState() => _BarcodeScanPreviewState();
}

class _BarcodeScanPreviewState extends State<BarcodeScanPreview> {
  final controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final barcodes = capture.barcodes;
            for (final b in barcodes) {
              final raw = b.rawValue;
              if (raw != null && raw.isNotEmpty) {
                widget.onDetect(raw);
              }
            }
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: Colors.black54,
            child: const Text('Apunta la cámara a la etiqueta', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }
}
