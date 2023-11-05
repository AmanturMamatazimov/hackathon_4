import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../general_blocs/genereal_blocs.dart';
import '../../../../widgets/widgets.dart';
import '../../../../utils/utils.dart';
import '../../catalog_screen.dart';

class FilterSeasons extends StatelessWidget {
  const FilterSeasons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FilterProductsBloc>(context),
      child: ColoredBox(
        color: CColors.colorItemBg,
        child: Padding(
          padding: EdgeInsets.only(
            top: 5.h,
            left: 16.w,
            right: 16.w,
            bottom: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h2,
              const CTitlePoppins('Сезонность'),
              h12,
              BlocBuilder<FilterProductsBloc, FilterProductsState>(
                builder: (context, state) {
                  if (state is FilterProductsLoadedState) {
                    return Row(
                      children: [
                        CCheckBoxTile(
                          onChanged: (_) => context
                              .read<FilterProductsBloc>()
                              .add(FilterProductsSeasonChangeEvent(id: 3)),
                          label: 'Деми',
                          value: state.seasonIds.contains(3),
                        ),
                        w32,
                        CCheckBoxTile(
                          onChanged: (_) => context
                              .read<FilterProductsBloc>()
                              .add(FilterProductsSeasonChangeEvent(id: 1)),
                          label: 'Зима',
                          value: state.seasonIds.contains(1),
                        ),
                        w32,
                        CCheckBoxTile(
                          onChanged: (_) => context
                              .read<FilterProductsBloc>()
                              .add(FilterProductsSeasonChangeEvent(id: 2)),
                          label: 'Лето',
                          value: state.seasonIds.contains(2),
                        ),
                      ],
                    );
                  }
                  return sb;
                },
                buildWhen: (p, c) =>
                    p is FilterProductsLoadedState &&
                    c is FilterProductsLoadedState &&
                    p.seasonIds != c.seasonIds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
