//import 'package:flutter/cupertino.dart';
// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Reset_Password.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _Logo1State();
}

class _Logo1State extends State<Verification> {
  bool clicked1 = false;
  var clicked2 = false;
  bool compeleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SingleChildScrollView for the scrolling
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: ClampingScrollPhysics()),
        child: Stack(
          children: [
            // logo + background
            Container(
              width: double.infinity,
              height: 400.h,
              color: const Color(0xFF45A4FF),
              child: Padding(
                padding: EdgeInsets.only(top: 30.h, bottom: 100.h),
                child: SvgPicture.asset(
                  'assets/images/tasklist.svg',
                ),
              ),
            ),
            //content spacing from the logo
            Padding(
              padding: EdgeInsets.only(top: 270.h),
              //Container of contets
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(50.0.r),
                    topEnd: Radius.circular(50.0.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // text (Verification)
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Text(
                        'Verification',
                        style: TextStyle(
                          fontSize: 28.0.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff46A4FF),
                        ),
                      ),
                    ),
                    //-----------------------------
                    SizedBox(
                      height: 15.h,
                    ),
                    //text(We have send you a code to verify)
                    Text(
                      'We have send you a code to verify',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    //text (your email address)
                    Text(
                      'your email address',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    //---------------------------
                    SizedBox(
                      height: 50.0.h,
                    ),
                    //VerificationCode keybord
                    SizedBox(
                      width: 300.w,
                      child: PinCodeTextField(
                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          selectedFillColor: Colors.grey[300],
                          inactiveFillColor: Colors.grey[300],
                          inactiveColor: Colors.grey[300],
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 52.w,
                          fieldWidth: 45.h,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {
                          setState(() {
                            compeleted = true;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            value.length < 4
                                ? compeleted = false
                                : compeleted = true;
                          });
                        },
                      ),
                    ),
                    //----------------------------------------
                    SizedBox(
                      height: 15.0.h,
                    ),
                    //text + button (Don\'t have an account?+Resend Code )
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0.sp,
                          ),
                        ),
                        InkWell(
                          onTapDown: (details) {
                            setState(() {
                              clicked1 = true;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              clicked1 = false;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              clicked1 = false;
                            });
                          },
                          child: Text(
                            ' Resend Code',
                            style: TextStyle(
                              color: clicked1
                                  ? const Color(0xff46A4FF).darker(20)
                                  : const Color(0xff46A4FF),
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //------------------
                    SizedBox(
                      height: 90.0.h,
                    ),
                    //verfiy
                    InkWell(
                      onTapDown: (details) {
                        setState(() {
                          if (compeleted) {
                            clicked2 = true;
                          }
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          if (compeleted) {
                            clicked2 = false;
                          }
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          if (compeleted) {
                            clicked2 = false;
                          }
                        });

                        if (compeleted) {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const ResentPassword(),
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: !compeleted
                              ? Colors.grey[300]
                              : clicked2
                                  ? const Color(0xff46A4FF).darker(20)
                                  : const Color(0xff46A4FF),
                        ),
                        margin: EdgeInsets.only(top: 10.h),
                        width: 340.w,
                        height: 48.h,
                        child: Center(
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20.0.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.h),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
