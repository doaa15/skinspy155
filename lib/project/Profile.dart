import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:quickalert/quickalert.dart';
import 'package:skinspy/project/authintcation_page.dart';
import 'package:skinspy/project/components/credntials.dart';
import 'package:skinspy/project/login.dart';

import 'components/floating_navbar.dart';
import 'components/profile_button.dart';
import 'scan.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: ClampingScrollPhysics()),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: 400.h,
              color: const Color(0xFF45A4FF).lighter(5),
              child: SafeArea(
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 140.h),
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
                      height: 60.h,
                    ),
                    Text(
                      "Good Morning.",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      golbelAuth.currentUser!.displayName ?? "no name found",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 28.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Divider(
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 40.w),
                              child: Text(
                                "Personal Information",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 48.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CredentialsWidget(
                                    lable: "First Name",
                                    content: golbelAuth.currentUser!.displayName
                                            ?.split(" ")[0] ??
                                        "no name found",
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  CredentialsWidget(
                                    lable: "Last Name",
                                    content: golbelAuth.currentUser!.displayName
                                            ?.split(" ")[1] ??
                                        "no name found",
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  CredentialsWidget(
                                    lable: "Email",
                                    content:
                                        golbelAuth.currentUser!.email ?? "",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 26.w,
                                ),
                                ProfileButton(
                                  border: true,
                                  text: "Edit Profile",
                                  icon: "assets/images/Edit.svg",
                                  onTap: () {
                                    _showAlertDialog(context);
                                  },
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                ProfileButton(
                                  border: true,
                                  text: "Sign Out",
                                  icon: "assets/images/Sign Out.svg",
                                  onTap: () {
                                    golbelAuth.signOut();
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                const AuthintcationPage(),
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
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
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: Container(
                                height: 1,
                                width: 296.w,
                                color: Colors.grey[300],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 90.h),
              child:
                  Center(child: SvgPicture.asset("assets/images/profile.svg")),
            ),
            Padding(
              padding: EdgeInsets.only(top: 625.h),
              child: FloatingNavBar(
                icon1: "assets/images/Vector (2).svg",
                icon2: "assets/images/profile2.svg",
                onTap1: () {
                  Navigator.of(context).pop();
                },
                onTap2: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 605.h, left: 152.w),
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
                margin: EdgeInsets.only(top: 609.h, left: 156.w),
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        color: Theme.of(context).colorScheme.primary,
                        blurRadius: 0)
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
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    // TextEditingController emialController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Edit profile',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: SizedBox(
            width: 300.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelStyle:
                        TextStyle(fontSize: 17.sp, color: Colors.grey[500]),
                    floatingLabelStyle:
                        const TextStyle(color: Color(0xff46A4FF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(158, 158, 158, 1)),
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    labelText: 'First Name:',
                    hintText: 'Enter First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                    height: 20.h), // Add some space between the text fields
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelStyle:
                        TextStyle(fontSize: 17.sp, color: Colors.grey[500]),
                    floatingLabelStyle:
                        const TextStyle(color: Color(0xff46A4FF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(158, 158, 158, 1)),
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    labelText: 'Last name:',
                    hintText: 'Enter Last name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                // SizedBox(height: 20.h),
                // TextFormField(
                //   controller: emialController,
                //   decoration: InputDecoration(
                //     labelStyle:
                //         TextStyle(fontSize: 17.sp, color: Colors.grey[500]),
                //     floatingLabelStyle:
                //         const TextStyle(color: Color(0xff46A4FF)),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(
                //           color: Color.fromRGBO(158, 158, 158, 1)),
                //       borderRadius: BorderRadius.circular(5.0.r),
                //     ),
                //     hintStyle: TextStyle(color: Colors.grey[500]),
                //     labelText: 'email:',
                //     hintText: 'Enter email',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5.0.r),
                //     ),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Update'),
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  try {
                    if (user != null) {
                      // Update the display name
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return const PopScope(
                      //         canPop: false,
                      //         child: Center(
                      //           child: CircularProgressIndicator(),
                      //         ),
                      //       );
                      //     });
                      await user.updateDisplayName(
                          '${firstNameController.text} ${lastNameController.text}');
                      // await user.updateEmail(emialController.text);
                      setState(() {});
                      // Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                    // ignore: empty_catches
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                    // QuickAlert.show(
                    //     titleColor: const Color(0xff46A4FF),
                    //     textColor: const Color.fromRGBO(158, 158, 158, 1),
                    //     confirmBtnColor: const Color(0xFFDF0238),
                    //     backgroundColor: Colors.white,
                    //     context: context,
                    //     type: QuickAlertType.error,
                    //     title: "Erorr",
                    //     text:
                    //         "Something wnet wrong try again leater with the right user credential.");
                  }
                }),
            TextButton(
              child: Text(
                'Exit',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onPressed: () {
                // Handle the exit action
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
