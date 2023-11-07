import 'package:craftybay/presentation/state_holders/categori_controller.dart';
import 'package:craftybay/presentation/state_holders/home_slider_controller.dart';
import 'package:craftybay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:craftybay/presentation/state_holders/new_product_controller.dart';
import 'package:craftybay/presentation/state_holders/popular_product_controller.dart';
import 'package:craftybay/presentation/state_holders/special_product_controller.dart';
import 'package:craftybay/presentation/ui/screens/product_list_screen.dart';
import 'package:craftybay/presentation/ui/utility/image_assets.dart';
import 'package:craftybay/presentation/ui/widgets/categori_card.dart';
import 'package:craftybay/presentation/ui/widgets/circular_icon_button.dart';
import 'package:craftybay/presentation/ui/widgets/home/home_slider.dart';
import 'package:craftybay/presentation/ui/widgets/home/section_header.dart';
import 'package:craftybay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(ImageAssets.craftyBayNavlogoSvg),
            const Spacer(),
            CircularButtonIcon(
              onTap: () {},
              icon: Icons.person,
            ),
            const SizedBox(width: 8),
            CircularButtonIcon(
              onTap: () {},
              icon: Icons.call,
            ),
            const SizedBox(width: 8),
            CircularButtonIcon(
              onTap: () {},
              icon: Icons.notifications_active_outlined,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              GetBuilder<HomeSlidersController>(
                  builder: (homeSliderController) {
                if (homeSliderController.getHomeSlidersInProgress) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return HomeSlider(
                  sliders: homeSliderController.sliderModel.data ?? [],
                );
              }),
              SectionHeader(
                title: 'All Categories',
                onTap: () {
                  Get.find<MainBottomNavController>().changeScreen(1);
                },
              ),
              SizedBox(
                height: 100,
                child: GetBuilder<CategoriController>(
                    builder: (categoriController) {
                  if (categoriController.getCategoriesInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        categoriController.categoriModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CategoriCard(
                        categoriData:
                            categoriController.categoriModel.data![index],
                        onTap: (){
                          Get.to(ProductListScreen(
                              categoryId: categoriController
                                  .categoriModel.data![index].id!));
                        },
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 8),
              SectionHeader(
                title: 'Popular',
                onTap: () {
                  Get.to(
                    ProductListScreen(
                      productModel:
                      Get.find<PopularProductController>().popularProductModel,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 165,
                child: GetBuilder<PopularProductController>(
                    builder: (productController) {
                  if (productController.getPopularProductsInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        productController.popularProductModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product:
                            productController.popularProductModel.data![index],
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'Special',
                onTap: () {
                  Get.to(
                    ProductListScreen(
                      productModel: Get.find<SpecialProductController>()
                          .specialProductModel,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 165,
                child: GetBuilder<SpecialProductController>(
                    builder: (specialProductController) {
                  if (specialProductController.getSpecialProductsInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialProductController
                            .specialProductModel.data?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: specialProductController
                            .specialProductModel.data![index],
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'New',
                onTap: () {
                  Get.to(
                    ProductListScreen(
                      productModel:
                          Get.find<NewProductController>().newProductModel,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 165,
                child: GetBuilder<NewProductController>(
                  builder: (newProductController) {
                    if (newProductController.getNewProductsInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          newProductController.newProductModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product:
                              newProductController.newProductModel.data![index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
