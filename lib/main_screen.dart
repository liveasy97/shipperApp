import 'package:flutter/material.dart';
import '/Web/screens/login.dart';
import '/responsive.dart';
import 'main_android.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: Android(),
        tablet: LoginScreen(),
        desktop: LoginScreen(),
      ),
    );
  }
}
