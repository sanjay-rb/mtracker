import 'package:flutter/material.dart';
import 'package:mtracker/models/transaction_model.dart';
import 'package:mtracker/screens/add_transaction/add_transaction.dart';
import 'package:mtracker/screens/apps_screen/apps_screen.dart';
import 'package:mtracker/screens/home_screen/home_screen.dart';
import 'package:mtracker/screens/stats_screen/stats_screen.dart';
import 'package:mtracker/screens/update_transaction/update_transaction.dart';

abstract class MTrackerRoutes {
  static const String home = '/';
  static const String add = '/add';
  static const String update = '/update';
  static const String stats = '/stats';
  static const String apps = '/apps';

  static PageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name == home) {
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
        settings: settings,
      );
    } else if (settings.name == add) {
      return MaterialPageRoute(
        builder: (context) => const AddTransaction(),
        settings: settings,
      );
    } else if (settings.name == update) {
      final TransactionModel transaction =
          settings.arguments as TransactionModel;
      return MaterialPageRoute(
        builder: (context) => UpdateTransaction(transaction: transaction),
        settings: settings,
      );
    } else if (settings.name == stats) {
      return MaterialPageRoute(
        builder: (context) => const StatsScreen(),
        settings: settings,
      );
    } else if (settings.name == apps) {
      return MaterialPageRoute(
        builder: (context) => const AppsScreen(),
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
        settings: settings,
      );
    }
  }
}
