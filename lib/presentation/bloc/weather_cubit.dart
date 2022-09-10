// class SocialAppCubit extends Cubit<SocialAppStates> {
//   SocialAppCubit() : super(SocialAppInitialState());

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/city_model.dart';
import '../../data/models/city_number.dart';
import '../../data/models/forecast_data.dart';
import '../../domain/services/location.dart';
import '../../domain/services/networking.dart';
import 'weather_state.dart';

class WeatherAppCubit extends Cubit<WeatherAppStates> {
  WeatherAppCubit() : super(WeatherAppInitialState());
  static WeatherAppCubit get(context) => BlocProvider.of(context);

  late String cityName = '';
  late num currentTemp;
  late String localtime = '';
  late String weatherDescriptions = '';
  late num windSpeed = 0;
  late int windDegree = 0;
  late int pressure = 0;
  late int humidity = 0;
  late num feelslike = 0;
  late int visibility = 0;
  late int cloudiness = 0;
  late String timeDate = '';
  late int seaLevel = 0;
  late int grndLevel = 0;
  late num tempMin = 0;
  late num tempMax = 0;
  late String iconIndicator = '';
  late List<dynamic> weatherDayList = [];
  late List<CityIdModel> cityList = [];


  void getCitiesFromJson() async {
    emit(WeatherAppFetchAllCitiesFromLocalJsonLoadingState());
    ApiService apiService = ApiService();
    CityModel cityModel = await apiService.fetchAllCitiesFromLocalJson();
    if (cityModel.data.isNotEmpty) {
      update(cityModel);
      emit(WeatherAppFetchAllCitiesFromLocalJsonSuccessState());
    }
  }

  void update(dynamic allCities) {
    for (var str in allCities.data) {
      cityList.add(CityIdModel(cityName: str['name'], id: str['id']));
    }
  }

  void getLocation() async {
    await Geolocator.requestPermission();
    Location location = Location();
    await location.getCurrentLocation(LocationAccuracy.low);
    getForecastInfoForLocation(location.latitude, location.longitude);
  }

  void getForecastInfoByCountryName(String name) async {
    emit(WeatherAppFetchForecastInfoByCountryLoadingState());
    await Geolocator.requestPermission();
    ApiService apiService = ApiService();
    ForecastData forecastData = await apiService.fetchForecastInfoByCountry(
        cityList.where((element) => element.cityName == name).first);
    if (forecastData != null) {
      _getApiValues(forecastData);
      emit(WeatherAppFetchForecastInfoByCountrySuccessState());
    }
  }

  void getForecastInfoForLocation(double latitude, double longitude) async {
    emit(WeatherAppFetchForecastInfoForLocationLoadingState());
    await Geolocator.requestPermission();
    ApiService apiService = ApiService();
    ForecastData forecastData =
        await apiService.fetchForecastInfoForLocation(latitude, longitude);

     if (forecastData != null) {
      _getApiValues(forecastData);
      emit(WeatherAppFetchForecastInfoForLocationSuccessState());
    }
  }

  void _getApiValues(ForecastData forecastData) {
    currentTemp = forecastData.list[0]['main']['temp'];
    localtime = forecastData.list[0]['dt_txt'];
    weatherDescriptions = forecastData.list[0]['weather'][0]['description'];
    windSpeed = forecastData.list[0]['wind']['speed'];
    windDegree = forecastData.list[0]['wind']['deg'];
    pressure = forecastData.list[0]['main']['pressure'];
    humidity = forecastData.list[0]['main']['humidity'];
    feelslike = forecastData.list[0]['main']['feels_like'];
    visibility = forecastData.list[0]['visibility'];
    timeDate = forecastData.list[0]['dt_txt'];
    seaLevel = forecastData.list[0]['main']['sea_level'];
    grndLevel = forecastData.list[0]['main']['grnd_level'];
    tempMin = forecastData.list[0]['main']['temp_min'];
    cloudiness = forecastData.list[0]['clouds']['all'];
    iconIndicator = forecastData.list[0]['weather'][0]['main'];
    tempMax = forecastData.list[0]['main']['temp_max'];
    cityName = forecastData.city['name'];
    weatherDayList = forecastData.list;
  }



}
