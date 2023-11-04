import 'package:flutter/material.dart';
import 'package:hackathon_4/feature/comment/comment.dart';
import 'package:hackathon_4/feature/news/screen/news.dart';
import 'package:hackathon_4/feature/tender/screen/tender_screen.dart';
import 'package:hackathon_4/feature/tutorial/tutorial.dart';
import 'package:provider/provider.dart';
import '../../../core/style/app_colors.dart';
import '../selectTabProvider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageStorage(
        bucket: bucket,
        child: Provider.of<SelectTabProvider>(context).currentScreen,
      ),


      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        // notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Provider.of<SelectTabProvider>(context, listen: false)
                      .toggleSelect(const TenderScreen(),
                          0); // if user taps on this dashboard tab will be active
                },
                child: Icon(
                  Icons.add_chart,
                  color: Provider.of<SelectTabProvider>(context).currentTab == 0
                      ? AppColors.blue
                      : AppColors.blue1,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Provider.of<SelectTabProvider>(context, listen: false)
                      .toggleSelect(const News(),
                          1); // if user taps on this dashboard tab will be active
                },
                child: Icon(
                  Icons.add_to_photos_outlined,
                  color: Provider.of<SelectTabProvider>(context).currentTab == 1
                      ? AppColors.blue
                      : AppColors.blue1,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Provider.of<SelectTabProvider>(context, listen: false)
                      .toggleSelect(const Comment(),
                          2); // if user taps on this dashboard tab will be active
                },
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Provider.of<SelectTabProvider>(context).currentTab == 2
                      ? AppColors.blue
                      : AppColors.blue1,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Provider.of<SelectTabProvider>(context, listen: false)
                      .toggleSelect(const Tutorial(),
                          3); // if user taps on this dashboard tab will be active
                },
                child: Icon(
                  Icons.perm_identity_outlined,
                  color: Provider.of<SelectTabProvider>(context).currentTab == 3
                      ? AppColors.blue
                      : AppColors.blue1,
                ),
              ),

              // Right Tab bar icons
            ],
          ),
        ),
      ),
    );
  }
}
