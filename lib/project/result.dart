// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skinspy/project/HomePage.dart';
import 'camera.dart';
import 'components/custom_button.dart';
import 'components/profile_button.dart';
import 'scaning.dart';

class Result extends StatefulWidget {
  final String prediction;
  const Result({
    Key? key,
    required this.prediction,
  }) : super(key: key);
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: 360.w,
              height: 360.h,
              color: Theme.of(context).colorScheme.primary,
            ),
            Center(
              child: SafeArea(
                child: Text(
                  "Result",
                  style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 88.h),
              width: 360.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.r),
                  topRight: Radius.circular(60.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 82.h, left: 17.w, right: 17.w),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 30.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.r),
                            child: Image.file(
                              ScanningScreen.image!,
                              fit: BoxFit.fill,
                              width: 280.w,
                              height: 260.h,
                              key: const ValueKey<String>(
                                  'imageLoaded'), // Unique key for the image
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 27.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Result:",
                                    style: TextStyle(fontSize: 19.sp),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                    Text(
                                      widget.prediction,
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xffEB5A5A),
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  SizedBox(
                                    height: 45.h,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileButton(
                              width: 140.w,
                              borderThickness: 1.5,
                              text: "Retake",
                              icon: null,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const CameraScreen(),
                                    transitionDuration:
                                        const Duration(milliseconds: 600),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation.drive(CurveTween(
                                            curve: Curves.easeInOut)),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              border: false,
                            ),
                            CustomButton(
                                borderRadias: BorderRadius.circular(5.r),
                                title: "home",
                                width: 140.w,
                                height: 42.h,
                                fontSize: 16.sp,
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const HomePage()),
                                      (Route route) => false);
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            )
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