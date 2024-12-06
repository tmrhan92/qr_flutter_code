import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsec/screen/positions_page.dart';
import 'package:tsec/screen/qr_scanner_page.dart';
import 'package:tsec/screen/scanqr.dart';
import 'UnscannedProductsPage.dart';

class ProductApp extends StatefulWidget {
  @override
  _ProductAppState createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  int _selectedIndex = 2;

  // قائمة الصفحات
  final List<Widget> _pages = [
    CreateScreen(),
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'QR Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Position',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Unscanned Products',
          ),
        ],
      ),
    );
  }
}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D25), // خلفية داكنة
      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/safty.png'), // تأكد من المسار الصحيح
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xFF0B0D25),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // الكارد لمعلومات المنتج
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E284F),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // العنوان والتقييمات
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "مؤسسة الترك للسلامة العامة والاستشارات",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "الاردن_الكرك. شارع الزراعة",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade300),
                    textAlign: TextAlign.right, // تحديد اتجاه النص من اليمين إلى اليسار

                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center, // محاذاة العناصر في الوسط
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.purple, size: 20),
                      SizedBox(width: 5),
                      Text(
                        "+962 790 696121",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),


                  Center(
                    child:  QrImageView(
                      data: '', // Your QR code data
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.purple,
                      embeddedImage: AssetImage('assets/t-rex.png'), // Optional embedded image
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(40, 40),

                      ),
                    ),
                  ),

                  const SizedBox(height: 16),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

