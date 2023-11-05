import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khanbuyer_new_design/general_blocs/genereal_blocs.dart';
import '../../../../widgets/widgets.dart';
import '../../../../utils/utils.dart';
import '../../catalog_screen.dart';

class FilterPrices extends StatelessWidget {
  FilterPrices({Key? key}) : super(key: key);

  final _maxFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FilterProductsBloc>(context),
      child: ColoredBox(
        color: CColors.colorItemBg,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 9.h,
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CTitlePoppins('Диапазон цены'),
              h12,
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<FilterProductsBloc, FilterProductsState>(
                      builder: (context, state) {
                        if (state is FilterProductsLoadedState) {
                          return FilterPriceTextField(
                            isMin: true,
                            value: state.minPrice,
                            onChanged: (String _) =>
                                context.read<FilterProductsBloc>().add(
                                      FilterProductsMinPriceEvent(_),
                                    ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_maxFocusNode);
                            },
                          );
                        }
                        return sb;
                      },
                      buildWhen: (p, c) =>
                          p is FilterProductsLoadedState &&
                          c is FilterProductsLoadedState &&
                          p.minPrice != c.minPrice,
                    ),
                  ),
                  w16,
                  Expanded(
                    child: BlocBuilder<FilterProductsBloc, FilterProductsState>(
                      builder: (context, state) {
                        if (state is FilterProductsLoadedState) {
                          return FilterPriceTextField(
                            isMin: false,
                            isError: state.maxPrice.isNotEmpty &&
                                state.minPrice.isNotEmpty &&
                                int.parse(state.maxPrice) <
                                    int.parse(state.minPrice),
                            value: state.maxPrice,
                            focusNode: _maxFocusNode,
                            onChanged: (String _) =>
                                context.read<FilterProductsBloc>().add(
                                      FilterProductsMaxPriceEvent(_),
                                    ),
                          );
                        }
                        return sb;
                      },
                      buildWhen: (p, c) =>
                          p is FilterProductsLoadedState &&
                          c is FilterProductsLoadedState &&
                          (p.maxPrice != c.maxPrice ||
                              p.minPrice != c.minPrice),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
