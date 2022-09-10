import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../data/models/city_number.dart';
import '../../data/models/forecast_data.dart';
import '../../core/config/config.dart';
import '../../data/models/city_model.dart';

const String baseApiUrl = 'https://api.openweathermap.org/data/2.5/forecast';

class ApiService {

  Future<ForecastData> fetchForecastInfoForLocation(double latitude, double longitude) async {

    final response = await http.get(Uri.parse('$baseApiUrl?lat=$latitude&lon=$longitude&appid=$API_KEY&units=metric'));

    return _checkStatus(response);
  }
// https://api.openweathermap.org/data/2.5/forecast?q=London,us&mode=json&appid=7c3bbe76c4f0d5ed726d32bf9e632b01
  //https://api.openweathermap.org/data/2.5/forecast?id=5174&mode=json&appid=f4a1bb1731c4ced9669ef89d7d182c38&units=metric
  Future<ForecastData> fetchForecastInfoByCountry(CityIdModel cityFound) async {
    num countryId = cityFound.id;
    final response = await http.get(Uri.parse('$baseApiUrl?id=$countryId&mode=json&appid=$API_KEY&units=metric'));

    return _checkStatus(response);
  }

  Future<CityModel> fetchAllCitiesFromLocalJson() async {

    final String response = await rootBundle.loadString('local/cities/city.list.json');
    final data = await json.decode(response);
    return CityModel.fromJson(data);
  }


  _checkStatus(http.Response response) {
    if (response.statusCode == 200) {
      return ForecastData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch data');
    }
  }


}
