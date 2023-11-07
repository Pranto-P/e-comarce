import 'package:craftybay/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                    child: SvgPicture.asset(
                  ImageAssets.craftyBaylogoSvg,
                  width: 120,
                )),
                const SizedBox(height: 16),
                Text(
                  'Complete Profile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 4),
                Text(
                  'Get started with us with your details',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'City',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Shipping Address',
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Complete'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
