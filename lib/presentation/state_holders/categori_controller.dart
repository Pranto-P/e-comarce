import 'package:craftybay/data/models/categori_model.dart';
import 'package:craftybay/data/models/network_response.dart';
import 'package:craftybay/data/services/network_caller.dart';
import 'package:craftybay/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoriController extends GetxController{
  bool _getCategoriesInProgress = false;
  CategoriModel _categoriModel = CategoriModel();
  String _message = '';

  bool get getCategoriesInProgress => _getCategoriesInProgress;
  String get message => _message;
  CategoriModel get categoriModel => _categoriModel;

  Future<bool> getCategories() async{
    _getCategoriesInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getCategories);
    _getCategoriesInProgress = false;
    update();

    if(response.isSuccess){
      _categoriModel = CategoriModel.fromJson(response.responseJson ?? {});
      return true;
    } else {
      _message = 'Categori list data fetch failed';
      return false;
    }
  }
}