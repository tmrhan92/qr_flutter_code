import 'package:flutter/material.dart';
import 'package:tsec/screen/scanqr.dart';
import '../api_service.dart';
import 'package:barcode_widget/barcode_widget.dart';

class PositionPage extends StatefulWidget {
  final Function(String) onProductScanned;

  PositionPage({required this.onProductScanned});

  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, List<Map<String, dynamic>>> categorizedProducts = {};
  List<String> scannedProducts = [];
  List<String> locations = [];

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  void fetchLocations() async {
    try {
      // جلب المواقع من API
      List<String> fetchedLocations = await ApiService.fetchLocations();
      setState(() {
        locations = fetchedLocations;
        _tabController = TabController(length: locations.length, vsync: this);

        // تهيئة القائمة الفارغة للمنتجات حسب المواقع
        for (var location in locations) {
          categorizedProducts[location] = [];
        }

        fetchProducts(); // جلب المنتجات بعد تحميل المواقع
      });
    } catch (e) {
      print('خطأ في جلب المواقع: $e');
    }
  }


  void fetchProducts() async {
    try {
      List<Map<String, dynamic>> fetchedProducts = await ApiService.fetchProducts();
      for (var product in fetchedProducts) {
        if (categorizedProducts.containsKey(product['position'])) {
          categorizedProducts[product['position']]!.add(product);
          if (product['isScanned'] == true) {
            scannedProducts.add(product['_id']);
          }
        }
      }
      setState(() {});
    } catch (e) {
      print('خطأ في جلب المنتجات: $e');
    }
  }

  void handleProductScanned(String productId) {
    if (!scannedProducts.contains(productId)) {
      scannedProducts.add(productId);
    }
    fetchProducts();
  }

  void deleteProductFromPosition(String productId, String position) async {
    try {
      final success = await ApiService.deleteProduct(productId);
      if (success) {
        setState(() {
          categorizedProducts[position]?.removeWhere((product) => product['_id'] == productId);
          scannedProducts.remove(productId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم حذف المنتج من $position بنجاح!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في حذف المنتج.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء الحذف: $error')),
      );
    }
  }

  void resetAllProducts() async {
    try {
      final success = await ApiService.resetProductScanStatus();
      if (success) {
        setState(() {
          scannedProducts.clear();
          categorizedProducts.forEach((key, products) {
            for (var product in products) {
              product['isScanned'] = false;
            }
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم إعادة تعيين جميع المنتجات إلى غير مسحوبة!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إعادة تعيين حالة المنتجات.')),
        );
      }
    } catch (error) {
      print('حدث خطأ أثناء إعادة تعيين الحالة: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في إعادة تعيين الحالة: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Position'),
        backgroundColor: Colors.black,
        bottom: locations.isNotEmpty
            ? TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Color(0xFF0B0D25),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.white70,
          labelColor: Colors.purple,
          tabs: locations.map((location) => Tab(text: location)).toList(),
        )

            : null,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateScreen(
                    refreshPositions: fetchProducts, // تحديث المنتجات عند العودة
                  ),
                ),
              );
            },
          ),

        ],
      ),

      body: locations.isNotEmpty
          ? TabBarView(
        controller: _tabController,
        children: locations.map((location) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.transparent),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(2.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: categorizedProducts[location]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = categorizedProducts[location]![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Card(
                        color: Colors.black,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              BarcodeWidget(
                                data: product['qr'],
                                barcode: Barcode.qrCode(),
                                color: Colors.white,
                                height: 100,
                                width: 100,
                              ),
                              Text(
                                scannedProducts.contains(product['_id']) ? '✅ تم المسح بنجاح' : '❌ لم يتم المسح',
                                style: TextStyle(
                                  color: scannedProducts.contains(product['_id']) ? Colors.green : Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.delete, size: 10),
                                label: const Text('حذف المنتج'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purple,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => deleteProductFromPosition(product['_id'], location),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }).toList(),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
