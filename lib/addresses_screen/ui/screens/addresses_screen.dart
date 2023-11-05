import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khanbuyer_new_design/view/basket_screen/basket_screen.dart';
import 'package:repository/repository.dart';

import '../../../../view/addresses_screen/addresses_screen.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../bloc/bloc/address_add_edit_bloc.dart';

// ignore: must_be_immutable
class AddressesScreen extends StatelessWidget {
  AddressesScreen({Key? key, required this.colors}) : super(key: key);
  final List<ColorModel> colors;
  late List<AddressesModel> addressess = [];
  late bool hasReachedMaxx = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBarUsual(colors.isNotEmpty ? 'Адрес' : 'Мои адреса'),
      body: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<AddressesBloc>(context)
                ..add(const AddressesLoadEvent()),
            ),
          ],
          child: BlocListener<AddressesBloc, AddressesState>(
            listener: (context, state) {
              if (state is AddressesGetErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CSnackBars.bottomSnackBar(state.errorText),
                );
              } else if (state is AddressesLoadedState &&
                  state.makingOrderError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CSnackBars.bottomSnackBar(state.makingOrderError!),
                );
              } else if (state is AddressesLoadedState &&
                  state.errorWhileDeleting.isNotEmpty) {
                clog('asdadd4');
                ScaffoldMessenger.of(context).showSnackBar(
                  CSnackBars.bottomSnackBar(state.errorWhileDeleting),
                );
              }
            },
            child: PullToRefreshWidget(
              callback: () => context.read<AddressesBloc>().add(
                  const AddressesLoadEvent(addresses: [], isRefresh: true)),
              child: LazyLoadWidget(
                callback: () => context.read<AddressesBloc>().add(
                      AddressesLoadEvent(
                        addresses: addressess,
                        isLoadMore: true,
                        hasReachedMax: hasReachedMaxx,
                      ),
                    ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      SliverToBoxAdapter(
                          child: SizedBox(
                        child: BlocBuilder<AddressesBloc, AddressesState>(
                          builder: (context, state) {
                            if (state is AddressesEmpty) {
                              return const AddressesEmpty();
                            } else if (state is AddressesLoadedState) {
                              addressess = state.addresses;
                              hasReachedMaxx = state.hasReachedMax;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (colors.isNotEmpty) ...[
                                    h6,
                                    const CGreyText(
                                        'Выберите ваш адрес доставки'),
                                    h22,
                                  ],
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (ct, index) {
                                      final address = state.addresses[index];
                                      return address.id ==
                                              state.deletedAddressid
                                          ? sb
                                          : Slidable(
                                              endActionPane: ActionPane(
                                                motion: ScrollMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (_) {
                                                      context
                                                          .read<
                                                              AddressAddEditBloc>()
                                                          .add(
                                                              AddressAddInitialEvent());
                                                      context
                                                          .read<
                                                              AddressAddEditBloc>()
                                                          .add(
                                                              AddressLoadedEvent(
                                                            id: address.id,
                                                            city: address.city,
                                                            isDefault: address
                                                                    .isDefault ==
                                                                1,
                                                            country:
                                                                address.country,
                                                            fullAddress: address
                                                                .fullAddress,
                                                          ));
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/add-address-screen');
                                                    },
                                                    backgroundColor: CColors
                                                        .underlineInputDisabled,
                                                    foregroundColor:
                                                        CColors.checkBoxActive,
                                                    icon: Icons.edit,
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (_) {
                                                      context
                                                          .read<AddressesBloc>()
                                                          .add(
                                                              AddressesDeleteEvent(
                                                                  address.id));
                                                    },
                                                    backgroundColor: CColors
                                                        .slidableDeleteBg,
                                                    foregroundColor:
                                                        CColors.red,
                                                    icon: Icons.delete_rounded,
                                                  ),
                                                ],
                                              ),
                                              child: AddressItem(
                                                address: address,
                                                isFromProfile: colors.isEmpty,
                                              ),
                                            );
                                    },
                                    separatorBuilder: (context, index) => h22,
                                    itemCount: state.addresses.length,
                                  ),
                                  if (!state.hasReachedMax &&
                                      state.addresses.length > 5) ...[
                                    h20,
                                    const BottomLoader()
                                  ],
                                ],
                              );
                            }
                            return CShaderMask(
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (ct, index) {
                                  return const AddressShader();
                                },
                                separatorBuilder: (context, index) => h22,
                                itemCount: 6,
                              ),
                            );
                          },
                          buildWhen: (p, c) => !(p is AddressesLoadedState &&
                              c is AddressesLoadedState &&
                              p.addresses.length == c.addresses.length),
                        ),
                      )),
                      // if (colors.isNotEmpty)
                      //   SliverFillRemaining(
                      //     hasScrollBody: false,
                      //     child: Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child:
                      //     ),
                      //   )
                      // else
                      SliverToBoxAdapter(
                        child: colors.isNotEmpty ? h100 : h52,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocProvider.value(
              value: BlocProvider.of<AddressAddEditBloc>(context),
              child: CElevatedWhiteButtonWithIcon(
                onPressed: () {
                  context.read<AddressAddEditBloc>().add(AddressLoadedEvent());
                  Navigator.of(context).pushNamed('/add-address-screen');
                },
                text: 'Добавить новый адрес',
                prefix: '+',
              ),
            ),
            h16,
            if (colors.isNotEmpty) ...[
              BlocProvider.value(
                value: BlocProvider.of<BasketBloc>(context),
                child: BlocConsumer<AddressesBloc, AddressesState>(
                  listener: (context, state) {
                    if (state is AddressesLoadedState &&
                        state.makedOrder != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/orders-screen', ModalRoute.withName('/'),
                          arguments: {'order': state.makedOrder});
                      context.read<BasketBloc>().add(BasketClearEvent());
                      context
                          .read<AddressesBloc>()
                          .add(AddressesRestartEvent());
                    }
                  },
                  builder: (context, state) {
                    if (state is AddressesLoadedState) {
                      return CElevatedButton(
                        onPressed: () => context
                            .read<AddressesBloc>()
                            .add(MakeOrderEvent(colors)),
                        text: 'Оформить заказ',
                        isDisabled: state.addresses.isEmpty,
                        isLoading: state.isMakingOrder,
                      );
                    }
                    return sb;
                  },
                ),
              ),
              h16,
            ],
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
