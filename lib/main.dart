import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/services/database_service.dart';
import 'package:mtracker/app/services/theme_service.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await initServices();
  runApp(const MainApp());
}

initServices() async {
  debugPrint('Starting services...');
  await Get.putAsync(() async => DatabaseService());
  debugPrint('All services started...');
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    Get.find<DatabaseService>().database;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "MTracker",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeService.getTheme(
        dominant: ThemeService.dominantLight,
        onDominant: ThemeService.onDominantLight,
        primary: ThemeService.primaryLight,
        onPrimary: ThemeService.onPrimaryLight,
        accent: ThemeService.accentLight,
        onAccent: ThemeService.onAccentLight,
      ),
      darkTheme: ThemeService.getTheme(
        dominant: ThemeService.dominantDark,
        onDominant: ThemeService.onDominantDark,
        primary: ThemeService.primaryDark,
        onPrimary: ThemeService.onPrimaryDark,
        accent: ThemeService.accentDark,
        onAccent: ThemeService.onAccentDark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
