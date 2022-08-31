import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitWave(
          size: 60,
          color: Color(0XFF0F75BC),
        )
      ),
    );
  }
}