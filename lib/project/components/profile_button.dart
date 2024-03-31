// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatefulWidget {
  int? duration;
  double? width;
  double? hight;
  String text;
  String? icon;
  Function onTap;
  double? borderThickness;
  bool? border = true;
  ProfileButton({
    Key? key,
    this.duration,
    this.border,
    this.width,
    this.hight,
    this.borderThickness,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          widget.onTap();
        }
      },
      child: Container(
        width: widget.width ?? 147.w,
        height: widget.hight ?? 42.h,
        decoration: BoxDecoration(
            color: clicked
                ? Theme.of(context).colorScheme.primary.lighter(5)
                : Colors.white,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
                width: widget.borderThickness ?? 2.5.w,
                color: (clicked && widget.border!)
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary.lighter(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                  color: clicked
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary.lighter(5),
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
            SizedBox(
              width: 4.w,
            ),
            widget.icon != null
                ? SvgPicture.asset(
                    widget.icon!,
                    color: clicked ? Colors.white : null,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
