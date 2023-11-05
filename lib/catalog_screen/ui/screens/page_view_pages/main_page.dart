import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../general_blocs/genereal_blocs.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/widgets.dart';
import '../../../catalog_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<CatalogBloc>(context),
        ),
        BlocProvider.value(
          value: BlocProvider.of<FilterProductsBloc>(context),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(child: sb),
                    const Expanded(
                      flex: 2,
                      child: Center(
                        child: CTitleDM(
                          'Категория',
                          height: 1,
                        ),
                      ),
                    ),
                    const Expanded(child: ThrowButton()),
                  ],
                ),
              ),
              h10,
              const FilterCategoriesListTileFirst(),
              h16,
              const FilterSeasons(),
              h16,
              const FilterSizesListTileFirst(),
              h16,
              FilterPrices(),
              h22,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: BlocBuilder<FilterProductsBloc, FilterProductsState>(
                  builder: (context, state) {
                    if (state is FilterProductsLoadedState) {
                      final isEnable = state.chosenCategories.isNotEmpty ||
                          state.maxPrice.isNotEmpty ||
                          state.minPrice.isNotEmpty ||
                          state.seasonIds.isNotEmpty ||
                          state.isAfterThrow;
                      return CElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                          context
                              .read<FilterProductsBloc>()
                              .add(FilterProductsFilterEvent());
                          context
                              .read<CatalogBloc>()
                              .add(CatalogLoadEvent(filter: true));
                        },
                        text: 'Применить фильтр',
                        isDisabled: (state.maxPrice.isNotEmpty &&
                                state.minPrice.isNotEmpty &&
                                int.parse(state.maxPrice) <
                                    int.parse(state.minPrice)) ||
                            !isEnable,
                      );
                    }
                    return sb;
                  },
                  // buildWhen: (p, c) => p is FilterProductsLoadedState && c is FilterProductsLoadedState && p.,
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
