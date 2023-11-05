import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khanbuyer_new_design/utils/utils.dart';
import 'package:khanbuyer_new_design/widgets/widgets.dart';
import 'package:repository/repository.dart';

import '../../../../general_blocs/genereal_blocs.dart';
import '../../catalog_screen.dart';

class ThrowButton extends StatelessWidget {
  const ThrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FilterProductsBloc>(context),
      child: BlocBuilder<FilterProductsBloc, FilterProductsState>(
        builder: (context, state) {
          if (state is FilterProductsLoadedState) {
            final isEnable = state.chosenCategories.isNotEmpty ||
                state.maxPrice.isNotEmpty ||
                state.minPrice.isNotEmpty ||
                state.seasonIds.isNotEmpty;
            return InkWell(
              onTap: isEnable
                  ? () => context
                      .read<FilterProductsBloc>()
                      .add(FilterProductsThrowEvent())
                  : null,
              child: Container(
                width: double.infinity,
                height: 30.h,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Сбросить',
                      style: TextStyle(
                        fontFamily: GoogleFonts.getFont('DM Sans').fontFamily,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: isEnable ? CColors.blue : CColors.grey,
                      ),
                    )),
              ),
            );
          }
          return sb;
        },
      ),
    );
  }
}

class FilterBackButton extends StatelessWidget {
  const FilterBackButton(this.isDeletingRequired, {Key? key}) : super(key: key);
  final bool isDeletingRequired;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<FilterProductsBloc>().add(FilterProductsRemovePageEvent(
            isDeletingRequired: isDeletingRequired));
        context.read<PageViewCubit>().popCategoryPage();
      },
      child: SizedBox(
        width: double.infinity,
        height: 30.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: SvgPicture.asset(
            alignment: Alignment.centerLeft,
            Images.buttonPop,
            width: 14.h,
            height: 14.h,
          ),
        ),
      ),
    );
  }
}

class FilterCheckAll extends StatelessWidget {
  const FilterCheckAll({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<FilterProductsBloc>().add(
            FilterProductsCheckAllEvent(
                categories: categories, length: categories.length),
          ),
      child: SizedBox(
        width: 20.h,
        height: 20.h,
        child: SvgPicture.asset(
          alignment: Alignment.centerRight,
          Images.buttonRoutine,
        ),
      ),
    );
  }
}

class FilterCheckAllSizes extends StatelessWidget {
  const FilterCheckAllSizes({
    Key? key,
    required this.sizes,
  }) : super(key: key);
  final List<Sizes> sizes;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<FilterProductsBloc>().add(
            FilterProductsCheckAllSizesEvent(
              length: sizes.length,
              sizes: sizes,
            ),
          ),
      child: SizedBox(
        width: 20.h,
        height: 20.h,
        child: SvgPicture.asset(
          alignment: Alignment.centerRight,
          Images.buttonRoutine,
        ),
      ),
    );
  }
}
