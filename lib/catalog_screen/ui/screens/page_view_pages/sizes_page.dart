import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khanbuyer_new_design/general_blocs/genereal_blocs.dart';
import 'package:repository/repository.dart' show Sizes;

import '../../../../../utils/utils.dart';
import '../../../../../widgets/widgets.dart';
import '../../../catalog_screen.dart';

class SizesPage extends StatelessWidget {
  const SizesPage({
    super.key,
    required this.sizes,
  });
  final List<Sizes> sizes;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<FilterProductsBloc>(context),
        ),
        BlocProvider.value(
          value: BlocProvider.of<PageViewCubit>(context),
        ),
      ],
      child: WillPopScope(
        onWillPop: () {
          context.read<FilterProductsBloc>().add(
              const FilterProductsRemovePageEvent(isDeletingRequired: true));
          context.read<PageViewCubit>().popCategoryPage();
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    const Expanded(child: FilterBackButton(true)),
                    const Expanded(
                      flex: 2,
                      child: Center(
                        child: CTitleDM(
                          'Размеры',
                          height: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FilterCheckAllSizes(
                          sizes: sizes,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h16,

              ListView.separated(
                separatorBuilder: (context, index) => h8,
                shrinkWrap: true,
                itemCount: sizes.length,
                itemBuilder: (context, index) => FilterSizesListTile(
                  size: sizes[index],
                ),
              ),
              h22,
              // h50,
              // h100,
            ],
          ),
        ),
      ),
    );
  }
}
