import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khanbuyer_new_design/general_blocs/genereal_blocs.dart';
import 'package:khanbuyer_new_design/utils/utils.dart';
import 'package:repository/repository.dart' as repo;

import '../../../../widgets/widgets.dart';
import '../../../product/product.dart';
import '../../catalog_screen.dart';

// ignore: must_be_immutable
class CatalogScreen extends StatelessWidget {
  CatalogScreen({Key? key}) : super(key: key);

  late List<repo.ProductModel> productss = [];
  late bool hasReachedMaxx = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<CatalogBloc>(context)..add(CatalogLoadEvent()),
        ),
        BlocProvider.value(
          value: BlocProvider.of<FilterProductsBloc>(context)
            ..add(FilterProductsLoadedEvent()),
        ),
      ],
      child: PullToRefreshWidget(
        edgeOffset: 110,
        callback: () => context
            .read<CatalogBloc>()
            .add(CatalogLoadEvent(products: const [], isRefresh: true)),
        child: LazyLoadWidget(
          callback: () => context.read<CatalogBloc>().add(
                CatalogLoadEvent(
                  products: productss,
                  isLoadMore: true,
                  hasReachedMax: hasReachedMaxx,
                ),
              ),
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).viewPadding.top.h + 10.h,
                ),
              ),
              SliverAppBar(
                centerTitle: true,
                primary: false,
                pinned: true,
                elevation: 0,
                snap: true,
                floating: true,
                backgroundColor: Colors.white,
                title: Column(
                  children: [
                    // h32,
                    const CTitleDM(
                      'Каталог',
                    ),
                    h16,
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(46.0.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      color: Colors.white,
                      child: SearchField(
                        filter: () {},
                        isEnable: false,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                child: BlocConsumer<CatalogBloc, CatalogState>(
                  listener: (context, state) {
                    if (state is CatalogFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CSnackBars.topSnackBar(context, state.errorText),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CatalogEmpty) {
                      return Column(
                        children: [
                          h20,
                          Text('No products'),
                        ],
                      );
                    } else if (state is CatalogLoaded) {
                      productss = state.products;
                      hasReachedMaxx = state.hasReachedMax;
                      return Column(
                        children: [
                          h14,
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16.h,
                              crossAxisSpacing: 16.w,
                              childAspectRatio: 62.w / 100.h,
                            ),
                            itemBuilder: (context, index) {
                              return Product(product: state.products[index]);
                            },
                            itemCount: state.products.length,
                          ),
                          if (!state.hasReachedMax &&
                              state.products.length > 10)
                            const BottomLoader()
                        ],
                      );
                    }
                    return CShaderMask(
                      child: Column(
                        children: [
                          h14,
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16.h,
                              crossAxisSpacing: 16.w,
                              childAspectRatio: 62.w / 100.h,
                            ),
                            itemBuilder: (context, index) {
                              return const CatalogProductShader();
                            },
                            itemCount: 6,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
