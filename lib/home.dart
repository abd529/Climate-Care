import 'package:climate_care/Screens/home_screen.dart';
import 'package:climate_care/Screens/profile_screen.dart';
import 'package:climate_care/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  static const routeName = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 2;

  List<Widget> appBarText = [
    const Text("Activities"),
    const Text("Progress"),
    const Text("Home"),
    const Text("Community"),
    const Text("Settings"),
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const ProfileScreen(),
      const Text("Progress"),
      const HomeScreen(),
      const Text("Community"),
      Settings(),
      //const Text("heh")
    ];
    return Scaffold(
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
              rippleColor: Theme.of(context).primaryColor,
              hoverColor: Theme.of(context).primaryColor,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).primaryColor,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.tree,
                  text: 'Activities',
                ),
                GButton(
                  icon: Icons.auto_graph_outlined,
                  text: 'Progress',
                ),
                GButton(
                  icon: LineIcons.home,
                  text: 'HOME',
                ),
                GButton(
                  icon: Icons.people_alt_outlined,
                  text: 'Social',
                ),
                GButton(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
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
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          pages[_selectedIndex],
          //Text("hh"),
        ]),
      ),
    );
  }
}
