import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mtracker/app/services/theme_service.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "MTracker",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeService.getLightTheme(context),
      darkTheme: ThemeService.getDarkTheme(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
