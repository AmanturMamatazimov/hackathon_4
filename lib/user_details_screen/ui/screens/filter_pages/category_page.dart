import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repository/repository.dart';

import '../../../../../utils/utils.dart';
import '../../../../../widgets/widgets.dart';
import '../../../user_details_screen.dart';

class UserCategoryPage extends StatelessWidget {
  const UserCategoryPage({
    super.key,
    required this.categories,
    required this.categoryTitle,
  });
  final List<Category> categories;
  final String categoryTitle;
  @override
  Widget build(BuildContext context) {
    final isAllParents = categories.any((element) => element.sizeTypes.isEmpty);
    context.read<UserFilterProductsBloc>().add(
        UserFilterProductsCheckIsParentsOnlyEvent(isParents: isAllParents));
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
              UserFilterProductsRemovePageEvent(
                  isDeletingRequired: categories.first.parentId != null));
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
                    Expanded(
                        child: FilterBackButton(
                            categories.first.parentId != null)),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: CTitleDM(
                          categoryTitle,
                          height: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: BlocSelector<UserFilterProductsBloc,
                            UserFilterProductsState, bool?>(
                          selector: (state) {
                            if (state is UserFilterProductsLoadedState) {
                              return state.isThereSpecialButton;
                            }
                            return null;
                          },
                          builder: (context, isThereSpecialButton) {
                            if (isThereSpecialButton == null ||
                                !isThereSpecialButton) {
                              return sb;
                            }
                            return FilterCheckAll(
                              categories: categories,
                            );
                          },
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
                itemCount: categories.length,
                itemBuilder: (context, index) => FilterCategoriesListTile(
                  onTap: () {
                    context.read<UserFilterProductsBloc>().add(
                          UserFilterProductsAddPageEvent(
                            id: categories[index].id,
                            categoryTitle: categories[index].title,
                          ),
                        );
                    context.read<UserPageViewCubit>().nextCategoryPage();
                  },
                  category: categories[index],
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
