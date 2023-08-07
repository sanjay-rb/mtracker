import 'package:flutter/material.dart';
import 'package:mtracker/constants/assets.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  List<Image> images = [
    Assets.assetsImagesLoader0,
    Assets.assetsImagesLoader1,
    Assets.assetsImagesLoader2,
    Assets.assetsImagesLoader3,
    Assets.assetsImagesLoader4,
    Assets.assetsImagesLoader5,
  ]
      .map(
        (e) => Image.asset(
          e,
          gaplessPlayback: true,
          fit: BoxFit.cover,
          cacheHeight: 1,
          cacheWidth: 1,
        ),
      )
      .toList();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 80 * images.length),
    )..repeat();
    _animation = IntTween(begin: 0, end: 5).animate(_controller);
  }

  @override
  void didChangeDependencies() {
    for (var element in images) {
      precacheImage(element.image, context);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return images[_animation.value];
            },
          ),
        ),
      ),
    );
  }
}
