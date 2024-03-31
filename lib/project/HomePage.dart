import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:skinspy/project/Profile.dart';
import 'package:skinspy/project/components/custom_button.dart';
import 'package:skinspy/project/scan.dart';
import 'components/floating_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool clicked = false;
  bool clicked2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r))),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Text(
            "Home page",
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Image.asset(
                      'assets/images/Rectangle 16.png',
                      fit: BoxFit.fill,
                      width: 500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 28.w),
                    child: Text(
                      "Don’t waste your time!",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 45.h, left: 30),
                    child: SizedBox(
                      width: 200.w,
                      child: Text(
                        "With SkinSpy you can find a suspicious moles\nfaster than visit a doctor. It is so simple!",
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 17.w, top: 13.h),
                child: Text(
                  "Why is SkinSpy worth using?",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 3.h, right: 16.w),
                child: SvgPicture.asset(
                  'assets/images/Group 32.svg',
                  width: 350.w,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Image.asset(
                      "assets/images/Rectangle 20.png",
                      width: 350.w,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 20.h),
                    child: Text("Say No To Skin Diseases!",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 50.h),
                    child: Text(
                        "Check your skin on the smartphone and get\n instant results in a few seconds>",
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.w, top: 50.h),
                    child: SvgPicture.asset(
                      "assets/images/5-fifth pic Rectangle 21@2x.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 49.h, left: 201.w),
                    child: Image.asset("assets/images/Rectangle 21.png"),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 78.h, left: 27.w),
                      child: CustomButton(
                        borderRadias: BorderRadius.circular(7.r),
                        title: "CHECK YOUR SKIN NOW",
                        width: 115.w,
                        height: 22.h,
                        fontSize: 7.sp,
                        onTap: () {
                          setState(() {
                            clicked2 = true;
                          });
                          Future.delayed(const Duration(milliseconds: 400), () {
                            setState(() {
                              clicked2 = false;
                            });
                          });
                          Future.delayed(const Duration(milliseconds: 800), () {
                            setState(() {
                              clicked2 = true;
                            });
                          });
                          Future.delayed(const Duration(milliseconds: 1200),
                              () {
                            setState(() {
                              clicked2 = false;
                            });
                          });
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 112.h, left: 22.w),
                    child: Text(
                      "* The scan result is not a diagnosis. To obtain an accurate diagnosis and a recommendation for treatment - consult your doctor.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 5.sp),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 20.w),
                child: SvgPicture.asset("assets/images/how-to-use.svg"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 16.w),
                child: Text(
                  "SkinSpy aims to help you instantly monitor your skin health.",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                width: 343.w,
                height: 95.h,
                decoration: BoxDecoration(
                    color: const Color(0xff104893),
                    borderRadius: BorderRadiusDirectional.circular(10.r)),
                child: Text(
                  "The AI-powered app engine compares skin spots with disease indications from its wide database enabling the app to detect skin disease at an early stage which is crucial for timely treatment.\n\nOur goal is to increase the importance of skin disease awareness and help individuals trace their skin changes to get to the doctor in time.",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 9.sp),
                ),
              ),
              SizedBox(
                height: 130.h,
              ),
            ],
          )),
          Padding(
            padding: EdgeInsets.only(top: 550.h),
            child: FloatingNavBar(
              icon1: "assets/images/Vector (1).svg",
              icon2: "assets/images/Layer 2.svg",
              onTap1: () {},
              onTap2: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const Profile(),
                    transitionDuration: const Duration(milliseconds: 300),
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
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 530.h, left: 152.w),
            width: 58.w,
            height: 58.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: clicked
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
            ),
          ),
          GestureDetector(
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
              if (mounted) {
                setState(() {
                  clicked = false;
                });
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const ScanScreen(),
                    transitionDuration: const Duration(milliseconds: 300),
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
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: EdgeInsets.only(top: 534.h, left: 156.w),
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: clicked2 ? 3 : 0,
                      color: Theme.of(context).colorScheme.primary,
                      blurRadius: clicked2 ? 10 : 0)
                ],
                shape: BoxShape.circle,
                color: clicked
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/scan.svg",
                  color: clicked
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
