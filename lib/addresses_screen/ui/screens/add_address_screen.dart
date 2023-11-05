import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/utils.dart';

import '../../../../widgets/widgets.dart';
import '../../addresses_screen.dart';
import '../../bloc/bloc/address_add_edit_bloc.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key, this.isEditingMode = false})
      : super(key: key);
  final bool isEditingMode;
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBarUsual('Добавить адрес'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<AddressAddEditBloc>(context),
          ),
          BlocProvider.value(
            value: BlocProvider.of<AddressesBloc>(context),
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  h22,
                  BlocSelector<AddressAddEditBloc, AddressAddEditState,
                      String?>(
                    selector: (state) {
                      if (state is AddressAddEditLoadedState) {
                        return state.country;
                      }
                      return null;
                    },
                    builder: (context, country) {
                      return AddAddressItem(
                        value: country,
                        validator: (_) {
                          if (_ == null || _.isEmpty) {
                            return 'Введите название страны';
                          }
                          return null;
                        },
                        title: 'Страна',
                        hint: 'Название страны',
                        onChanged: (_) => context
                            .read<AddressAddEditBloc>()
                            .add(AddressEditCountryEvent(_)),
                        textInputType: TextInputType.text,
                      );
                    },
                  ),
                  h22,
                  BlocSelector<AddressAddEditBloc, AddressAddEditState,
                      String?>(
                    selector: (state) {
                      if (state is AddressAddEditLoadedState) {
                        return state.city;
                      }
                      return null;
                    },
                    builder: (context, city) {
                      return AddAddressItem(
                        value: city,
                        title: 'Город',
                        hint: 'Название страны',
                        validator: (_) {
                          if (_ == null || _.isEmpty) {
                            return 'Введите название города';
                          }
                          return null;
                        },
                        onChanged: (_) => context
                            .read<AddressAddEditBloc>()
                            .add(AddressEditCityEvent(_)),
                        textInputType: TextInputType.text,
                      );
                    },
                  ),
                  h22,
                  BlocSelector<AddressAddEditBloc, AddressAddEditState,
                      String?>(
                    selector: (state) {
                      if (state is AddressAddEditLoadedState) {
                        return state.fullAddress;
                      }
                      return null;
                    },
                    builder: (context, fullAddress) {
                      return AddAddressItem(
                        value: fullAddress,
                        minLines: 2,
                        textInputAction: TextInputAction.done,
                        title: 'Адрес',
                        hint: 'Введите полный адрес',
                        onChanged: (_) => context
                            .read<AddressAddEditBloc>()
                            .add(AddressEditAddressEvent(_)),
                        textInputType: TextInputType.text,
                      );
                    },
                  ),
                  h40,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: BlocSelector<AddressAddEditBloc, AddressAddEditState,
                        bool?>(
                      selector: (state) {
                        if (state is AddressAddEditLoadedState) {
                          return state.isDefault;
                        }
                        return null;
                      },
                      builder: (context, val) {
                        return CCheckBoxTile(
                          label: 'Использовать данный адрес для доставки',
                          value: val ?? false,
                          overridedValue: val != null ? !val : false,
                          onChanged: (value) {
                            context.read<AddressAddEditBloc>().add(
                                  AddressEditDefaultEvent(value),
                                );
                          },
                        );
                      },
                    ),
                  ),
                  h40,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child:
                        BlocConsumer<AddressAddEditBloc, AddressAddEditState>(
                      listener: (context, state) {
                        if (state is AddressAddEditSuccessState) {
                          context
                              .read<AddressesBloc>()
                              .add(AddressesNewAddress(state.address));

                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        if (state is AddressAddEditLoadedState) {
                          return CElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                context
                                    .read<AddressAddEditBloc>()
                                    .add(AddressAddEvent(id: state.id));
                              }
                            },
                            text: 'Сохранить адрес',
                            isDisabled: state.city.isEmpty ||
                                state.country.isEmpty ||
                                state.fullAddress.isEmpty,
                            isLoading: state.isLoading ?? false,
                          );
                        }
                        return sb;
                      },
                    ),
                  ),
                  h32,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
