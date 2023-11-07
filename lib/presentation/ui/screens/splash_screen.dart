import 'package:craftybay/presentation/state_holders/auth_controller.dart';
import 'package:craftybay/presentation/ui/screens/auth/email_verification_screen.dart';
import 'package:craftybay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:craftybay/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Get.offAll(() => AuthController.isLoggedIn
          ? const MainBottomNavScreen()
          : const EmailVerificationScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
              child: SvgPicture.asset(
            ImageAssets.craftyBaylogoSvg,
            width: 120,
          )),
          const Spacer(),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          const Text('Version 1.0.0'),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
