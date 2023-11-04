import 'package:flutter/cupertino.dart';
import 'package:hackathon_4/feature/tender/screen/tender_screen.dart';

class SelectTabProvider extends ChangeNotifier{
  List<Widget> backList=[
  ];
  List<int> tabList=[
  ];
  int currentTab=0;
  Widget currentScreen = const TenderScreen();
  void toggleSelect(Widget newWidget,int tab){
    currentScreen=newWidget;
    currentTab=tab;
    notifyListeners();
  }
  void backFun(){
    currentScreen=backList.last;
    backList.removeLast();
    currentTab=tabList.last;
    tabList.removeLast();
    notifyListeners();
  }
}