import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../core/components/chart.dart';
import '../../../core/utils/app_colors.dart';
import '../../../domain/services/weather.dart';
import '../card_widget.dart';

class TodayTemperaturesList extends StatelessWidget {
  final bool isLight;
  final bool isCollapsed;
  final List<TemperatureTimeData> weatherForecastList;
  final List<dynamic> weatherList;

  const TodayTemperaturesList({
    Key? key,
    required this.isLight,
    required this.isCollapsed,
    required this.weatherForecastList,
    required this.weatherList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Padding _buildListItem(int index) {
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(weatherForecastList[index].time.toString(),
                style: AppColors.collapsedSmallTextStyle(context, isCollapsed)),
            const SizedBox(height: 15),
            Image(
              width: 30,
              image: AssetImage(WeatherModel.getWeatherImage(
                  weatherList[index]['weather'][0]['main'])),
            ),
            const SizedBox(height: 15),
            Text('${weatherForecastList[index].temp.toString()}°',
                style:
                    AppColors.collapsedMediumTextStyle(context, isCollapsed)),
            const SizedBox(height: 15),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CardWidget(
        isLight: isLight,
        isCollapsed: isCollapsed,
        widget: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 7; i++) _buildListItem(i),
                ],
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(10.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (index) => weatherForecastList[index].time,
                yValueMapper: (index) => weatherForecastList[index].temp,
                dataCount: 7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
