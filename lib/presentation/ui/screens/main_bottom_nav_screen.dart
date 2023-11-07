import 'package:craftybay/presentation/state_holders/categori_controller.dart';
import 'package:craftybay/presentation/state_holders/home_slider_controller.dart';
import 'package:craftybay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:craftybay/presentation/state_holders/new_product_controller.dart';
import 'package:craftybay/presentation/state_holders/popular_product_controller.dart';
import 'package:craftybay/presentation/state_holders/special_product_controller.dart';
import 'package:craftybay/presentation/ui/screens/cart_screen.dart';
import 'package:craftybay/presentation/ui/screens/categori_list_screen.dart';
import 'package:craftybay/presentation/ui/screens/home_screen.dart';
import 'package:craftybay/presentation/ui/screens/wish_list_screen.dart';
import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _sereens = [
    const HomeScreen(),
    const CategoriListScreen(),
    const CartScreen(),
    const WishListScreen()
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeSlidersController>().getHomeSliders();
      Get.find<CategoriController>().getCategories();
      Get.find<PopularProductController>().getPopularProducts();
      Get.find<SpecialProductController>().getSpecialProducts();
      Get.find<NewProductController>().getNewProducts();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) {
        return Scaffold(
          body: _sereens[controller.currentSelectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            elevation: 4,
            currentIndex: controller.currentSelectedIndex,
            onTap: controller.changeScreen,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: 'Categoris'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), label: 'Wish'),
            ],
          ),
        );
      },
    );
  }
}
