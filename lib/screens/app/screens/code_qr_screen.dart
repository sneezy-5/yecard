//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:flutter/foundation.dart';
//
// class BusinessCardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 50),
//           // _buildBusinessCard(),
//           _buildBusinessQrCard(),
//           Spacer(),
//           _buildShareButton(context),
//           SizedBox(height: 10),
//           _buildLinkCardButton(context),
//           SizedBox(height: 50),
//         ],
//       ),
//     );
//   }
//
//   // Widget _buildBusinessCard() {
//   //   return Center(
//   //     child: Container(
//   //       width: 300,
//   //       height: 180,
//   //       padding: EdgeInsets.all(16),
//   //       decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         borderRadius: BorderRadius.circular(12),
//   //         border: Border.all(color: Colors.grey.shade300),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.black12,
//   //             blurRadius: 6,
//   //             spreadRadius: 1,
//   //             offset: Offset(0, 2),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //         children: [
//   //           // Company name and logo
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               Text(
//   //                 'Ecobank',
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.bold,
//   //                   fontSize: 18,
//   //                   color: Colors.green,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           // User details
//   //           Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text(
//   //                 'Mr KOULOU',
//   //                 style: TextStyle(
//   //                   fontWeight: FontWeight.bold,
//   //                   fontSize: 20,
//   //                   color: Colors.black87,
//   //                 ),
//   //               ),
//   //               Text(
//   //                 'Chargé du Crédit Immobilier H/F',
//   //                 style: TextStyle(
//   //                   fontSize: 14,
//   //                   color: Colors.grey,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           // Contact info and QR code
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text(
//   //                     'exemple@gmail.com',
//   //                     style: TextStyle(
//   //                       fontSize: 14,
//   //                       color: Colors.grey.shade700,
//   //                     ),
//   //                   ),
//   //                   Text(
//   //                     '+225 0000000000',
//   //                     style: TextStyle(
//   //                       fontSize: 14,
//   //                       color: Colors.grey.shade700,
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //               // QR code (dummy image for now)
//   //               Container(
//   //                 width: 50,
//   //                 height: 50,
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.grey.shade200,
//   //                   borderRadius: BorderRadius.circular(8),
//   //                 ),
//   //                 child: Center(
//   //                   child: Icon(
//   //                     Icons.qr_code,
//   //                     size: 40,
//   //                     color: Colors.black87,
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildBusinessQrCard() {
//     return Center(
//       child: Container(
//         width: 300,
//         height: 300,
//           clipBehavior: Clip.hardEdge,
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 6,
//               spreadRadius: 1,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child:  Icon(
//           Icons.qr_code,
//           size: 240,
//           color: Colors.black87,
//         )
//       ),
//     );
//   }
//
//   Widget _buildShareButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         // Handle QR code sharing
//       },
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//         backgroundColor: Colors.green,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text(
//         'Partager mon code Qr',
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLinkCardButton(BuildContext context) {
//     return OutlinedButton(
//       onPressed: (){
//         Navigator.of(context).pushNamed('/app/add_card');
//       },
//       style: OutlinedButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text(
//         'Lier ma carte',
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey.shade500,
//         ),
//       ),
//     );
//   }
// }
//
// class QrCodeScannerScreen extends StatefulWidget {
//   @override
//   _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
// }
//
// class _QrCodeScannerScreenState extends State<QrCodeScannerScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Barcode? result;
//   // final MobileScannerController controller = MobileScannerController();
//   MobileScannerController controller = MobileScannerController();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         title: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.green,
//           labelColor: Colors.green,
//           unselectedLabelColor: Colors.grey,
//           tabs: const [
//             Tab(text: 'Mon code'),
//             Tab(text: 'Scanner un code'),
//           ],
//         ),
//         elevation: 1,
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           BusinessCardScreen(),
//           Column(
//             children: [
//               Expanded(
//                 child: _buildQrView(context),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Row(
//                     children: [
//                       Icon(Icons.info, color: Colors.green),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           'Scanner le code Qr de votre correspondant pour voir son profil.',
//                           style: TextStyle(
//                             color: Colors.black87,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
// // Widget qui intègre le scanner QR réel
//   Widget _buildQrView(BuildContext context) {
//     return MobileScanner(
//       controller: controller,
//       onDetect: (BarcodeCapture capture) async {
//         final List<Barcode> barcodes = capture.barcodes;
//         final barcode = barcodes.first;
//
//         if (barcode.rawValue != null) {
//           // setResult(barcode.rawValue);
//           setState(() {
//             result = barcodes.first;
//           });
//           await controller
//               .stop()
//               .then((value) => controller.dispose())
//               .then((value) =>  print("dsdcsdsdc"));
//         }
//       },
//     );
//
//   }
//
//
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       controller.stop();
//     }
//     controller.start();
//   }
//
//
// }



import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_flutter/qr_flutter.dart';  // Add QR package

class BusinessCardScreen extends StatelessWidget {
  final String userQrData = "12345678922";  // Example user data for QR code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          _buildBusinessQrCard(userQrData),  // Pass user data to generate QR
          Spacer(),
          _buildShareButton(context),
          SizedBox(height: 10),
          _buildLinkCardButton(context),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildBusinessQrCard(String data) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: QrImageView(
          data: '12345678901',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle QR code sharing
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Partager mon code Qr',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLinkCardButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/app/add_card');
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Lier ma carte',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}

class QrCodeScannerScreen extends StatefulWidget {
  @override
  _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Barcode? result;
  MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Mon code'),
            Tab(text: 'Scanner un code'),
          ],
        ),
        elevation: 1,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BusinessCardScreen(),
          Column(
            children: [
              Expanded(
                child: _buildQrView(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Scanner le code Qr de votre correspondant pour voir son profil.',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) async {
        final List<Barcode> barcodes = capture.barcodes;
        final barcode = barcodes.first;

        if (barcode.rawValue != null) {
          setState(() {
            result = barcode;
          });
          await controller
              .stop()
              .then((value) => controller.dispose())
              .then((value) => print("QR Code Detected: ${barcode.rawValue}"));
        }
      },
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (defaultTargetPlatform == TargetPlatform.android) {
      controller.stop();
    }
    controller.start();
  }
}

