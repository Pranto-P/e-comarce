import 'package:craftybay/presentation/state_holders/cart_list_controller.dart';
import 'package:craftybay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:craftybay/presentation/ui/screens/checkOut_screen.dart';
import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:craftybay/presentation/ui/widgets/card_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.find<MainBottomNavController>().backToHome();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<CartListController>().getCartList();
        },
        child: GetBuilder<CartListController>(
          builder: (cartListController) {
            if(cartListController.getCartListInProgress){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartListController.cartListModel.data?.length ?? 0,
                      itemBuilder: (context, index){
                    return  CardProductCard(
                      cartData: cartListController.cartListModel.data![index],
                    );
                  })
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Text(
                            'Total Price',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '\$${cartListController.totalPrice}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: 120,
                          child: ElevatedButton(
                              onPressed: () {
                                if(Get.find<CartListController>().cartListModel.data?.isNotEmpty ?? false){
                                  Get.to(() => const CheckOutScreen());
                                }
                              },
                              child: const Text('Checkout')))
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

