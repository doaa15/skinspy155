//import 'package:flutter/cupertino.dart';
// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Congratulations.dart';

class ResentPassword extends StatefulWidget {
  const ResentPassword({Key? key}) : super(key: key);
  @override
  State<ResentPassword> createState() => _Logo1State();
}

class _Logo1State extends State<ResentPassword> {
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool obscure1 = true;
  bool obscure2 = true;

  bool clicked = false;

  @override
  void initState() {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible) {
        passwordFocusNode.unfocus();
        confirmPasswordFocusNode.unfocus();
      }
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
            //logo container
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400.h,
                  color: const Color(0xFF45A4FF),
                ),
                Align(
                    child: Padding(
                  padding: EdgeInsets.only(top: 55.h),
                  child: SvgPicture.asset(
                    'assets/images/Access denied.svg',
                    width: 180,
                  ),
                )),
              ],
            ),
            // content spacing from the logo
            Padding(
              padding: EdgeInsets.only(top: 190.h),
              //contents cotainer
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //-----------
                      SizedBox(
                        height: 20.h,
                      ),
                      //Text(Reset Password)
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 30.0.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff46A4FF),
                        ),
                      ),
                      //----------------------
                      SizedBox(
                        height: 10.h,
                      ),
                      //Text(Please enter your new password to)
                      const Text(
                        'Please enter your new password to',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      //Text(continue)
                      const Text(
                        'continue',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      //---------------------------
                      SizedBox(
                        height: 50.0.h,
                      ),
                      //TextFormField(password)
                      TextFormField(
                        focusNode: passwordFocusNode,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 17.sp, color: Colors.grey[500]),
                          floatingLabelStyle:
                              const TextStyle(color: Color(0xff46A4FF)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(158, 158, 158, 1)),
                            borderRadius: BorderRadius.circular(5.0.r),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'password:',
                          hintText: 'Enter Your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscure1 = !obscure1;
                              });
                            },
                            icon: Icon(
                                obscure1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[500]),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscure1,
                      ),
                      //-----------------------
                      const SizedBox(
                        height: 15.0,
                      ),
                      //TextFormField(confirm password)
                      TextFormField(
                        focusNode: confirmPasswordFocusNode,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 17.sp, color: Colors.grey[500]),
                          floatingLabelStyle:
                              const TextStyle(color: Color(0xff46A4FF)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(158, 158, 158, 1)),
                            borderRadius: BorderRadius.circular(5.0.r),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'confirm password:',
                          hintText: 'confirm Your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscure2 = !obscure2;
                              });
                            },
                            icon: Icon(
                                obscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[500]),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscure2,
                      ),
                      //--------------------------
                      SizedBox(
                        height: 150.0.h,
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
                                        const Congratulations(),
                                transitionDuration:
                                    const Duration(milliseconds: 150),
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
                              'Reset Password',
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
