import 'package:craftybay/data/models/product_model.dart';
import 'package:craftybay/presentation/state_holders/product_list_controller.dart';
import 'package:craftybay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  final int? categoryId;
  final ProductModel?  productModel;
  const ProductListScreen({Key? key,  this.categoryId, this.productModel}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.categoryId != null) {
        Get.find<ProductListController>()
            .getProductsByCategory(widget.categoryId!);
      } else if (widget.categoryId != null){
        Get.find<ProductListController>().setProducts(widget.productModel!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Categori',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: GetBuilder<ProductListController>(
        builder: (productListController) {
          if(productListController.getProductsInProgress){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(productListController.productModel.data?.isEmpty ?? true){
            return const Center(
              child: Text('Empty List'),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              itemCount: productListController.productModel.data?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ProductCard(
                    product: productListController.productModel.data![index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
