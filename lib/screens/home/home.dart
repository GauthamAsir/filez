import 'package:filez/screens/browse/browse.dart';
import 'package:filez/screens/settings/settings.dart';
import 'package:filez/utils/strings.dart';
import 'package:filez/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _pageController;
  int _page = 0;

  void navigationTapped(int page) {
    // _pageController.jumpToPage(page);
    if(_pageController.page == 0)
      _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.linear);
    else
      _pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  void onPageChanged(int page) {
    if(mounted)
      setState(() {
        this._page = page;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        backgroundColor: Utils.getBackgroundColor(),
        title: Text(
          Strings.appName,
          style: Get.textTheme.headline6,
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          Browse(),
          Settings()
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.black45,
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Feather.folder,
              ),
              label: Strings.browse,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.settings,
              ),
              label: Strings.settings,
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        )
    );
  }
}
