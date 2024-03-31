//import 'package:bata/modules/project/LOGO1.dart';
//import 'logo2.dart';
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'logo3.dart';

class Logo2 extends StatefulWidget {
  const Logo2({Key? key}) : super(key: key);

  @override
  State<Logo2> createState() => _Logo2State();
}

class _Logo2State extends State<Logo2> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Logo3(),
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const CircleAvatar(radius: 180, backgroundColor: Color(0xff46A4FF)),
            SvgPicture.asset('assets/images/Group 14.svg'),
            SvgPicture.asset('assets/images/skinSpy-logog.svg'),
          ],
        ),
      ),
    );
  }
}
