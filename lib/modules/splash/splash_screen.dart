import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Image(
        image: AssetImage(
            'assets/images/error.webp',
        ),
      ),
    );
  }
}
