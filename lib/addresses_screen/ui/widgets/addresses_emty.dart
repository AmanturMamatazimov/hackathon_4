import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khanbuyer_new_design/utils/utils.dart';
import 'package:khanbuyer_new_design/widgets/widgets.dart';

class AddressesEmpty extends StatelessWidget {
  const AddressesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        h6,
        const CGreyText('У вас нет выбранных адресов'),
        h150,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SvgPicture.asset(
            Images.logo,
            fit: BoxFit.fitWidth,
          ),
        ),
        h150,
        h20,
      ],
    );
  }
}
