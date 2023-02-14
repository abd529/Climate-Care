import 'package:climate_care/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  static const routeName="home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 2;
   List<Widget> pages =  [
    const Text("Activities"),
    const Text("Progress"),
    HomeScreen(),
    const Text("Community"),
    const Text("Settings"),
   ];
   List<Widget> appBarText = [
    const Text("Home"),
    const Text("Activities"),
    const Text("Progress"),
    const Text("Community"),
    const Text("Settings"),
   ];
  @override
  Widget build(BuildContext context) {
    //_currentPage = pages[0];
    return Scaffold(
      appBar: AppBar(
        title: appBarText[_selectedIndex],
      ),
       bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: GNav(
              rippleColor: Colors.green,
              hoverColor: Colors.green,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.green,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Column(children: [
        pages[_selectedIndex],
      ]),
    );
  }
}
