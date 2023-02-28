import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weatherapp/service/base_service.dart';

class WeatherService {
  BaseService service = BaseService();
  static const String apiKey = "cbb2b46ee2f949ef4955ab091899d4b3";

  Future<Response> getWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      double longitude = position.longitude;
      double latitude = position.latitude;
      Response response = await service.request(
          "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=cbb2b46ee2f949ef4955ab091899d4b3");
      print("_++++++++++++++++++${response.statusCode}");
      return response;
    } on DioError catch (e) {
      throw handleError(e);
    }
  }
}