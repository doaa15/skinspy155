// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CredentialsWidget extends StatelessWidget {
  String lable;
  String content;
  CredentialsWidget({
    Key? key,
    required this.lable,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
              fontSize: 14.sp),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          content,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp),
        )
      ],
    );
  }
}
