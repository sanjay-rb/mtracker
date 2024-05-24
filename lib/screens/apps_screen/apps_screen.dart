import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await http.get(Uri.parse("itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/sanjay-rb/mtracker/main/ios_install.plist"));
          },
          child: const Text("Install iOS App"),
        ),
      ),
    );
  }
}
