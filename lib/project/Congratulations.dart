//import 'package:flutter/cupertino.dart';
// ignore_for_file: depend_on_referenced_packages, file_names
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({Key? key}) : super(key: key);
  @override
  State<Congratulations> createState() => _Logo1State();
}

class _Logo1State extends State<Congratulations> {
  bool clicked = false;
  bool opened = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        opened = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: ClampingScrollPhysics()),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400.h,
              color: const Color(0xFF45A4FF),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(top: opened ? 150.h : 180.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(50.0.r),
                    topEnd: Radius.circular(50.0.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.0.h,
                      ),
                      SvgPicture.asset('assets/images/Success Tick (1).svg'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Congratulations',
                        style: TextStyle(
                          fontSize: 30.0.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'We\'ve set a rest link to your email,',
                        style: TextStyle(
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'check your emial address',
                        style: TextStyle(
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 140.0.h,
                      ),
                      InkWell(
                        onTapDown: (details) {
                          setState(() {
                            clicked = true;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            clicked = false;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            clicked = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const Login(),
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
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: clicked
                                ? const Color(0xff46A4FF).darker(20)
                                : const Color(0xff46A4FF),
                          ),
                          width: 340.w,
                          height: 48.h,
                          child: Center(
                            child: Text(
                              'done',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 20.0.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
