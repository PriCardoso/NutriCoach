import 'package:flutter/material.dart';

import '../dashboard/dashboard_page.dart';
import '../water/water_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  int currentIndex = 0;

  final pages = [
    const DashboardPage(),
    const WaterPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar:
          NavigationBar(

        selectedIndex: currentIndex,

        onDestinationSelected:
            (index) {

          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.water_drop),
            label: 'Água',
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}