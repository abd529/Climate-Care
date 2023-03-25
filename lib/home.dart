// ignore_for_file: use_build_context_synchronously

import 'package:climate_care/Screens/activities_screen.dart';
import 'package:climate_care/Screens/coming_soon.dart';
import 'package:climate_care/Screens/home_screen.dart';
import 'package:climate_care/Screens/settings.dart';
import 'package:climate_care/Screens/progress_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Authentication/lsoption.dart';
import 'Screens/community_screen.dart';

class Home extends StatefulWidget {
  static const routeName = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final name = FirebaseAuth.instance.currentUser!.displayName;
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: Image.asset("assets/logo.png"),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' Profile '),
              onTap: () {
                Navigator.of(context).pushNamed(ComingSoon.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Why is Climate Important? '),
              onTap: () {
                Navigator.of(context).pushNamed(ComingSoon.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Achievements '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Option(),
                    ),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
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
