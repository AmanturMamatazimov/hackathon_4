import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khanbuyer_new_design/utils/utils.dart';
import 'package:khanbuyer_new_design/widgets/widgets.dart';
import 'package:repository/repository.dart' show Shop;

import '../../../product/product.dart';
import '../../user_details_screen.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen(this.shop, {Key? key}) : super(key: key);
  final Shop shop;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CBottomBar(
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: CElevatedButtonWithIcon(
                  onPressed: () {},
                  text: 'Написать',
                  path: Images.buttonEnvelope,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: const CAppBar(isWithLike: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top.h,
              ),
              h78,
              CTitlePoppins(
                'Профиль продавца',
                size: 12,
                fwt: FontWeight.w600,
              ),
              h22,
              UserHeader(shop),
              h22,
              CGreyBlackNotSoft(
                text1: 'Описание',
                text2: shop.description,
                size2: 14,
              ),
              h32,
              const UserOtherProducts(),
              h16,
              BlocConsumer<UserCatalogBloc, UserCatalogState>(
                listener: (context, state) {
                  if (state is UserCatalogFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CSnackBars.topSnackBar(context, state.errorText),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserCatalogEmpty) {
                    return Column(
                      children: [
                        Text('No products'),
                      ],
                    );
                  } else if (state is UserCatalogLoaded) {
                    return Column(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
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
                        if (!state.hasReachedMax && state.products.length > 10)
                          const BottomLoader()
                      ],
                    );
                  }
                  return CShaderMask(
                    child: Column(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
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
            ],
          ),
        ),
      ),
    );
  }
}
