import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/utils/media_query_values.dart';
import '../../data/models/forecast_data.dart';
import 'city_screen.dart';
import '../../domain/services/networking.dart';
import '../../data/models/city_model.dart';
import '../../data/models/city_number.dart';
import '../../domain/services/location.dart';
import '../../core/components/custom_search_delegate.dart';


class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key, this.cityName});

  String? cityName;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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


  late ScrollController _scrollController;
  bool _appBarCollapsed = false;

  @override
  void initState() {
    super.initState();

    if (widget.cityName == null) {
      getLocation();
    } else {
      cityName = widget.cityName!;
      getForecastInfoByCountryName(cityName);
    }
    _scrollController = ScrollController()
      ..addListener(() {
        if (isCollapsed() && !_appBarCollapsed) {
          setState(() => _appBarCollapsed = true);
        } else if (!isCollapsed() && _appBarCollapsed) {
          setState(() => _appBarCollapsed = false);
        }
      });
    getCitiesFromJson();
  }

  bool isCollapsed() =>
      _scrollController.hasClients &&
      _scrollController.offset > (230 - kToolbarHeight);

  void getCitiesFromJson() async {
    ApiService apiService = ApiService();
    CityModel cityModel = await apiService.fetchAllCitiesFromLocalJson();
    update(cityModel);
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
    await Geolocator.requestPermission();
    ApiService apiService = ApiService();
    ForecastData forecastData = await apiService.fetchForecastInfoByCountry(
        cityList.where((element) => element.cityName == name).first);

    setState(() {
      _getApiValues(forecastData);
    });
  }

  void getForecastInfoForLocation(double latitude, double longitude) async {
    await Geolocator.requestPermission();
    ApiService apiService = ApiService();
    ForecastData forecastData =
        await apiService.fetchForecastInfoForLocation(latitude, longitude);

    //print(forecastData);

    setState(() {
      _getApiValues(forecastData);
    });
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


  @override
  Widget build(BuildContext context) {
    bool isLight = context.brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(cityName.toUpperCase()),
        leading: GestureDetector(
          child: Icon(Icons.navigation),
          onTap: () {
            getLocation();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
                splashRadius: 20.0,
                onPressed: () {
                  if (cityList.isNotEmpty) {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(allCities: cityList),
                    );
                  }
                },
                icon: Icon(Icons.search, color: Colors.white)),
          ),
        ],
      ),
      body: weatherDescriptions == ''
          ? Center(child: CircularProgressIndicator())
          : CityScreen(
              isLight: isLight,
              isCollapsed: _appBarCollapsed,
              cityName: cityName,
              currentTemp: currentTemp,
              localtime: localtime,
              weatherDescriptions: weatherDescriptions,
              windSpeed: windSpeed,
              windDegree: windDegree,
              pressure: pressure,
              humidity: humidity,
              feelslike: feelslike,
              visibility: visibility,
              cloudiness: cloudiness,
              timeDate: timeDate,
              seaLevel: seaLevel,
              grndLevel: grndLevel,
              tempMin: tempMin,
              tempMax: tempMax,
              iconIndicator: iconIndicator,
              weatherList: weatherDayList,
            ),
    );
  }
}
