import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:repository/repository.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../user_details_screen.dart';

class FilterSizesListTile extends StatelessWidget {
  final Sizes size;
  const FilterSizesListTile({
    required this.size,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<UserFilterProductsBloc>(context),
        ),
        BlocProvider.value(
          value: BlocProvider.of<UserPageViewCubit>(context),
        ),
      ],
      child: BlocSelector<UserFilterProductsBloc, UserFilterProductsState,
          List<Sizes>?>(
        selector: (state) {
          if (state is UserFilterProductsLoadedState) {
            return state.sizeTypes;
          }
          return null;
        },
        builder: (context, sizes) {
          return ListTile(
            enabled: sizes != null,
            tileColor: CColors.colorItemBg,
            dense: true,
            onTap: () => context.read<UserFilterProductsBloc>().add(
                  UserFilterProductsCheckSizeEvent(size: size),
                ),
            contentPadding: EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h),
            title: CTitlePoppins(
              size.title,
              fwt: FontWeight.w500,
              color: sizes != null ? CColors.text : CColors.grey,
            ),
            trailing: BlocSelector<UserFilterProductsBloc,
                UserFilterProductsState, List<Sizes>?>(
              selector: (state) {
                if (state is UserFilterProductsLoadedState) {
                  return state.chosenSizeTypes;
                }
                return [];
              },
              builder: (context, chosenSizes) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckBox(
                      onChanged: (_) =>
                          context.read<UserFilterProductsBloc>().add(
                                UserFilterProductsCheckSizeEvent(size: size),
                              ),
                      value: chosenSizes!.contains(size),
                    ),
                    w16,
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterSizesListTileFirst extends StatelessWidget {
  const FilterSizesListTileFirst({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<UserFilterProductsBloc>(context),
        ),
        BlocProvider.value(
          value: BlocProvider.of<UserPageViewCubit>(context),
        ),
      ],
      child: BlocBuilder<UserFilterProductsBloc, UserFilterProductsState>(
        builder: (context, state) {
          if (state is UserFilterProductsLoadedState) {
            List<String> subTitle = [];
            if (state.chosenSizeTypes != null) {
              for (var s in state.chosenSizeTypes!) {
                subTitle.add(s.title);
              }
            }

            return ListTile(
              enabled: state.sizeTypes.isNotEmpty,
              tileColor: CColors.colorItemBg,
              dense: true,
              onTap: () {
                context.read<UserFilterProductsBloc>().add(
                      UserFilterProductsAddSizesPageEvent(
                        sizeType: state.sizeTypes,
                      ),
                    );
                context.read<UserPageViewCubit>().nextCategoryPage();
              },
              contentPadding:
                  EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h),
              title: CTitlePoppins(
                'Размеры',
                fwt: FontWeight.w500,
                color: state.sizeTypes.isNotEmpty ? CColors.text : CColors.grey,
              ),
              subtitle: subTitle.isEmpty
                  ? null
                  : CGreyText(
                      subTitle.join('/'),
                      size: 14,
                    ),
              trailing: Container(
                margin: EdgeInsets.only(right: 25.w),
                height: 14.h,
                width: 7.w,
                child: SvgPicture.asset(
                  Images.buttonForward,
                  color: state.sizeTypes.isNotEmpty
                      ? CColors.text
                      : CColors.filterTextField,
                ),
              ),
            );
          }
          return sb;
        },
      ),
    );
  }
}
