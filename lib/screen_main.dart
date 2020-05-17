import 'dart:io';

import 'package:flutter/material.dart';
import 'package:near/screen_home.dart';
import 'package:near/screen_join.dart';
import 'package:near/screen_settings.dart';
import 'constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _confirmExit(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Constants.appName),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: pageChanged,
          children: <Widget>[
            Home(),
            Join(),
            Settings(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _page,
            onTap: navigationTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text(
                  "Home",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_pin,
                ),
                title: Text(
                  "Join Conference",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                title: Text(
                  "Settings",
                ),
              ),
            ]),
      ),
    );
  }

  void navigationTap(pageIdx) {
    _pageController.jumpToPage(pageIdx);
  }

  void pageChanged(pageIdx) {
    setState(() {
      this._page = pageIdx;
    });
  }

  _confirmExit(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure to exit?'),
          content: Text("You wont be connected"),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () => exit(0),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
