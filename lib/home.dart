import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const routeName="home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var _selectedTab = _SelectedTab.home;
   List<Widget> pages = const [
    Text("text1"),
    Text("text2"),
    Text("text3"),
    Text("text4"),
    Text("text5"),
   ];
   int _currentIndex = 0;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      _currentIndex = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    //_currentPage = pages[0];
    return Scaffold(
      appBar: AppBar(
        title: pages[_currentIndex],
      ),
       bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: BottomNavigationBar(
          backgroundColor: Colors.green,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          selectedItemColor: Colors.white,
          onTap: _handleIndexChanged,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            ),

            /// Likes
            BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_rounded),
              label: "Activities"
            ),

            /// Search
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph_outlined),
              label: "Progress"
            ),

            /// Profile
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_sharp),
              label: "Community" 
            ),

             BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
            ),
          ],
        ),
      ),
      body: Column(children: [
        pages[_currentIndex],
      ]),
    );
  }
}
enum _SelectedTab { home, favorite, search, person, setting }
