import 'package:climate_care/Screens/activities_screen.dart';
import 'package:climate_care/Screens/home_screen.dart';
import 'package:climate_care/Screens/settings.dart';
import 'package:climate_care/Screens/progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Screens/community_screen.dart';

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
      const ActivitiesScreen(),
      const PointRedeem(),
      const HomeScreen(),
      const Community(),
      const Settings(),
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
            padding: const EdgeInsets.symmetric(horizontal: 02, vertical: 10),
            child: GNav(
              rippleColor: Theme.of(context).primaryColor,
              hoverColor: Theme.of(context).primaryColor,
              gap: 6,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).primaryColor,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.spa_outlined,
                  text: 'Activities',
                ),
                GButton(
                  icon: Icons.emoji_events_outlined,
                  text: 'Progress',
                ),
                GButton(
                  icon: Icons.home,
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
