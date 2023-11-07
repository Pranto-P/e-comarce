import 'package:craftybay/data/models/cart_list_model.dart';
import 'package:craftybay/presentation/state_holders/cart_list_controller.dart';
import 'package:craftybay/presentation/ui/screens/product_details_screen.dart';
import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:craftybay/presentation/ui/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardProductCard extends StatelessWidget {
  final CartData cartData;
  const CardProductCard({
    super.key, required this.cartData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => ProductDetailsScreen(productId: cartData.product!.id!));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration:  BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(cartData.product?.image ?? ''))),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              cartData.product?.title ?? '',
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text:  TextSpan(
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12),
                                children: [
                                  TextSpan(text: 'Color: ${cartData.color ?? ''} '),
                                  TextSpan(text: 'Size: ${cartData.size ?? ''} '),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.find<CartListController>().removeFromCart(cartData.productId!);
                          },
                          icon: const Icon(Icons.delete_outline))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        '\$${cartData.product?.price ?? ''}',
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 85,
                        child: FittedBox(
                          child: CustomStepper(
                            lowerLimit: 1,
                            upperLimit: 20,
                            stepValue: 1,
                            value: cartData.quantity ?? 1,
                            onChange: (int value) {
                              Get.find<CartListController>().changeItem(cartData.id!, value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
