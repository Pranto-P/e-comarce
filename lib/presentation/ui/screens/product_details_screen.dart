import 'package:craftybay/data/models/product_details.dart';
import 'package:craftybay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:craftybay/presentation/state_holders/product_details_controller.dart';
import 'package:craftybay/presentation/ui/utility/color_palette.dart';
import 'package:craftybay/presentation/ui/widgets/custom_stepper.dart';
import 'package:craftybay/presentation/ui/widgets/home/product_image_slider.dart';
import 'package:craftybay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {


  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int quanity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if(productDetailsController.getProductDetailsInProgress){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                             ProductImageSlider(
                               imageList: [
                                 productDetailsController.productDetails.img1 ?? '',
                                 productDetailsController.productDetails.img2 ?? '',
                                 productDetailsController.productDetails.img3 ?? '',
                                 productDetailsController.productDetails.img4 ?? '',
                               ]
                             ),
                            productDetailsAppbar
                          ],
                        ),
                      productDetails(productDetailsController.productDetails,
                          productDetailsController.availableColors)
                    ],
                    ),
                  ),
                ),
              cartToCartBottomContiner(
                  productDetailsController.productDetails,
                  productDetailsController.availableColors,
                  productDetailsController.availableSizes,
              )
            ],
            ),
          );
        }
      ),
    );
  }

  AppBar get productDetailsAppbar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),
      title: const Text('Product Details',style: TextStyle(
          color: Colors.black54
      ),),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Padding  productDetails (ProductDetails productDetails, List<String> colors){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.5),
                ),
              ),
              CustomStepper(
                  lowerLimit: 1,
                  upperLimit: 10,
                  stepValue: 1,
                  value: 1,
                  onChange: (newValue) {})
            ],
          ),
          Row(
            children: [
               Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(Icons.star,
                      size: 18, color: Colors.amber),
                  Text(
                    '${productDetails.product?.star ?? 0}',
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              TextButton(
                onPressed: (){},
                child: const Text('Reviews',style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500
                ),),
              ),
              const Card(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.favorite_border,
                      size: 16, color: Colors.white),
                ),
              )
            ],
          ),
          const Text(
            'Color',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          const SizedBox(height: 16,),
          SizedBox(
              height: 25,
              child: sizePicker(
                initialSelected: 0,
                onSelected: (int selectedSize){
                  _selectedColorIndex = selectedSize;
                },
                sizes: productDetails.color?.split(',') ?? [],
              )
          ),
          const SizedBox(height: 16,),
          const Text(
            'Size',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          const SizedBox(height: 16,),
          SizedBox(
              height: 25,
              child: sizePicker(
                initialSelected: 0,
                onSelected: (int selectedSize){
                  _selectedSizeIndex = selectedSize;
                },
                sizes: productDetails.size?.split(',') ?? [],
              )
          ),
          const SizedBox(height: 16,),
          const Text(
            'Description',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          const SizedBox(height: 16,),
           Text(productDetails.des ?? '')
        ],
      ),
    );
  }

  Container cartToCartBottomContiner(
      ProductDetails details, List<String> colors, List<String> sizes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '\$2000',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                if(addToCartController.addToCartInProgress){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () async {
                  final result = await addToCartController.addToCart(
                      details.id!,
                      colors[_selectedColorIndex].toString(),
                      sizes[_selectedSizeIndex],
                      quanity,
                  );
                  if(result){
                    Get.snackbar('Added to Cart', 'This product has been added to cart list',
                    snackPosition: SnackPosition.BOTTOM);
                  }
                },
                  child: const Text('Add To Cart'),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

}