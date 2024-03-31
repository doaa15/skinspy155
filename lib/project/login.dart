//import 'package:bata/modules/project/%D9%85%D9%85.dart';
// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skinspy/project/components/image_button.dart';
import 'authintcation_page.dart';
import 'components/custom_button.dart';
import 'forget password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'modules/provider.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Logo1State();
}

class _Logo1State extends State<Login> {
  String errorCode = "";
  String msg = "";
  bool rememberMe = false;
  // bool opened = false;
  bool obscure = true;
  bool clicked = false;
  FocusNode emialFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool clicked2 = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double screenWidth = 0;

  double screenHeight = 0;

  void remmberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", emailController.text);
    prefs.setString("password", passwordController.text);
  }

  void dontRremmberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void getRememperdEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? "";
    passwordController.text = prefs.getString('password') ?? "";
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        Provider.of<SkinfPyProvider>(context, listen: false).setBoolOpend();
      }
    });
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible) {
        emialFocusNode.unfocus();
        passwordFocusNode.unfocus();
      }
    });
    Future.delayed(const Duration(milliseconds: 1), () {
      if (mounted) {
        Provider.of<SkinfPyProvider>(context, listen: false).setboolstopLogo();
      }
    });
    getRememperdEmailAndPassword();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: ClampingScrollPhysics()),
        child: Stack(
          children: [
            //the logo and its backgorund + animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 550),
              alignment: Provider.of<SkinfPyProvider>(context).opend
                  ? const Alignment(0, -1)
                  : const Alignment(0, 1),
              width: double.infinity,
              height: screenHeight <= 680 ? 400.h : 500.h,
              color: const Color(0xff46A4FF),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SvgPicture.asset('assets/images/Group 14.svg',
                          width: (screenWidth <= 380 && screenHeight <= 680)
                              ? 150.w
                              : null),
                      SvgPicture.asset('assets/images/skinSpy-logog.svg',
                          width: (screenWidth <= 380 && screenHeight <= 680)
                              ? 90.w
                              : 110.w),
                    ],
                  ),
                ),
              ),
            ),
            //logging content
            AnimatedOpacity(
              opacity: Provider.of<SkinfPyProvider>(context).opend ? 1 : 0,
              duration: const Duration(milliseconds: 550),
              child: AnimatedPadding(
                // aspace between both the content and the logo
                padding: Provider.of<SkinfPyProvider>(context).opend
                    ? EdgeInsets.only(
                        top: (screenWidth <= 380 && screenHeight <= 680)
                            ? 180.h
                            : 210.h)
                    : EdgeInsets.only(
                        top: (screenWidth <= 380 && screenHeight <= 680)
                            ? 210.h
                            : 230.h),
                duration: const Duration(milliseconds: 550),
                child: Container(
                  width: double.infinity,
                  //curved raduis for both top left and right
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(50.0.r),
                      topEnd: Radius.circular(50.0.r),
                    ),
                  ),
                  //-----------------------------
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      // login lable
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: (screenWidth <= 380 && screenHeight <= 680)
                              ? 25.sp
                              : 30.0.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff46A4FF),
                        ),
                      ),
                      //----------------------
                      SizedBox(
                        height: 35.0.h,
                      ),
                      //Email text Field
                      SizedBox(
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 55.h
                            : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              labelText: 'Email:',
                              hintText: 'Enter Your Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey[500],
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      //-----------------------------
                      SizedBox(
                        height: 10.h,
                      ),
                      // password text Field
                      SizedBox(
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 55.h
                            : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: TextFormField(
                            controller: passwordController,
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
                                  if (mounted) {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  }
                                },
                                icon: Icon(
                                    obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey[500]),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscure,
                          ),
                        ),
                      ),
                      // row of Checkbox , remmber me text , and a button (forget bassword)
                      Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 1.0.w,
                                      color: rememberMe
                                          ? const Color(0xff46A4FF)
                                          : const Color.fromRGBO(
                                              158, 158, 158, 1)),
                                ),
                                checkColor: Colors.white,
                                value: rememberMe,
                                onChanged: (bool? value) {
                                  if (mounted) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  }
                                },
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: rememberMe
                                        ? const Color(0xff46A4FF)
                                        : Colors.grey[500]),
                              ),
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const ForgotPassword(),
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
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Color(0xff46A4FF),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xff46A4FF)),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                      //------------------------
                      SizedBox(
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 5.h
                            : 10,
                      ),
                      //login button
                      CustomButton(
                        title: 'Login',
                        width: 340.w,
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 45.h
                            : 48.h,
                        fontSize: 20.0.sp,
                        onTap: () async {
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
                          try {
                            await golbelAuth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            errorCode = "";
                            if (rememberMe) {
                              remmberMe();
                            } else {
                              dontRremmberMe();
                            }
                            // Move the navigation logic here
                            Navigator.of(context).pop();
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
                          } on FirebaseAuthException catch (e) {
                            errorCode = e.code;
                            msg = e.message.toString();
                            log('Failed with error code: ${e.code}');
                            log(e.message.toString());
                            Navigator.of(context).pop();
                            if (errorCode.isNotEmpty) {
                              validation(context);
                            }
                          }
                        },
                      ),
                      //---------------------
                      SizedBox(
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 10.h
                            : 20.0.h,
                      ),
                      //dvider -or- dvider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150.w,
                            height: 2.0.h,
                            color: Colors.grey[400],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'or',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 150.w,
                            height: 2.0.h,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                      //-----------------------------
                      SizedBox(height: 15.h),
                      //Social media login text
                      const Text('Social media login',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center),
                      //--------------------------
                      SizedBox(
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 8.h
                            : 15.0.h,
                      ),
                      // apple google facebook svg
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          //apple login
                          ImageButton(
                              picture:
                                  SvgPicture.asset('assets/images/apple.svg'),
                              ontap: () {
                                //apple login
                                log("message");
                              }),
                          //----------------
                          SizedBox(
                            width: 10.0.w,
                          ),
                          //google login
                          ImageButton(
                              picture:
                                  SvgPicture.asset('assets/images/Google.svg'),
                              ontap: () async {
                                //google login
                                return await googleLogin();
                              }),
                          //------------------
                          SizedBox(
                            width: 10.0.w,
                          ),
                          //facebook login
                          ImageButton(
                              picture: SvgPicture.asset(
                                  'assets/images/Facebook.svg'),
                              ontap: () async {
                                await signInWithFacebook();
                              }),
                          //--------------------
                          SizedBox(
                            width: 10.0.w,
                          ),
                        ],
                      ),
                      //--------------
                      SizedBox(
                        height: (screenWidth <= 380 && screenHeight <= 680)
                            ? 20.h
                            : 25.0.h,
                      ),
                      // regestir button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ? ',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 13.sp),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          InkWell(
                            onTapDown: (details) {
                              if (mounted) {
                                setState(() {
                                  clicked2 = true;
                                });
                              }
                            },
                            onTapCancel: () {
                              if (mounted) {
                                setState(() {
                                  clicked2 = false;
                                });
                              }
                            },
                            onTapUp: (details) {
                              if (mounted) {
                                setState(() {
                                  clicked2 = false;
                                });
                              }

                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const SignUp(),
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
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  color: clicked2
                                      ? const Color(0xff46A4FF).darker(20)
                                      : const Color(0xff46A4FF)),
                            ),
                          ),
                        ],
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

  signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      log(e.toString());
    }
    // Trigger the sign-in flow
  }

  googleLogin() async {
    try {
      await GoogleSignIn().signOut();
      // interact with google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //loading
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
      //obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      // create a credentials
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      //sign in with credentials
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => const AuthintcationPage()),
          (Route route) => false);
    } catch (e) {
      log(e.toString());
      // errorCode = "Error";
      // msg = "something went worng try again later";
      // validation(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => const AuthintcationPage()),
          (Route route) => false);
    }
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
    } else if (errorCode == "user-disabled") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "user disabled",
          text: "The email address of this user has been disabled");
    } else if (errorCode == "invalid-credential") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "invalid credential",
          text:
              "The credential of this account is worng, check your email and password");
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
    } else if (errorCode == "wrong-password") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "Wrong password",
          text:
              "The password is invalid or the user does not have a password.");
    } else if (errorCode == "user-not-found") {
      QuickAlert.show(
          titleColor: const Color(0xff46A4FF),
          textColor: const Color.fromRGBO(158, 158, 158, 1),
          confirmBtnColor: const Color(0xFFDF0238),
          backgroundColor: Colors.white,
          context: context,
          type: QuickAlertType.error,
          title: "User not found",
          text:
              "There is no user record corresponding to this identifier. The user may have been deleted.");
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

final FirebaseAuth golbelAuth = FirebaseAuth.instance;
