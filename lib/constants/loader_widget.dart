import 'package:flutter/material.dart';
import 'package:mtracker/constants/assets.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.2,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          child: Image.asset(
            Assets.assetsImagesRefreshLoader,
            fit: BoxFit.cover,
            cacheHeight: 1,
            cacheWidth: 1,
          ),
        ),
      ),
    );
  }
}
