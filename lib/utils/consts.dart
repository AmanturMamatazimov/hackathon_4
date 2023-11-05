import 'package:flutter/material.dart';
import 'package:repository/general/helper.dart';

class CColors {
  static const blue = Color.fromRGBO(6, 69, 163, 1);
  static const grey = Color.fromRGBO(148, 148, 148, 1);
  static const red = Color.fromRGBO(227, 0, 15, 1);
  static const scaffold = Color.fromRGBO(229, 229, 229, 1);
  static const disabledButton = Color.fromRGBO(218, 218, 218, 1);
  static const unSelectedBar = Color.fromRGBO(228, 231, 234, 1);
  static const text = Color.fromRGBO(37, 37, 37, 1);
  static const indicatorNotActive = Color.fromRGBO(207, 207, 207, 1);
  static const underlineInputDisabled = Color.fromRGBO(226, 228, 229, 1);
  static const address = Color.fromRGBO(249, 249, 249, 1);
  static const checkBoxActive = Color.fromRGBO(57, 128, 253, 1);
  static const selectedListTile = Color.fromRGBO(247, 249, 253, 1);
  static const snackBar = Color.fromARGB(255, 167, 165, 165);
  static const pinCodeDefaultBorder = Color.fromRGBO(0, 0, 0, 0.2);
  static const shadow = Color.fromRGBO(0, 0, 0, 0.1);
  static const likeShadow = Color.fromRGBO(0, 0, 0, 0.06);
  static const likeShadow2 = Color.fromRGBO(0, 0, 0, 0.04);
  static const colorItemBg = Color.fromRGBO(227, 227, 227, 0.2);
  static const filterTextField = Color.fromRGBO(186, 186, 186, 1);
  static const slidableDeleteBg = Color.fromRGBO(242, 242, 242, 1);

  static const colorRectangle = Color.fromRGBO(57, 128, 253, 0.15);
  static const dividerGrey = Color.fromRGBO(148, 148, 148, 0.2);
  static const shader = Color.fromARGB(51, 199, 199, 199);
  static const orange = Color.fromRGBO(242, 174, 45, 1);
  static const green = Color.fromRGBO(130, 195, 107, 1);
}

class Images {
  static const onBoarding1 = 'assets/images/onBoarding1.jpg';
  static const onBoarding2 = 'assets/images/onBoarding2.jpg';
  static const onBoarding3 = 'assets/images/onBoarding3.jpg';
  static const onBoarding4 = 'assets/images/onBoarding4.jpg';
  static const onBoarding5 = 'assets/images/onBoarding5.jpg';
  static const onBoarding6 = 'assets/images/onBoarding6.jpg';
  //
  static const home = 'assets/images/home.svg';
  static const catalog = 'assets/images/catalog.svg';
  static const basket = 'assets/images/basket.svg';
  static const profile = 'assets/images/profile.svg';
  //
  static const arrowDown = 'assets/images/arrowDown.svg';
  static const kg = 'assets/images/kg.svg';
  static const kz = 'assets/images/kz.svg';
  static const ru = 'assets/images/ru.svg';
  static const checked = 'assets/images/checked.svg';
  static const search = 'assets/images/search.svg';
  static const filter = 'assets/images/filter.svg';
  static const like = 'assets/images/like.svg';
  static const likeFilled = 'assets/images/likeFilled.svg';
  static const buttonCart = 'assets/images/buttonCart.svg';
  static const buttonClock = 'assets/images/buttonClock.svg';
  static const buttonCorpEdit = 'assets/images/buttonCorpEdit.svg';
  static const buttonCorpI = 'assets/images/buttonCorpI.svg';
  static const buttonCropX = 'assets/images/buttonCropX.svg';
  static const buttonEdit = 'assets/images/buttonEdit.svg';
  static const buttonEnvelope = 'assets/images/buttonEnvelope.svg';
  static const buttonForward = 'assets/images/buttonForward.svg';
  static const buttonForwardNotIos = 'assets/images/buttonForwardNotIos.svg';
  static const buttonPop = 'assets/images/buttonPop.svg';
  static const buttonRoutine = 'assets/images/buttonRoutine.svg';
  static const buttonTrash = 'assets/images/buttonTrash.svg';
  static const buttonX = 'assets/images/buttonX.svg';
  static const buttonShare = 'assets/images/buttonShare.svg';
  static const logo = 'assets/images/logo.svg';

// profile
  static const addresses = 'assets/images/addresses.svg';
  static const chat = 'assets/images/chat.svg';
  static const headPhones = 'assets/images/headPhones.svg';
  static const lock = 'assets/images/lock.svg';
  static const orders = 'assets/images/orders.svg';
  static const profileLike = 'assets/images/profileLike.svg';
  static const settings = 'assets/images/settings.svg';

  //placeholder for image
  static const placeholder =
      '$baseUrl/yii2images/images/image-by-item-and-alias?item=&dirtyAlias=placeHolder_300x.png';
}

class ScrollPositions {
  static final catalogBucket = PageStorageBucket();
}
// final catalogBucket = PageStorageBucket();

const List<Map<String, dynamic>> sliderPages = [
  {
    'image': Images.onBoarding1,
    'title': 'Очень большой каталог',
    'description': '100 000+ товарных наименований от проверенных поставщиков.',
  },
  {
    'image': Images.onBoarding2,
    'title': 'Безопасные сделки',
    'description':
        'Платежи поступают на транзитный счет и списываются только после получения товара.',
  },
  {
    'image': Images.onBoarding3,
    'title': 'Отслеживание заказов',
    'description': 'Подробная информация о статусе доставки на каждом этапе.',
  },
  {
    'image': Images.onBoarding4,
    'title': 'Чат с поставщиком',
    'description':
        'Удобный чат с поставщиками внутри приложения. Договаривайтесь и совершайте сделки без посредников.',
  },
  {
    'image': Images.onBoarding5,
    'title': 'Маркировка товаров',
    'description': 'Генерации маркировок в один клик по самым выгодным ценам.',
  },
  {
    'image': Images.onBoarding6,
    'title': 'Просто и удобно!',
    'description':
        'Удобный поиск и добавление товаров в избранное. Заказ в один клик и многое другое.',
  },
];

const List<Map<String, dynamic>> countries = [
  {
    'image': Images.kg,
    'code': '+996',
    'title': 'Кыргызстан',
    'type': 'kg',
  },
  {
    'image': Images.ru,
    'code': '+7',
    'title': 'Россия',
    'type': 'ru',
  },
  {
    'image': Images.kz,
    'code': '+7',
    'title': 'Казахстан',
    'type': 'kz',
  },
];


// const List<Map<String, dynamic>> seasons = [
//   {"id": 3, "title": "Деми"},
//   {"id": 1, "title": "Зима"},
//   {"id": 2, "title": "Лето"}
// ];
