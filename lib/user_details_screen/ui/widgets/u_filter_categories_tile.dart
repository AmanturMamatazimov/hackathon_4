import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khanbuyer_new_design/utils/utils.dart';
import 'package:khanbuyer_new_design/widgets/widgets.dart';
import 'package:repository/repository.dart';

import '../../user_details_screen.dart';

class FilterCategoriesListTile extends StatelessWidget {
  const FilterCategoriesListTile({
    Key? key,
    required this.onTap,
    required this.category,
  }) : super(key: key);
  final Function onTap;
  final Category? category;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: CColors.colorItemBg,
      dense: true,
      onTap: category != null && category!.sizeTypes.isEmpty
          ? () => onTap()
          : () => context.read<UserFilterProductsBloc>().add(
                UserFilterProductsCheckEvent(category: category!),
              ),
      contentPadding: EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h),
      title: CTitlePoppins(category != null ? category!.title : 'Категория',
          fwt: FontWeight.w500),
      trailing: category == null ||
              (category != null && category!.sizeTypes.isEmpty)
          ? Container(
              margin: EdgeInsets.only(right: 25.w),
              height: 14.h,
              width: 7.w,
              child:
                  SvgPicture.asset(Images.buttonForward, color: CColors.grey),
            )
          : BlocSelector<UserFilterProductsBloc, UserFilterProductsState,
              List<Category>>(
              selector: (state) {
                if (state is UserFilterProductsLoadedState) {
                  return state.chosenCategories;
                }
                return [];
              },
              builder: (context, chosenCategories) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckBox(
                      onChanged: (_) {
                        context.read<UserFilterProductsBloc>().add(
                              UserFilterProductsCheckEvent(category: category!),
                            );
                      },
                      value: chosenCategories.contains(category),
                    ),
                    w16,
                  ],
                );
              },
            ),
    );
  }
}

class FilterCategoriesListTileFirst extends StatelessWidget {
  const FilterCategoriesListTileFirst({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UserFilterProductsBloc>(context),
      child: BlocBuilder<UserFilterProductsBloc, UserFilterProductsState>(
        builder: (context, state) {
          if (state is UserFilterProductsLoadedState) {
            List<String> subTitleOfParents = [];
            List<String> subTitle = [];
            for (var parent in state.chosenRoutePages) {
              if (parent['title'].isNotEmpty) {
                subTitleOfParents.add(parent['title']);
              }
            }
            for (var category in state.chosenCategories) {
              subTitle.add(category.title);
            }
            return ListTile(
              tileColor: CColors.colorItemBg,
              dense: true,
              onTap: () {
                context
                    .read<UserFilterProductsBloc>()
                    .add(UserFilterProductsAddFirstCategoriesEvent());
                context.read<UserPageViewCubit>().nextCategoryPage();
              },
              contentPadding:
                  EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h),
              title: const CTitlePoppins('Категория', fwt: FontWeight.w500),
              trailing: Container(
                margin: EdgeInsets.only(right: 25.w),
                height: 14.h,
                width: 7.w,
                child:
                    SvgPicture.asset(Images.buttonForward, color: CColors.grey),
              ),
              subtitle: subTitle.isEmpty
                  ? null
                  : CGreyText(
                      '${subTitleOfParents.join(' →')} → ${subTitle.join('/')}',
                      size: 14,
                    ),
            );
          }
          return sb;
        },
        buildWhen: (p, c) =>
            p is UserFilterProductsLoadedState &&
            c is UserFilterProductsLoadedState &&
            p.chosenCategories != c.chosenCategories,
      ),
    );
  }
}
