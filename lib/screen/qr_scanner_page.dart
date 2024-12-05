import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import '../api_service.dart';

class QRScannerPage extends StatefulWidget {
  final Function(String) onProductScanned;
  final Function(String) onProductDeleted;

  QRScannerPage({required this.onProductScanned, required this.onProductDeleted});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            child: scannedData == null
                ? const Center(child: Text('Scan a code'))
                : ElevatedButton(
              onPressed: isSending ? null : () => processScannedData(scannedData),
              child: isSending ? const CircularProgressIndicator() : const Text('Send Data'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code != null && scanData.code!.isNotEmpty) {
          scannedData = scanData.code!;
          print("Scanned Data: $scannedData");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid QR Code")),
          );
        }
      });
    });
  }

  void processScannedData(String? data) async {
    if (data == null || data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لا توجد بيانات مسح ضوئي للتعامل معها")),
      );
      return;
    }

    setState(() {
      isSending = true;
    });

    try {
      final productData = jsonDecode(data); // تأكد من البيانات المدخلة
      print("Scanned QR Code Data: $data");

      if (productData is! Map<String, dynamic>) {
        throw Exception("تنسيق QR Code غير صالح");
      }

      String? productId = productData['_id'];
      if (productId == null || productId.isEmpty) {
        throw Exception("معرف المنتج مفقود أو غير صالح");
      }

      // تحقق من أن المنتج موجود في قاعدة البيانات
      final response = await ApiService.updateProductScanStatus(productId, true);
      if (response.statusCode == 200) {
        widget.onProductScanned(productId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم تحديث حالة المنتج بنجاح!")),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("المنتج غير موجود")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل في تحديث حالة المنتج: ${response.statusCode}")),
        );
      }

    } catch (e) {
      print('Error while processing QR Code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ أثناء معالجة رمز QR: $e")),
      );
    } finally {
      setState(() {
        isSending = false;
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}