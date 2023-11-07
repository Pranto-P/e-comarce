import 'package:craftybay/presentation/state_holders/categori_controller.dart';
import 'package:craftybay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:craftybay/presentation/ui/screens/product_list_screen.dart';
import 'package:craftybay/presentation/ui/widgets/categori_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriListScreen extends StatefulWidget {
  const CategoriListScreen({Key? key}) : super(key: key);

  @override
  State<CategoriListScreen> createState() => _CategoriListScreenState();
}

class _CategoriListScreenState extends State<CategoriListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<MainBottomNavController>().backToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Categories',
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
            Get.find<CategoriController>().getCategories();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<CategoriController>(
              builder: (categoriController) {
                if (categoriController.getCategoriesInProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  itemCount: categoriController.categoriModel.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: CategoriCard(
                        categoriData:
                            categoriController.categoriModel.data![index],
                        onTap: (){
                          Get.to(ProductListScreen(
                              categoryId: categoriController
                                  .categoriModel.data![index].id!));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
