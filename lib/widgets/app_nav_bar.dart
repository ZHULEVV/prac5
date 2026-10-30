import 'package:flutter/material.dart';
import '../routes.dart';

class AppNavBar extends StatelessWidget {
  final int selectedIndex;

  const AppNavBar({super.key, required this.selectedIndex});

  void _onSelected(BuildContext context, int index) {
    final route = index == 0 ? Routes.home : Routes.profile;
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.lightGreen.shade100,
      indicatorColor: Colors.lightGreen.shade300,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => _onSelected(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Главная',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}
