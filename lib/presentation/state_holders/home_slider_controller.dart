import 'package:craftybay/data/models/network_response.dart';
import 'package:craftybay/data/models/slider_model.dart';
import 'package:craftybay/data/services/network_caller.dart';
import 'package:craftybay/data/utility/urls.dart';
import 'package:get/get.dart';

class HomeSlidersController extends GetxController{
  bool _getHomeSlidersInProgress = false;
  SliderModel _sliderModel = SliderModel();
  String _message = '';

  bool get getHomeSlidersInProgress => _getHomeSlidersInProgress;
  String get message => _message;
  SliderModel get sliderModel => _sliderModel;

  Future<bool> getHomeSliders() async{
    _getHomeSlidersInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getHomeSliders);
    _getHomeSlidersInProgress = false;
    update();

    if(response.isSuccess){
      _sliderModel = SliderModel.fromJson(response.responseJson ?? {});
      return true;
    } else {
      _message = 'Sliders data fetch failed';
      return false;
    }
  }
}