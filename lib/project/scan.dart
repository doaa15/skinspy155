import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skinspy/project/components/custom_button.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skinspy/project/scaning.dart';

import 'camera.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/images/Vector 2.svg",
              width: 360.w,
            ),
            SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Instructions",
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 145.h),
                child: Center(
                    child: SvgPicture.asset("assets/images/Frame 43.svg"))),
            // _imageFile != null
            //     ? Image.file(_imageFile!)
            //     : const Text('No image selected.'),
            Padding(
                padding: EdgeInsets.only(top: 620.h),
                child: Center(
                  child: CustomButton(
                      icon: "assets/images/scan.svg",
                      title: "Start Scan",
                      width: 216.w,
                      height: 48.h,
                      fontSize: 18.sp,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const CameraScreen(),
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation
                                    .drive(CurveTween(curve: Curves.easeInOut)),
                                child: child,
                              );
                            },
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String filePath =
          '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final File newImageFile = await File(imageFile.path).copy(filePath);

      setState(() {
        ScanningScreen.image = newImageFile;
      });
    }
  }
}
