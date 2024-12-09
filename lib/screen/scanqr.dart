import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../api_service.dart';

class CreateScreen extends StatefulWidget {
  final VoidCallback refreshPositions; // Callback لإعادة تحميل المواقع

  CreateScreen({required this.refreshPositions});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String productName = '';
  String productPosition = '';
  String qrData = '';
  List<String> availablePositions = []; // المواقع المحملة ديناميكيًا
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPositions();
  }

  // جلب المواقع من API
  void fetchPositions() async {
    try {
      List<String> positions = await ApiService.fetchLocations();
      setState(() {
        availablePositions = positions;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching positions: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // عرض مؤشر تحميل أثناء جلب المواقع
          : Container(
        child: Column(
          children: [
            AppBar(
              title: const Text('QR Code Generator', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Create a product\nQR - code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Enter Product Name', (val) {
                      setState(() {
                        productName = val.trim();
                        updateQrString();
                      });
                    }),
                    const SizedBox(height: 20),
                    _buildDropdown(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (productPosition.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select a position!")),
                          );
                          return;
                        }

                        try {
                          String productId = generateProductId(productName, productPosition);
                          await ApiService.sendProductData(
                            productId,
                            productName,
                            productPosition,
                            qrData,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Product saved successfully!")),
                          );
                          widget.refreshPositions(); // تحديث صفحة المواقع
                          Navigator.pop(context); // العودة إلى الصفحة السابقة
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error saving product: $e")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Generate QR', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateQrString() {
    String productId = generateProductId(productName, productPosition);
    qrData = jsonEncode({
      "productName": productName.isNotEmpty ? productName : "Unknown",
      "productPosition": productPosition.isNotEmpty ? productPosition : "Unknown",
      "_id": productId,
    });
  }

  String generateProductId(String name, String position) {
    return "${name.toLowerCase().replaceAll(RegExp(r'\s+'), '_')}_${position.toLowerCase().replaceAll(RegExp(r'\s+'), '_')}";
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: productPosition.isEmpty ? null : productPosition,
      onChanged: (value) {
        setState(() {
          productPosition = value ?? '';
          updateQrString();
        });
      },
      decoration: InputDecoration(
        hintText: 'Select Product Position',
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dropdownColor: Colors.black,
      items: availablePositions.map((position) {
        return DropdownMenuItem(
          value: position,
          child: Text(
            position,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(String hintText, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
