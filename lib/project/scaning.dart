// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// import 'dart:developer';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skinspy/project/components/custom_button.dart';
import 'package:skinspy/project/components/profile_button.dart';
import 'package:skinspy/project/scan.dart';

import 'camera.dart';
import 'result.dart';

class ScanningScreen extends StatefulWidget {
  static File? image;
  const ScanningScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  bool cancel = false;
  bool opend = false;
  bool startScanning = false;
  bool startExpanding = false;
  bool opend2 = false;
  bool clicked = false;

  waitForPic() {
    return Future.delayed(Duration(milliseconds: opend ? 0 : 2000), () {
      opend = true;
    });
  }

  @override
  void initState() {
    waitForPic();
    Future.delayed(const Duration(seconds: 5), () {
      opend2 = true;
    });
    super.initState();
  }

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
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: startScanning ? 0 : 1,
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.only(left: startScanning ? 300.w : 0),
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                          const ScanScreen(),
                          transitionDuration: const Duration(milliseconds: 600),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation
                                  .drive(CurveTween(curve: Curves.easeInOut)),
                              child: child,
                            );
                          },
                        ),
                      );
                      ScanningScreen.image = null;
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
              ),
            ),
            SafeArea(
              child: Stack(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: startScanning ? 0 : 1,
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: startScanning
                          ? Alignment.topRight
                          : Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          "Spot",
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: startScanning ? 1 : 0,
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: startExpanding
                          ? Alignment.topCenter
                          : Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          "Scanning",
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  padding: EdgeInsets.only(top: 65.h, left: 18.w, right: 18.2),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              width: 3,
                              color: Theme.of(context).colorScheme.primary)),
                      child: opend2
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(7.r),
                        child: !startScanning
                            ? Image.file(
                          ScanningScreen.image!,
                          fit: BoxFit.fill,
                          width: 320.w,
                          height: 300.h,
                          key: const ValueKey<String>(
                              'imageLoaded'), // Unique key for the image
                        )
                            : AnimatedSwitcher(
                            duration:
                            const Duration(milliseconds: 2000),
                            transitionBuilder: (Widget child,
                                Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: !startExpanding
                                ? Container(
                              width: 320.w,
                              height: 300.h,
                              color: Colors.white,
                            )
                                : Image.file(
                              ScanningScreen.image!,
                              fit: BoxFit.fill,
                              width: 320.w,
                              height: 300.h,
                              key: const ValueKey<String>(
                                  'imageLoaded'), // Unique key for the image
                            )),
                      )
                          : FutureBuilder(
                        future: waitForPic(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Initialization is complete, so we can proceed with the navigation
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 600),
                              transitionBuilder: (Widget child,
                                  Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.r),
                                child: ScanningScreen.image != null
                                    ? Image.file(
                                  ScanningScreen.image!,
                                  fit: BoxFit.fill,
                                  width: 320.w,
                                  height: 300.h,
                                  key: const ValueKey<String>(
                                      'imageLoaded'), // Unique key for the image
                                )
                                    : const SizedBox(),
                              ),
                            );
                          } else {
                            // Initialization is not complete, so we show a loading indicator
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 600),
                              transitionBuilder: (Widget child,
                                  Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                width: 300.w,
                                height: 300.h,
                                key: const ValueKey<String>(
                                    'loadingIndicator'),
                                child: const Center(
                                    child: Text(
                                        "please wait")), // Unique key for the loading indicator
                              ),
                            );
                          }
                        },
                      ))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 480.h),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: startScanning
                    ? AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: startExpanding ? 1 : 0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "LOADING",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color:
                              Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 240.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(50.r),
                                  border: Border.all(
                                      color: Colors.grey[600]!,
                                      width: 1)),
                            ),
                            AnimatedContainer(
                              width: startExpanding ? 240.w : 24.w,
                              height: 16.h,
                              duration:
                              const Duration(milliseconds: 3000),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xff133596),
                                  Color(0xff45A4FF),
                                ]),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Please wait.......",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color:
                              Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                )
                    : AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: startScanning ? 0 : 1,
                  child: Center(
                    child: Text(
                      "Press the “next” button so that the image is\n  checked by the app and show the result",
                      style: TextStyle(
                          fontSize: 15.sp, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 630.h),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: startScanning
                    ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 18.w),
                      child: GestureDetector(
                        onTapDown: (details) {
                          if (mounted) {
                            setState(() {
                              clicked = true;
                            });
                          }
                        },
                        onTapCancel: () {
                          if (mounted) {
                            setState(() {
                              clicked = false;
                            });
                          }
                        },
                        onTapUp: (details) {
                          setState(() {
                            clicked = false;
                            startExpanding = false;
                            cancel = true;
                          });
                          Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                setState(() {
                                  startScanning = false;
                                });
                              });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: startExpanding ? 320.w : 147.w,
                          height: 42.h,
                          decoration: BoxDecoration(
                              color: clicked
                                  ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .lighter(5)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                  width: 1.5.w,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .lighter(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cancle",
                                style: TextStyle(
                                    color: clicked
                                        ? Colors.white
                                        : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .lighter(5),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileButton(
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
                                opacity: animation.drive(
                                    CurveTween(curve: Curves.easeInOut)),
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
                        title: "scan",
                        width: 155.w,
                        height: 42.h,
                        fontSize: 16.sp,
                        onTap: () async {
                          setState(() {
                            startScanning = true;
                            cancel = false;
                          });
                          Future.delayed(
                              const Duration(milliseconds: 200), () {
                            setState(() {
                              startExpanding = true;
                            });
                          });
                          log("starting");
                          String prediction = await _getPrediction(
                              context, ScanningScreen.image);

                          prediction = prediction.isEmpty
                              ? prediction
                              : prediction;
                          log("ssss: $prediction:dddd");
                          Future.delayed(const Duration(seconds: 4), () {
                            if (startScanning && startExpanding) {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                      Result(prediction: prediction),
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
                            }
                          });
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

/////////////////////////////////////////
  Future<String> _getPrediction(BuildContext context, File? image) async {
    String prediction = "";
    try {
      // Download the model from Firebase
      //1

      final model = await FirebaseModelDownloader.instance.getModel(
        "model15", // Your model name in Firebase
        FirebaseModelDownloadType.localModelUpdateInBackground,
        FirebaseModelDownloadConditions(
          iosAllowsCellularAccess: true,
          iosAllowsBackgroundDownloading: false,
          androidChargingRequired: false,
          androidWifiRequired: false,
          androidDeviceIdleRequired: false,
        ),
      );

      // Load the labels from assets
      //2

      final labelsPath = await _saveLabelsToFile();

      // Load the TFLite model
      //3
      String s = await Tflite.loadModel(
        model: model.file.path,
        labels: labelsPath,
        numThreads: 1,
        isAsset: false,
        useGpuDelegate: false,
      ) ??
          'not loded';

      // Get the image file path
      //4
      final filepath = image != null ? image.path : "";
      log("model: ${model.name}");
      log("labelsPath: $labelsPath");
      log(" image file path: $filepath");
      log("model load:$s");
      // Run model on the image
      final recognitions = await Tflite.runModelOnImage(
        path: filepath,
        imageMean: 117.0,
        imageStd: 255.0,
        numResults: 7,
        threshold: 0.5,
        asynch: true,
      );
      if (recognitions != null && recognitions.isNotEmpty) {
        // Get the prediction label and confidence
        prediction = "${_getPredictionLabel(recognitions[0]["label"])} with confidence ${_getConfidence(recognitions[0]["confidence"])}";
        log("Prediction: $prediction");
      } else {
        log("No recognitions found.");
      }
    } catch (error) {
      log("Error: ${error.toString()}"); // Custom error message
    } finally {
      Tflite.close();
    }


    return prediction;
  }

  String _getPredictionLabel(String label) {
    switch (label) {
      case "melanocytic nevi":
        return "melanocytic nevi";
      case "melanoma":
        return "melanoma";
      case "benign keratosis-like lesions":
        return "benign keratosis-like lesions";
      case "basal cell carcinoma":
        return "basal cell carcinoma";
      case "pyogenic granulomas and hemorrhage":
        return "pyogenic granulomas and hemorrhage";
      case "Actinic keratoses and intraepithelial carcinomae":
        return "Actinic keratoses and intraepithelial carcinomae";
      case "dermatofibroma":
        return "dermatofibroma";
      default:
        return label;
    }
  }

  String _getConfidence(double confidence) {
    confidence *= 100;
    if (confidence < 90) {
      return confidence.toStringAsFixed(0);
    }

    return "Above 90";
  }

  Future<String> _saveLabelsToFile() async {
    // Load the contents of labels.txt from assets
    String labelsContent =
    await rootBundle.loadString('assets/images/labels.txt');

    // Get the application documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Create the file path
    String filePath = '${documentsDirectory.path}labels.txt';

    // Write the contents to the file
    File labelsFile = File(filePath);
    await labelsFile.writeAsString(labelsContent);

    return filePath;
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

