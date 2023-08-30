import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtracker/constants/bottom_nav_widget.dart';
import 'package:mtracker/constants/loader_widget.dart';
import 'package:mtracker/routes/route.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final monthSpendImage =
      "https://docs.google.com/spreadsheets/d/e/2PACX-1vS0Fylycl4uAvdE4P-_uCuNg97SbTGYjNgITALdHoyu1SineO72u-NLIeUNRMdcTOCtr5Es2Dczazp4/pubchart?oid=322567667";
  final totalSpendImage =
      "https://docs.google.com/spreadsheets/d/e/2PACX-1vS0Fylycl4uAvdE4P-_uCuNg97SbTGYjNgITALdHoyu1SineO72u-NLIeUNRMdcTOCtr5Es2Dczazp4/pubchart?oid=2001720007";

  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List> _fetchImage(imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return Future.value(response.bodyBytes);
    }
    return Future.value(Uint8List(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavWidget(
        onClick: (id) {
          switch (id) {
            case Buttons.home:
              Navigator.pushReplacementNamed(
                context,
                MTrackerRoutes.home,
              );
              break;
            case Buttons.add:
              Navigator.pushReplacementNamed(
                context,
                MTrackerRoutes.add,
              );
              break;
            default:
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    MTrackerRoutes.home,
                  );
                },
                child: const Text("Home"),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 10),
          const Text("This Month Spend Stats"),
          const SizedBox(height: 10),
          FutureBuilder(
            future: _fetchImage("$monthSpendImage&format=image"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoaderWidget();
              }
              return InkWell(
                onTap: () {
                  launchUrlString("$monthSpendImage&format=interactive");
                },
                child: Image.memory(snapshot.data!),
              );
            },
          ),
          const SizedBox(height: 10),
          const Text("Total Spend Stats"),
          const SizedBox(height: 10),
          FutureBuilder(
            future: _fetchImage("$totalSpendImage&format=image"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoaderWidget();
              }
              return InkWell(
                onTap: () {
                  launchUrlString("$totalSpendImage&format=interactive");
                },
                child: Image.memory(snapshot.data!),
              );
            },
          ),
        ]),
      ),
    );
  }
}
