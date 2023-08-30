import 'package:flutter/material.dart';

enum Buttons { stats, home, add }

class BottomNavWidget extends StatelessWidget {
  final Function(Buttons) onClick;
  const BottomNavWidget({super.key, required this.onClick});
  static final icons = {
    Buttons.stats: Icons.pie_chart,
    Buttons.home: Icons.home,
    Buttons.add: Icons.add_box,
  };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: Buttons.values
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(icons[e]),
              label: e.name,
            ),
          )
          .toList(),
      onTap: (value) {
        onClick(Buttons.values[value]);
      },
      unselectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
