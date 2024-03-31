import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinspy/project/HomePage.dart';

import 'scaning.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isInitialized = false;
  bool takeCliked = false;
  bool flipCliked = false;
  bool _isInitializing = false;
  bool _isFrontCamera = true; // Flag to track the current camera state

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    CameraDescription description =
        await availableCameras().then((cameras) => cameras[0]);
    _controller = CameraController(description, ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _isInitializing) {
      return Container(); // Show a loading indicator or an empty container while initializing
    }
    return Stack(
      children: [
        // Camera previews
        Stack(
          children: [
            // Zoomed camera view as background
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(_controller),
            ),
            // Centered camera view
          ],
        ),
        // Overlay content
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.3),
          child: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Center(
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (builder) => const HomePage()),
                                  (Route route) => false);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                        Spacer(),
                        SvgPicture.asset("assets/images/thander.svg"),
                        SizedBox(
                          width: 60.w,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Take a photo",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      letterSpacing: 0,
                      wordSpacing: 0,
                      fontSize: 30.h,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "2-4 (5-10 cm) from the object\nThe photo must be well-defined",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      letterSpacing: 0,
                      wordSpacing: 0,
                      fontSize: 14.h,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 200.h, left: 48.w),
          child: SizedBox(
            width: 270.w,
            height: 270.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CameraPreview(_controller),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 600.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.white), // Set the click color to white
                  ),
                  onPressed: () {
                    selectImageFromGallery().then((value) async {
                      if (ScanningScreen.image != null) {
                        await _controller.setFlashMode(FlashMode.off);
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ScanningScreen(),
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
                      }
                    });
                  },
                  child: Icon(
                    Icons.photo,
                    color: Colors.black,
                    size: 35.sp,
                  )),
              SizedBox(
                width: 60.w,
              ),
              GestureDetector(
                  onTapDown: (details) {
                    if (mounted) {
                      setState(() {
                        takeCliked = true;
                      });
                    }
                  },
                  onTapCancel: () {
                    if (mounted) {
                      setState(() {
                        takeCliked = false;
                      });
                    }
                  },
                  onTapUp: (details) {
                    if (mounted) {
                      setState(() {
                        takeCliked = false;
                      });
                    }
                    captureImage().then((value) async {
                      if (ScanningScreen.image != null) {
                        await _controller.setFlashMode(FlashMode.off);
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ScanningScreen(),
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
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/images/capture button.svg",
                    color: takeCliked ? Colors.white : null,
                  )),
              SizedBox(
                width: 77.w,
              ),
              GestureDetector(
                  onTapDown: (details) {
                    if (mounted) {
                      setState(() {
                        flipCliked = true;
                      });
                    }
                  },
                  onTapCancel: () {
                    if (mounted) {
                      setState(() {
                        flipCliked = false;
                      });
                    }
                  },
                  onTapUp: (details) {
                    if (mounted) {
                      setState(() {
                        flipCliked = false;
                      });
                      flipCamera();
                    }
                  },
                  child: SvgPicture.asset(
                    "assets/images/Switch camera.svg",
                    color: flipCliked ? Colors.white : null,
                  )),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> captureImage() async {
    try {
      final XFile? file = await _controller.takePicture();
      if (file != null) {
        // Create a File object from the XFile's path
        final File imageFile = File(file.path);

        // Assign the File object to ScanningScreen.image
        ScanningScreen.image = imageFile;
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  Future<void> selectImageFromGallery() async {
    try {
      // Create an instance of ImagePicker
      final ImagePicker _picker = ImagePicker();

      // Use the pickImage method to get an image from the gallery
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        // Create a File object from the XFile's path
        final File imageFile = File(file.path);

        // Assign the File object to ScanningScreen.image
        ScanningScreen.image = imageFile;
      }
    } catch (e) {
      print("Error selecting image from gallery: $e");
    }
  }

  Future<void> flipCamera() async {
    if (_isInitializing) return; // Prevent multiple initializations

    _isInitializing = true; // Set the flag to true

    // Get the list of available cameras
    final List<CameraDescription> cameras = await availableCameras();

    // Find the current camera description
    final CameraDescription currentCamera = _controller.description;

    // Determine the opposite camera based on the _isFrontCamera flag
    final CameraDescription oppositeCamera = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection != currentCamera.lensDirection,
      orElse: () =>
          currentCamera, // If no opposite camera is found, use the current camera
    );

    // Dispose of the current controller
    await _controller.dispose();

    // Initialize the new controller with the opposite camera
    _controller = CameraController(
      oppositeCamera,
      ResolutionPreset.medium,
    );

    // Initialize the new controller
    await _controller.initialize();

    // Update the state to reflect the new controller and toggle the camera state
    setState(() {
      _isFrontCamera = !_isFrontCamera; // Toggle the camera state
      _isInitialized = true; // Ensure the camera is marked as initialized
      _isInitializing = false; // Reset the flag
    });
  }
}
