import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtracker/app/data/providers/bucket_provider.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: BucketProvider().getAllBucket(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return Text(
              'HomeView is working : ${snapshot.data}',
            );
          },
        ),
      ),
    );
  }
}
