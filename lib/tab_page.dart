import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostfound/account_page.dart';
import 'package:lostfound/home_page.dart';
import 'package:lostfound/search_page.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/timeline.dart';
import 'package:provider/provider.dart';

import 'BottomNavigationBarProvider.dart';

class TabPage extends StatefulWidget {

  final FirebaseUser user;
  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  PageController _pageController;


  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  final List<BottomNavigationBarItem> _myTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      title: Text(
        "메인페이지",
        style: TextStyle(fontSize: 10),
      ),
      icon: Icon(Icons.zoom_out_map),
    ),
    BottomNavigationBarItem(
      title: Text(
        "Middle",
        style: TextStyle(fontSize: 10),
      ),
      icon: Icon(Icons.dashboard),
    ),
    BottomNavigationBarItem(
      title: Text(
        "Right",
        style: TextStyle(fontSize: 10),
      ),
      icon: Icon(Icons.update),
    ),
  ];


  List _pages;
  var _provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     _pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
       TimelinePage(title: 'Muslim Civilisation Doodles'),
    ];
    _pageController = PageController();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _provider = Provider.of<BottomNavigationBarProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<BottomNavigationBarProvider>(context);
    return  MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: PageView(
              controller: _pageController,
              onPageChanged: (idx) {
                _provider.currentIdx = idx;
              },
              children: <Widget>[
                _pages[_provider.currentIdx],
                _pages[_provider.currentIdx],
                _pages[_provider.currentIdx],
              ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (idx) {
              _provider.currentIdx = idx;
            },
            currentIndex: _provider.currentIdx,
            items: _myTabs,
          ),
        ),
      ),
    );
  }

}
