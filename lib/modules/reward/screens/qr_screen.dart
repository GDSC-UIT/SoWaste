import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/data/models/api_result.dart';

import '../reward_controller.dart';
import '../widgets/default_dialog.dart';
import '../widgets/qr_code_result_dialog.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final rewardController = Get.find<RewardController>();

  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) async {
        result = scanData;
        if (result != null) {
          controller.pauseCamera();
          var apiResult = await rewardController.postQrCode(result!.code!);
          switch (apiResult.runtimeType) {
            case SuccessResult:
              int point = (apiResult as SuccessResult).data as int;
              await Get.dialog(QrCodeResultDialog(point: point),
                  barrierDismissible: false);
              Get.back();
              break;
            case FailedResult:
              await defaultDialog(
                  title: "Failed",
                  content: "User have already scanned this QR code");
              controller.resumeCamera();
              break;
            case ErrorResult:
              await defaultDialog(title: "Error", content: "Invalid QR code");
              controller.resumeCamera();
              break;
          }
        }
      },
      onError: (error) => log(error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.secondary,
            size: 25,
          ),
        ),
        elevation: 1,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          height: context.height * 0.6,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 62),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              height: 82,
              width: 82,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: const Icon(
                Icons.camera_alt,
                color: AppColors.primary,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
