// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login.dart';

class Logo3 extends StatefulWidget {
  const Logo3({Key? key}) : super(key: key);

  @override
  State<Logo3> createState() => _Logo1State();
}

class _Logo1State extends State<Logo3> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xff46A4FF),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const CircleAvatar(
              radius: 180,
              backgroundColor: Color(0xff46A4FF),
            ),
            SvgPicture.asset('assets/images/Group 14.svg'),
            SvgPicture.asset('assets/images/skinSpy-logog.svg'),
          ],
        ),
      ),
    );
  }
}
