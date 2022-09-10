import 'package:flutter/material.dart';
import '../../core/components/chart.dart';
import '../../core/constants.dart';
import 'package:weather_app/core/utils/app_colors.dart';
import '../../core/components/column_forecast.dart';
import '../../core/components/weather_parameter.dart';
import '../../domain/services/weather.dart';
import 'package:intl/intl.dart';

import '../widgets/cards/today_card.dart';
import '../widgets/cards/today_temp_list.dart';

class CityScreen extends StatefulWidget {
  CityScreen({
    super.key,
    this.cityName,
    this.currentTemp,
    this.localtime,
    this.weatherDescriptions,
    this.windSpeed,
    this.windDegree,
    this.pressure,
    this.humidity,
    this.feelslike,
    this.visibility,
    this.cloudiness,
    this.timeDate,
    this.seaLevel,
    this.grndLevel,
    this.tempMin,
    this.tempMax,
    this.iconIndicator,
    this.weatherList,
    required this.isLight,
    required this.isCollapsed,
  });
  final bool isLight;
  final bool isCollapsed;
  String? cityName;
  num? currentTemp;
  String? localtime;
  String? weatherDescriptions;
  num? windSpeed;
  int? windDegree;
  int? pressure;
  int? humidity;
  num? feelslike;
  int? visibility;
  int? cloudiness;
  String? timeDate;
  int? seaLevel;
  int? grndLevel;
  num? tempMin;
  num? tempMax;
  String? iconIndicator;
  List<dynamic>? weatherList;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName = '';
  String result = '';
  bool forecastToggle = false;
  List<TemperatureTimeData> weatherForecastList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      weatherForecastList.add(TemperatureTimeData(
          time: DateFormat()
              .add_j()
              .format(DateTime.parse(widget.weatherList![i]['dt_txt'])),
          temp: double.parse(
              (widget.weatherList![i]['main']['temp']!.toInt().toString()))));
    }

    return Scaffold(
      body: widget.currentTemp == 0.0
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 1.3,
                  stops: const [0.4, 3.5],
                  colors: [
                    AppColors.darkGrey,
                    AppColors.darkGrey,
                  ],
                ),
              ),
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.cityName ?? cityName,
                                      style: TextStyle(fontSize: 40.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '${widget.weatherDescriptions}',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: AppColors.lightGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        cardWeatherToday(),

                        //color: Color(0x99452e7d),
                        // color: Color(0xff56319c),
                        forecastFiveDays(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Card cardWeatherToday() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(
          color: kDarkVioletLighter,
          width: 1.8,
        ),
      ),
      color: Color(0x222b2157),
      margin: EdgeInsets.all(15.0),
      child: Padding(
        padding: EdgeInsets.all(
          30.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat.MMMMEEEEd()
                      .format(DateTime.parse(widget.weatherList![0]['dt_txt'])),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          (widget.currentTemp!.toInt().toString()),
                          style: TextStyle(
                              fontSize: 70.0, fontWeight: FontWeight.w600),
                        ),
                        Baseline(
                          baseline: 0,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            '${kCelsiusSign}C',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                              color: kYellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Feels like ${(widget.currentTemp!.toInt().toString())}${kCelsiusSign}C',
                      style: TextStyle(
                        color: kGrayishBlue,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 20.0,
                    top: 25.0,
                  ),
                  child: Image(
                    width: 135.0,
                    image: AssetImage(WeatherModel.getWeatherImage(
                        widget.iconIndicator.toString())),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherParameter(
                    icon: Icons.air,
                    text: 'Wind',
                    value: '${widget.windSpeed} km/h',
                  ),
                  WeatherParameter(
                      icon: Icons.water_drop,
                      text: 'Humidity',
                      value: '${widget.humidity}%'),
                  WeatherParameter(
                      icon: Icons.visibility,
                      text: 'Visibility',
                      value: '${widget.visibility}'),
                  WeatherParameter(
                      icon: Icons.compare_arrows,
                      text: 'Pressure',
                      value: '${widget.pressure}'),
                  WeatherParameter(
                      icon: Icons.cloud,
                      text: 'Cloudiness',
                      value: '${widget.cloudiness}%'),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      widget.cityName ?? cityName,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Container forecastFiveDays() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [
            0.1,
            2.0,
          ],
          begin: Alignment(0.0, 0.0),
          end: Alignment(0.0, 1.0),
          colors: [
            AppColors.darkGrey,
            AppColors.darkGrey,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 10,
            blurRadius: 20,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        children: [
          TodayTemperaturesList(
            isCollapsed: widget.isCollapsed,
            isLight: widget.isLight,
            weatherForecastList: weatherForecastList,
            weatherList: widget.weatherList!,
          ),
          TodayCard(),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              '3 hours / 5 days forecast',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < widget.weatherList!.length; i++)
                  ColumnForecast(
                    weekDayName: DateFormat.MMMd().format(
                        DateTime.parse(widget.weatherList![i]['dt_txt'])),
                    dayMonth: DateFormat().add_j().format(
                        DateTime.parse(widget.weatherList![i]['dt_txt'])),
                    assetImage: AssetImage(WeatherModel.getWeatherImage(
                        widget.weatherList![i]['weather'][0]['main'])),
                    degrees: (widget.weatherList![i]['main']['temp']!
                        .toInt()
                        .toString()),
                    description:
                        '${widget.weatherList![i]['weather'][0]['description']}',
                    minDegrees: (widget.weatherList![i]['main']['temp_min']!
                        .toInt()
                        .toString()),
                    maxDegrees: (widget.weatherList![i]['main']['temp_max']!
                        .toInt()
                        .toString()),
                    toggle: forecastToggle,
                    toggleState: () {
                      setState(() {
                        forecastToggle = !forecastToggle;
                      });
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
