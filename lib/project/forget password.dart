// ignore_for_file: file_names, depend_on_referenced_packages, use_build_context_synchronously

//import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skinspy/project/Congratulations.dart';
import 'package:skinspy/project/components/custom_button.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _Logo1State();
}

class _Logo1State extends State<ForgotPassword> {
  FocusNode emialFocusNode = FocusNode();

  bool clicked = false;
  var code = "";
  var emailController = TextEditingController();

  var errorCode = "";

  var msg = "";
  var userSignInMethods = [];
  @override
  void initState() {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible) {
        emialFocusNode.unfocus();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //     backgroundColor: const Color(0xFF45A4FF),
      //     leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: const Icon(Icons.arrow_back_ios),
      //     ),
      //     elevation: 0.0),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: ClampingScrollPhysics()),
        child: Stack(
          children: [
            Container(
              height: 250.h,
              width: double.infinity,
              color: const Color(0xFF45A4FF),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  // const CircleAvatar(
                  //   radius: 180,
                  //   backgroundColor: Color(0xFF45A4FF),
                  // ),
                  SvgPicture.asset('assets/images/Sign Up form.svg'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200.h),
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
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Forgot Password',
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
                      'Please enter your email so we can',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'send you a verification code',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 40.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: emialFocusNode,
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
                          labelText: 'Email',
                          hintText: '@example.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                          ),
                          suffixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color.fromRGBO(158, 158, 158, 1),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(
                      height: 130.0.h,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 60.h),
                          child: CustomButton(
                              title: "Send rest code",
                              width: 340.w,
                              height: 48.h,
                              fontSize: 18.sp,
                              onTap: () async {
                                try {
                                  //CircularProgressIndicator
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const PopScope(
                                          canPop: false,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      });
                                  // rest password rotuine
                                  await resetPassword();
                                  //Exception
                                } on FirebaseAuthException catch (e) {
                                  errorCode = e.code;
                                  msg = e.message.toString();
                                  log("${e.code} MM");
                                }
                                //pop the CircularProgressIndicator
                                Navigator.of(context).pop();
                                log("${errorCode}no error code");
                                // alert dialog for erros
                                if (errorCode.isNotEmpty) {
                                  validation(context);
                                }
                                if (errorCode.isEmpty) {
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                const Congratulations(),
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
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 60.h),
                          height: 50.0.h,
                          color: Colors.white,
                          width: double.infinity,
                          child: OutlinedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Color(0xff46A4FF), width: 2))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back to Login ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blue,
                                fontSize: 17.0.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    userSignInMethods =
        await golbelAuth.fetchSignInMethodsForEmail(emailController.text);
    if (userSignInMethods.isNotEmpty) {
      errorCode = "";
      log("message: user found");
      golbelAuth.sendPasswordResetEmail(email: emailController.text);
    } else if (userSignInMethods.isEmpty) {
      errorCode = "";
    }
  }

  validation(BuildContext context) {
    if (userSignInMethods.isEmpty && errorCode == "") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "No user found",
          text:
              "The system could not find a user associated with the provided email address. Please ensure that you have previously logged in with this email.");
    } else if (errorCode == "invalid-email") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "invalid email",
          text: "The email address is badly formatted.");
    } else if (errorCode == "channel-error") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "Missing information",
          text:
              "make sure that the fileds of the email and password are not empty");
    } else if (errorCode == "network-request-failed") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "connection is poor",
          text: "check your network connectivity and try agrain later");
    } else {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: errorCode,
          text: msg);
    }
  }
}
