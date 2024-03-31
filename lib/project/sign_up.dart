// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
// ignore: unused_import
import 'dart:developer';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skinspy/project/authintcation_page.dart';
import 'package:skinspy/project/login.dart';

import 'components/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _Logo1State();
}

class _Logo1State extends State<SignUp> {
  //
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  //
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emialFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool clicked = false;
  final regex = RegExp(r'^\p{Letter}+$', unicode: true);
  String errorCode = "";

  var msg = "";
  @override
  void initState() {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible) {
        firstNameFocusNode.unfocus();
        lastNameFocusNode.unfocus();
        emialFocusNode.unfocus();
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
            Container(
              alignment: const Alignment(0, -0.8),
              width: double.infinity,
              height: 400.h,
              color: const Color(0xff46A4FF),
              child: SafeArea(
                  child: SvgPicture.asset('assets/images/ss-login-icon.svg')),
            ),
            //content form logo spacing
            Padding(
              padding: EdgeInsets.only(top: 220.h),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 28.0.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        //first name
                        SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: firstNameFocusNode,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              labelStyle: TextStyle(
                                  fontSize: 17.sp, color: Colors.grey[500]),
                              floatingLabelStyle:
                                  const TextStyle(color: Color(0xff46A4FF)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                              labelText: 'First Name:',
                              hintText: 'Enter Your First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                            ),
                          ),
                        ),
                        //--------------------
                        SizedBox(
                          height: 10.0.h,
                        ),
                        //last name
                        SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            controller: lastNameController,
                            focusNode: lastNameFocusNode,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              labelStyle: TextStyle(
                                  fontSize: 17.sp, color: Colors.grey[500]),
                              floatingLabelStyle:
                                  const TextStyle(color: Color(0xff46A4FF)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                              labelText: 'Last Name:',
                              hintText: 'Enter Your Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        //----------------------
                        SizedBox(
                          height: 10.0.h,
                        ),
                        //emial
                        SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            focusNode: emialFocusNode,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              labelStyle: TextStyle(
                                  fontSize: 17.sp, color: Colors.grey[500]),
                              floatingLabelStyle:
                                  const TextStyle(color: Color(0xff46A4FF)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                              labelText: 'Email:',
                              hintText: 'Enter Your Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        //----------------------------------
                        SizedBox(
                          height: 10.0.h,
                        ),
                        //password
                        SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              labelStyle: TextStyle(
                                  fontSize: 17.sp, color: Colors.grey[500]),
                              floatingLabelStyle:
                                  const TextStyle(color: Color(0xff46A4FF)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                              labelText: 'password:',
                              hintText: 'Enter Your password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        //---------------------------
                        SizedBox(
                          height: 10.0.h,
                        ),
                        //confirm password
                        SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            focusNode: confirmPasswordFocusNode,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              labelStyle: TextStyle(
                                  fontSize: 17.sp, color: Colors.grey[500]),
                              floatingLabelStyle:
                                  const TextStyle(color: Color(0xff46A4FF)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                              labelText: 'Confirm password:',
                              hintText: 'Enter Your Confirm password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                            ),
                          ),
                        ),
                        //----------------------------------------
                        SizedBox(
                          height: 25.0.h,
                        ),
                        // signUp button
                        CustomButton(
                          title: 'Login',
                          width: 340.w,
                          height: 48.h,
                          fontSize: 20.0.sp,
                          onTap: () async {
                            if (firstNameController.text.trim().isEmpty ||
                                lastNameController.text.trim().isEmpty ||
                                emailController.text.trim().isEmpty ||
                                passwordController.text.trim().isEmpty ||
                                confirmPasswordController.text.trim().isEmpty) {
                              QuickAlert.show(
                                  titleColor: const Color(0xff46A4FF),
                                  textColor:
                                      const Color.fromRGBO(158, 158, 158, 1),
                                  confirmBtnColor: const Color(0xFFDF0238),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: "Missing information",
                                  text:
                                      "make sure that the either one of the fileds are not empty");
                            } else if (passwordController.text.trim() !=
                                confirmPasswordController.text.trim()) {
                              QuickAlert.show(
                                  titleColor: const Color(0xff46A4FF),
                                  textColor:
                                      const Color.fromRGBO(158, 158, 158, 1),
                                  confirmBtnColor: const Color(0xFFDF0238),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: "password inconsistency",
                                  text:
                                      "The password and confirm password fields do not match. Please ensure that both fields contain the same password.");
                            } else if (!regex.hasMatch(
                                    firstNameController.text.trim()) ||
                                !regex
                                    .hasMatch(lastNameController.text.trim())) {
                              QuickAlert.show(
                                  titleColor: const Color(0xff46A4FF),
                                  textColor:
                                      const Color.fromRGBO(158, 158, 158, 1),
                                  confirmBtnColor: const Color(0xFFDF0238),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: "wrong name ",
                                  text:
                                      "A name can only contain letters make sure that you dont have spical characters in it");
                            } else {
                              try {
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
                                UserCredential userCredential = await golbelAuth
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                User? user = userCredential.user;
                                await user?.updateDisplayName(
                                    '${firstNameController.text} ${lastNameController.text}');
                                errorCode = "";
                              } on FirebaseAuthException catch (e) {
                                errorCode = e.code;
                                log(e.toString());
                              }
                              Navigator.of(context).pop();
                              if (errorCode.isNotEmpty) {
                                validation(context);
                              }
                              if (errorCode == "") {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const AuthintcationPage(),
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
                            }
                          },
                        ),

                        //----------------------------
                        SizedBox(
                          height: 15.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Align(
              alignment: const Alignment(-0.93, -0.9),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  void validation(BuildContext context) {
    if (errorCode == "invalid-email") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "invalid email",
          text: "The email address is badly formatted.");
    } else if (errorCode == "weak-password") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "Weak password",
          text:
              "The password is not strong enough,password should be at least 6 characters");
    } else if (errorCode == "email-already-in-use") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "Email is taken",
          text: "The email address is already in use by another account");
    } else if (errorCode == "operation-not-allowed") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "operation not allowed",
          text: "email/password accounts are not enabled");
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
