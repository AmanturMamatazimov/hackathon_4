import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../general_blocs/genereal_blocs.dart';

import '../../../../utils/utils.dart';
import '../../catalog_screen.dart';

class CatalogBottomSheet extends StatefulWidget {
  const CatalogBottomSheet({Key? key}) : super(key: key);

  @override
  State<CatalogBottomSheet> createState() => _CatalogBottomSheetState();
}

class _CatalogBottomSheetState extends State<CatalogBottomSheet> {
  final controller = PageController();

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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                context
                    .read<FilterProductsBloc>()
                    .add(FilterProductsCloseEvent());
                context.read<PageViewCubit>().backToStartPage();
              },
              child: Container(
                width: 36.h,
                height: 36.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10.h),
                child: SvgPicture.asset(Images.buttonX),
              ),
            ),
            h12,
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              width: double.infinity,
              height: 450.h,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                child: Column(
                  children: [
                    h14,
                    Expanded(
                      child: BlocListener<PageViewCubit, int>(
                        child: BlocSelector<FilterProductsBloc,
                            FilterProductsState, List<Widget>?>(
                          selector: (state) {
                            if (state is FilterProductsLoadedState) {
                              return state.pages;
                            }
                            return null;
                          },
                          builder: (context, pages) {
                            if (pages == null) return sb;
                            return PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller,
                              itemBuilder: (BuildContext context, int index) {
                                return pages[index];
                              },
                              itemCount: pages.length,
                            );
                          },
                        ),
                        listener: (context, state) async {
                          await controller.animateToPage(
                            state,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        listenWhen: (previous, current) => previous != current,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
