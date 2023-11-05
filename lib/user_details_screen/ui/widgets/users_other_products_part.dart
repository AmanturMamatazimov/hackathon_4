import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khanbuyer_new_design/utils/utils.dart';

import '../../../../widgets/widgets.dart';
import '../../user_details_screen.dart';

class UserOtherProducts extends StatelessWidget {
  const UserOtherProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CTitlePoppins(
          'Каталог продавца',
          size: 12,
          fwt: FontWeight.w600,
        ),
        BlocConsumer<UserFilterProductsBloc, UserFilterProductsState>(
          listener: (context, state) {
            if (state is UserFilterProductsFailureState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(CSnackBars.bottomSnackBar(state.errorText));
            }
          },
          builder: (context, state) {
            return InkWell(
              onTap: state is UserFilterProductsLoadedState
                  ? () => showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => UserCatalogBottomSheet())
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CColors.grey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(40.r)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Row(
                  children: [
                    CGreyText(
                      'Фильтры',
                      size: 12,
                    ),
                    w6,
                    SvgPicture.asset(
                      Images.filter,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            );
          },
          buildWhen: (previous, current) =>
              previous is UserFilterProductsLoadingState &&
              current is UserFilterProductsLoadedState,
        )
      ],
    );
  }
}
