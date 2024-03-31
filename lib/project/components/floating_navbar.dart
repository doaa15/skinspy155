// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FloatingNavBar extends StatefulWidget {
  Function onTap1;
  Function onTap2;
  String icon1;
  String icon2;
  FloatingNavBar({
    Key? key,
    required this.onTap1,
    required this.onTap2,
    required this.icon1,
    required this.icon2,
  }) : super(key: key);

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  bool clicked1 = false;
  bool clicked2 = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTapDown: (details) {
            if (mounted) {
              setState(() {
                clicked1 = true;
              });
            }
          },
          onTapCancel: () {
            if (mounted) {
              setState(() {
                clicked1 = false;
              });
            }
          },
          onTapUp: (details) {
            if (mounted) {
              setState(() {
                clicked1 = false;
              });
            }
            widget.onTap1();
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 13.h),
            width: 124.w,
            height: 53.h,
            decoration: BoxDecoration(
                color: clicked1
                    ? Theme.of(context).colorScheme.primary.darker(20)
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r))),
            child: Center(
              child: SvgPicture.asset(widget.icon1),
            ),
          ),
        ),
        GestureDetector(
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
            widget.onTap2();
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 13.h),
            width: 124.w,
            height: 53.h,
            decoration: BoxDecoration(
                color: clicked2
                    ? Theme.of(context).colorScheme.primary.darker(20)
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r))),
            child: Center(
              child: SvgPicture.asset(widget.icon2),
            ),
          ),
        ),
      ],
    );
  }
}
