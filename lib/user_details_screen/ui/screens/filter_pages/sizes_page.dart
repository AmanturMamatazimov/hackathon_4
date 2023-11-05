import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repository/repository.dart' show Sizes;

import '../../../user_details_screen.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/widgets.dart';

class UserSizesPage extends StatelessWidget {
  const UserSizesPage({
    super.key,
    required this.sizes,
  });
  final List<Sizes> sizes;
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
      child: WillPopScope(
        onWillPop: () {
          context.read<UserFilterProductsBloc>().add(
              const UserFilterProductsRemovePageEvent(
                  isDeletingRequired: true));
          context.read<UserPageViewCubit>().popCategoryPage();
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
