import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khanbuyer_new_design/general_blocs/genereal_blocs.dart';
import 'package:repository/repository.dart';

import '../view/addresses_screen/addresses_screen.dart';
import '../view/auth/ui/ui.dart';
import '../view/home_page/ui/ui.dart';
import '../view/orders_screen/orders_screen.dart';
import '../view/product_details/bloc/product_details_bloc.dart';
import '../view/product_details/ui/ui.dart';
import '../view/profile_screen/profile_screen.dart';
import '../view/user_details_screen/user_details_screen.dart';

class RouteGenerator {
  static Route<T> fadeThrough<T>(
    WidgetBuilder page, {
    RouteSettings? settings,
    int duration = 300,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.9,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInToLinear,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    return fadeThrough(
      (context) {
        switch (settings.name) {
          case '/':
            return const HomePage();
          case '/login':
            return const AuthScreen();
          case '/confirm-screen':
            return CodeScreen(args!);
          case '/product-view':
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<ProductDetailsBloc>(context)
                    ..add(ProductDetailsInitialize(
                        product: args!['product'] as ProductModel)),
                ),
                BlocProvider.value(
                    value: BlocProvider.of<CartBloc>(context)
                      ..add(CartStarted())),
              ],
              child: ProductDetailsScreen(args['product'] as ProductModel),
            );
          case '/add-address-screen':
            return AddAddressScreen();
          case '/addresses-screen':
            return AddressesScreen(colors: args!['colors'] as List<ColorModel>);
          case '/orders-screen':
            return OrdersScreen(makedOrder: args!['order'] as List<OrderModel>);
          case '/user-details-screen':
            return MultiBlocProvider(providers: [
              BlocProvider.value(
                value: BlocProvider.of<UserCatalogBloc>(context)
                  ..add(UserCatalogStartEvent())
                  ..add(UserCatalogLoadEvent()),
              ),
              BlocProvider.value(
                  value: BlocProvider.of<UserFilterProductsBloc>(context)
                    ..add(UserFilterProductsStartedEvent())
                    ..add(UserFilterProductsLoadedEvent())),
              BlocProvider.value(
                  value: BlocProvider.of<UserPageViewCubit>(context)
                    ..backToStartPage()),
            ], child: UserDetailsScreen(args!['shop'] as Shop));
          case '/order-screen':
            return BlocProvider(
              create: (context) =>
                  OrderBloc(ordersRepository: OrdersRepository()),
              child: OrderScreen(order: args!['order'] as OrderModel),
            );
          case '/profile-edit-screen':
            return ProfileEditScreen();
          default:
            return _errorRoute();
        }
      },
      settings: settings,
    );
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error page'),
      ),
      body: const Center(
        child: Text('UnKnown page'),
      ),
    );
  }
}
// final color =
//                         context.select<ProductDetailsInitState, Color>(
//                             (bloc) => bloc.color);
