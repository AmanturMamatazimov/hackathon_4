import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repository/repository.dart';

import '../../../../utils/utils.dart';
import '../../../../view/addresses_screen/addresses_screen.dart';
import '../../../../widgets/widgets.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.address,
    this.isFromProfile = true,
  });
  final AddressesModel address;
  final bool isFromProfile;
  @override
  Widget build(BuildContext context) {
    if (!isFromProfile && address.isDefault == 1) {
      context.read<AddressCubit>().setAddress(address);
    }
    return InkWell(
      onTap: isFromProfile
          ? null
          : () => context.read<AddressCubit>().setAddress(address),
      child: BlocBuilder<AddressCubit, AddressesModel?>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: CColors.address,
              border: !isFromProfile && state != null && state.id == address.id
                  ? Border.all(color: CColors.checkBoxActive)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CGreyBlackNotSoft(
                    text1: 'Адрес доставки',
                    text2:
                        '${address.country}, г. ${address.city}, ${address.fullAddress}'),
                h12,
                CGreyBlackNotSoft(
                    text1: 'ФИО получателя', text2: address.recipient),
                h12,
                CGreyBlackNotSoft(
                    text1: 'Номер телефона', text2: '+${address.phoneNumber}'),
                h12,
              ],
            ),
          );
        },
      ),
    );
  }
}
