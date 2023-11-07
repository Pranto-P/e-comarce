import 'package:craftybay/data/models/network_response.dart';
import 'package:craftybay/data/models/product_model.dart';
import 'package:craftybay/data/services/network_caller.dart';
import 'package:craftybay/data/utility/urls.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  bool _getPopularProductsInProgress = false;
  ProductModel _popularProductModel = ProductModel();
  String _errorMessage = '';

  bool get getPopularProductsInProgress => _getPopularProductsInProgress;

  ProductModel get popularProductModel => _popularProductModel;

  String get errorMessage => _errorMessage;

  Future<bool> getPopularProducts() async {
    _getPopularProductsInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductsByRemarks('popular'));
    _getPopularProductsInProgress = false;
    if (response.isSuccess) {
      _popularProductModel = ProductModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _errorMessage = 'Popular Product fetch failed! try again';
      update();
      return false;
    }
  }
}
