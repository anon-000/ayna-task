import 'package:ayna_task/config/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

///
/// Created by Auro on 26/06/24
///

class AnimatedSkull extends StatefulWidget {
  const AnimatedSkull({super.key});

  @override
  State<AnimatedSkull> createState() => _AnimatedSkullState();
}

class _AnimatedSkullState extends State<AnimatedSkull> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();

    _composition = AssetLottie(AppAssets.skullAnimLottie).load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FutureBuilder<LottieComposition>(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) {
            return Lottie(composition: composition);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
