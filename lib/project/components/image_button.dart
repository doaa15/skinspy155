import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ImageButton extends StatefulWidget {
  const ImageButton({super.key, required this.picture, required this.ontap});
  final SvgPicture picture;
  final Function ontap;
  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        widget.ontap();
      },
      child: SizedBox(
        width: 30.w,
        height: 20.h,
        child: AnimatedScale(
            scale: clicked ? 4 : 1,
            duration: const Duration(milliseconds: 200),
            child: widget.picture),
      ),
    );
  }
}
