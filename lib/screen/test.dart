// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// class QRCodePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFA8E063), Color(0xFF56AB2F)], // Gradient colors
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Create a personal\nQR - code",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 QrImageView(
//                   data: "https://example.com", // Your QR code data
//                   version: QrVersions.auto,
//                   size: 200.0,
//                   backgroundColor: Colors.white,
//                   embeddedImage: AssetImage('assets/t-rex.png'), // Optional embedded image
//                   embeddedImageStyle: QrEmbeddedImageStyle(
//                     size: Size(40, 40),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildFormatButton("PNG", isActive: false),
//                     _buildFormatButton("JPG", isActive: true),
//                     _buildFormatButton("SVG", isActive: false),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF0B9444),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 12,
//                     ),
//                   ),
//                   child: const Text(
//                     "Collection Preview",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFormatButton(String label, {required bool isActive}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isActive ? Color(0xFFFFD700) : Colors.grey[800],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isActive ? Colors.black : Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
