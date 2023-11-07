import 'package:craftybay/data/models/network_response.dart';
import 'package:craftybay/data/services/network_caller.dart';
import 'package:craftybay/data/utility/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{
  bool _addToCartInProgress = false;
  String _message = '';

  bool get addToCartInProgress => _addToCartInProgress;
  String get message => _message;

  Future<bool> addToCart(int productId, String color, String size, int quanity) async{
    _addToCartInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(Urls.addToCart,{
      "product_id": productId,
      "color": color,
      "size": size,
      "qty": quanity

    });
    _addToCartInProgress = false;
    update();

    if(response.isSuccess){
      return true;
    } else {
      _message = 'Add To Cart Failed! try again';
      return false;
    }
  }
}