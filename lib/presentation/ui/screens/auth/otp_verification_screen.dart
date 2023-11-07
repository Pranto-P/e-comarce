import 'package:craftybay/presentation/state_holders/otp_verification_controller.dart';
import 'package:craftybay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:craftybay/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final TextEditingController _otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                    child: SvgPicture.asset(
                  ImageAssets.craftyBaylogoSvg,
                  width: 120,
                )),
                const SizedBox(height: 16),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 4),
                Text(
                  'A 6 Digit OTP Code has been Sent',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  controller: _otpTEController,
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.grey,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: AppColors.primaryColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<OtpVerificationController>(
                    builder: (controller) {
                      if(controller.otpVerificationInProgress){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          verifyOtp(controller);
                        },
                        child: const Text('Next'),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(text: 'This code will expire in '),
                      TextSpan(
                        text: '120s',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Resend Code'),
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> verifyOtp(OtpVerificationController controller) async {
    final response =
    await controller.verifyOtp(widget.email, _otpTEController.text.trim());
    if (response) {
      Get.offAll(() => const MainBottomNavScreen());
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp Verification Failed! try again'),
          ),
        );
      }
    }
  }
}
