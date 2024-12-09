import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsec/screen/positions_page.dart';
import 'package:tsec/screen/qr_scanner_page.dart';
import 'package:tsec/screen/scanqr.dart';
import 'UnscannedProductsPage.dart';
import 'home_page_screen.dart';

class ProductApp extends StatefulWidget {
  @override
  _ProductAppState createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  int _selectedIndex = 2;

  // قائمة الصفحات
  final List<Widget> _pages = [
    CreateScreen(refreshPositions: () {  },),
    QRScannerPage(onProductScanned: (String) {}, onProductDeleted: (String) {}),
    Home(),
    PositionPage(onProductScanned: (String) {}),
    UnscannedProductsPage(onProductDeleted: (String) {}),
  ];

  // التنقل بين العناصر
  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E284F),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Create',
            backgroundColor: const Color(0xFF1E284F),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'QR Scanner',
            backgroundColor: const Color(0xFF1E284F),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: const Color(0xFF1E284F),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Position',
            backgroundColor: const Color(0xFF1E284F),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Unscanned Products',
            backgroundColor: const Color(0xFF1E284F),

          ),
        ],
      ),
    );
  }
}




