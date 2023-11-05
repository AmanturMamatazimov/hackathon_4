import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/widgets.dart';
import '../../../../utils/utils.dart';
import '../../user_details_screen.dart';

class FilterPrices extends StatelessWidget {
  FilterPrices({Key? key}) : super(key: key);

  final _maxFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UserFilterProductsBloc>(context),
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
                    child: BlocBuilder<UserFilterProductsBloc,
                        UserFilterProductsState>(
                      builder: (context, state) {
                        if (state is UserFilterProductsLoadedState) {
                          return FilterPriceTextField(
                            isMin: true,
                            value: state.minPrice,
                            onChanged: (String _) =>
                                context.read<UserFilterProductsBloc>().add(
                                      UserFilterProductsMinPriceEvent(_),
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
                          p is UserFilterProductsLoadedState &&
                          c is UserFilterProductsLoadedState &&
                          p.minPrice != c.minPrice,
                    ),
                  ),
                  w16,
                  Expanded(
                    child: BlocBuilder<UserFilterProductsBloc,
                        UserFilterProductsState>(
                      builder: (context, state) {
                        if (state is UserFilterProductsLoadedState) {
                          return FilterPriceTextField(
                            isMin: false,
                            isError: state.maxPrice.isNotEmpty &&
                                state.minPrice.isNotEmpty &&
                                int.parse(state.maxPrice) <
                                    int.parse(state.minPrice),
                            value: state.maxPrice,
                            focusNode: _maxFocusNode,
                            onChanged: (String _) =>
                                context.read<UserFilterProductsBloc>().add(
                                      UserFilterProductsMaxPriceEvent(_),
                                    ),
                          );
                        }
                        return sb;
                      },
                      buildWhen: (p, c) =>
                          p is UserFilterProductsLoadedState &&
                          c is UserFilterProductsLoadedState &&
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
