import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khanbuyer_new_design/widgets/widgets.dart';

import '../../../../utils/utils.dart';

class AddressShader extends StatelessWidget {
  const AddressShader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ContainersShader(
            color: CColors.underlineInputDisabled,
          ),
          h12,
          const ContainersShader(
            color: CColors.underlineInputDisabled,
            paddingRight: 100,
          ),
          h12,
          const ContainersShader(
            color: CColors.underlineInputDisabled,
            paddingRight: 90,
          ),
          h12,
        ],
      ),
    );
  }
}
