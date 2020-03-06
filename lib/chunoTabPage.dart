import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostfound/BottomNavigationBarProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChunoTabPage extends StatefulWidget {
  @override
  _ChunoTabPageState createState() => _ChunoTabPageState();
}

class _ChunoTabPageState extends State<ChunoTabPage> {
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

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

  List _pages = [

  ];

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<BottomNavigationBarProvider>(context);
    return MaterialApp(
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
                currentIndex: _provider.currentIdx,
                onTap: (idx) {
                  _provider.currentIdx = idx;
                },
                items: _myTabs,
              ),
            )));
  }
}
