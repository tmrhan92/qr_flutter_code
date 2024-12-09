// import 'package:flutter/material.dart';
// import '../api_service.dart';
//
// class AdminPanel extends StatefulWidget {
//   @override
//   _AdminPanelState createState() => _AdminPanelState();
// }
//
// class _AdminPanelState extends State<AdminPanel> {
//   final TextEditingController _locationController = TextEditingController();
//
//   Future<void> _addLocation() async {
//     String locationName = _locationController.text.trim();
//     if (locationName.isEmpty) return;
//
//     try {
//       await ApiService.addLocation(locationName);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إضافة الموقع بنجاح!')));
//       _locationController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ أثناء إضافة الموقع: $e')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('لوحة الإدارة')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(
//                 labelText: 'أدخل اسم الموقع',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _addLocation,
//               child: Text('إضافة موقع'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
