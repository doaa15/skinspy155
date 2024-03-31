// ignore_for_file: depend_on_referenced_packages, unused_import
//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authintcation_page.dart';

class Logo1 extends StatefulWidget {
  const Logo1({Key? key}) : super(key: key);

  @override
  State<Logo1> createState() => _Logo1State();
}

class _Logo1State extends State<Logo1> {
  bool opene1 = false;
  bool opene2 = false;
  bool opend3 = false;
  bool opend4 = false;
  // void preferencesGetter() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   preferences.setBool("logo", true);
  // }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opene1 = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        opene2 = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        opend3 = true;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const AuthintcationPage(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
                child: child,
              );
            },
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // CircleAvatar background and its animation
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
              child: !opene1
                  ? const SizedBox()
                  : AnimatedScale(
                      scale: opend3 ? 6 : 1,
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        width: 320.w,
                        height: 320.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff46A4FF),
                        ),
                      ),
                    )),
          // dontes animation
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
              child: opene1
                  ? SvgPicture.asset('assets/images/Group 14.svg')
                  : const SizedBox()),
          // content stack
          Stack(
            children: [
              //hat animation
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: opene2
                    ? Align(
                        alignment: const Alignment(-0.06, 0),
                        child:
                            SvgPicture.asset('assets/images/skinSpy-logog.svg'),
                      )
                    : const SizedBox(),
              ),
              // background to hide the scale naimation
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: !opene1
                    ? const SizedBox()
                    : Stack(
                        children: [
                          Align(
                            alignment: const Alignment(0, 0.01),
                            child: Container(
                              width: 110.w,
                              height: 40.h,
                              color: const Color(0xff46A4FF),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.14.w, 0),
                            child: Container(
                              width: 80.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xff46A4FF),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
              ),
              // s , kin , py and its animation
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          color: opene2 ? const Color(0xff46A4FF) : null),
                      child: SvgPicture.asset(
                        'assets/images/S.svg',
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: opene2 ? const Color(0xff46A4FF) : null,
                            ),
                            child: SvgPicture.asset('assets/images/kin.svg')),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: opene2 ? const Color(0xff46A4FF) : null,
                            ),
                            child: SvgPicture.asset('assets/images/py.svg')),
                      ],
                    )
                  ]),
            ],
          )
        ],
      ),
    );
  }
}
// SvgPicture.asset('assets/images/kin.svg'),
// SvgPicture.asset('assets/images/py.svg'),