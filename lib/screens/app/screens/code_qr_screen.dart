import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yecard/services/card_service.dart';
import '../../../models/card_model.dart';
import '../../../repositories/card_repository.dart';

class BusinessCardScreen extends StatefulWidget {
  const BusinessCardScreen({super.key});

  @override
  _BusinessCardScreenState createState() => _BusinessCardScreenState();
}

class _BusinessCardScreenState extends State<BusinessCardScreen> {
  final CardRepository _cardRepository = CardRepository(CardService());
  String? userQrData;

  @override
  void initState() {
    super.initState();
    _fetchCardData();
  }

  Future<void> _fetchCardData() async {
    try {
      final response = await _cardRepository.getCard();
      if (response['success']) {
        final cardData = CardData.fromJson(response['data'][0]);
        print("DATAGET ${response['data']}");
        setState(() {
          // userQrData = cardData.number;
          userQrData = cardData.number.isNotEmpty ? cardData.number : "";
        });
      } else {
        print("Error: ${response['message']}");
      }
    } catch (e) {
      print("Error fetching card data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          userQrData != null
              ? _buildBusinessQrCard(userQrData!)
              : const Center(child: Text("Vous n'avez pas encore de carte")),
          const Spacer(),
          _buildShareButton(context),
          const SizedBox(height: 10),
          if (userQrData == null)
            _buildLinkCardButton(context),

          const SizedBox(height: 50),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: QrImageView(
          data: data,
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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Partager mon code Qr',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildLinkCardButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/app/add_card');
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Lier ma carte',
        style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
      ),
    );
  }
}

// class QrCodeScannerScreen extends StatefulWidget {
//   @override
//   _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
// }
//
// class _QrCodeScannerScreenState extends State<QrCodeScannerScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Barcode? result;
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
//   Widget _buildQrView(BuildContext context) {
//     return MobileScanner(
//       controller: controller,
//       onDetect: (BarcodeCapture capture) async {
//         final List<Barcode> barcodes = capture.barcodes;
//         final barcode = barcodes.first;
//
//         if (barcode.rawValue != null) {
//           setState(() {
//             result = barcode;
//           });
//           await controller.stop().then((_) => controller.dispose()).then((_) {
//             print("QR Code Detected: ${barcode.rawValue}");
//
//             Navigator.of(context).pushNamed('/app/contact_profile',
//                 arguments: {
//                 'id': barcode.rawValue,
//
//                 },
//             );
//           });
//         }
//       },
//     );
//   }
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       controller.stop();
//     }
//     controller.start();
//   }
// }
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

    // Ecouter les changements d'onglets
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        // Redémarrer le scanner lorsque l'onglet "Scanner un code" est actif
        controller.start();
      } else {
        // Arrêter le scanner lorsque l'utilisateur quitte l'onglet de scan
        controller.stop();
      }
    });
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
          const BusinessCardScreen(),
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
          await controller.stop();  // Arrête le scanner après la détection d'un QR code
          print("QR Code Detected: ${barcode.rawValue}");

          Navigator.of(context).pushNamed('/app/contact_profile',
              arguments: {
                'id': barcode.rawValue,
              });
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
