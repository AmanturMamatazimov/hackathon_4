import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/widgets.dart';

void clog(_) {
  if (kDebugMode) {
    log("$_");
  }
}

SizedBox get sb => const SizedBox();
SizedBox get h1 => SizedBox(height: 1.h);
SizedBox get h2 => SizedBox(height: 2.h);
SizedBox get h3 => SizedBox(height: 3.h);
SizedBox get h4 => SizedBox(height: 4.h);
SizedBox get h5 => SizedBox(height: 5.h);
SizedBox get h6 => SizedBox(height: 6.h);
SizedBox get h8 => SizedBox(height: 8.h);
SizedBox get h10 => SizedBox(height: 10.h);
SizedBox get h12 => SizedBox(height: 12.h);
SizedBox get h14 => SizedBox(height: 14.h);
SizedBox get h16 => SizedBox(height: 16.h);
SizedBox get h18 => SizedBox(height: 18.h);
SizedBox get h20 => SizedBox(height: 20.h);
SizedBox get h22 => SizedBox(height: 22.h);
SizedBox get h24 => SizedBox(height: 24.h);
SizedBox get h25 => SizedBox(height: 25.h);
SizedBox get h28 => SizedBox(height: 28.h);
SizedBox get h30 => SizedBox(height: 30.h);
SizedBox get h32 => SizedBox(height: 32.h);
SizedBox get h34 => SizedBox(height: 34.h);
SizedBox get h38 => SizedBox(height: 38.h);
SizedBox get h40 => SizedBox(height: 40.h);
SizedBox get h44 => SizedBox(height: 44.h);
SizedBox get h48 => SizedBox(height: 48.h);
SizedBox get h50 => SizedBox(height: 50.h);
SizedBox get h52 => SizedBox(height: 52.h);
SizedBox get h55 => SizedBox(height: 55.h);
SizedBox get h60 => SizedBox(height: 60.h);
SizedBox get h78 => SizedBox(height: 78.h);
SizedBox get h82 => SizedBox(height: 82.h);
SizedBox get h100 => SizedBox(height: 100.h);
SizedBox get h150 => SizedBox(height: 150.h);
SizedBox get h250 => SizedBox(height: 250.h);
SizedBox get w1 => SizedBox(width: 1.w);
SizedBox get w2 => SizedBox(width: 2.w);
SizedBox get w3 => SizedBox(width: 3.w);
SizedBox get w4 => SizedBox(width: 4.w);
SizedBox get w5 => SizedBox(width: 5.w);
SizedBox get w6 => SizedBox(width: 6.w);
SizedBox get w8 => SizedBox(width: 8.w);
SizedBox get w10 => SizedBox(width: 10.w);
SizedBox get w12 => SizedBox(width: 12.w);
SizedBox get w15 => SizedBox(width: 15.w);
SizedBox get w16 => SizedBox(width: 16.w);
SizedBox get w18 => SizedBox(width: 18.w);
SizedBox get w24 => SizedBox(width: 24.w);
SizedBox get w25 => SizedBox(width: 25.w);
SizedBox get w32 => SizedBox(width: 32.w);
SizedBox get w34 => SizedBox(width: 34.w);
SizedBox get w40 => SizedBox(width: 40.w);
SizedBox get w60 => SizedBox(width: 60.w);

String? validateMobile(String? value, String countryType) {
  if (value == null || value.isEmpty) {
    return 'Введите номер';
  }
  if (countryType == '+996') {
    if (value.length < 11) {
      return 'Введите номер полностью';
    }
  } else {
    if (value.length < 13) {
      return 'Введите номер полностью';
    }
  }

  return null;
}

String getAvalabling(int value) => value == 0 ? 'нет' : 'есть в наличии';

List<Widget> buildPageIndicator(int length, int currentPage) {
  List<Widget> list = [];
  for (int i = 0; i < length; i++) {
    list.add(i == currentPage ? const Indicator(true) : const Indicator(false));
  }
  return list;
}
