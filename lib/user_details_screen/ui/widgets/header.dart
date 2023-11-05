import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repository/repository.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class UserHeader extends StatelessWidget {
  const UserHeader(this.shop, {super.key});
  final Shop shop;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(null),
        w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: 'Продавец: ',
                    style: TextStyle(color: CColors.grey, fontSize: 12.sp),
                    children: [
                      TextSpan(
                        text: shop.title,
                        style: TextStyle(
                          color: CColors.text,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ]),
              ),
              h4,
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: 'Зарегистрирован: ',
                    style: TextStyle(color: CColors.grey, fontSize: 12.sp),
                    children: [
                      TextSpan(
                        // text: shop.user.createdDate,
                        text: '?',
                        style: TextStyle(
                          color: CColors.text,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
