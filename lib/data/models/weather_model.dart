class WeatherModelData {

  final String cityName;
  final double currentTemp;
  final String localtime;
  final String weatherDescriptions;
  final double windSpeed;
  final int windDegree;
  final int pressure;
  final int humidity;
  final double feelslike;
  final int visibility;
  final int cloudiness;
  final String timeDate;
  final int seaLevel;
  final int grndLevel;
  final double tempMin;
  final double tempMax;
  final List weatherDayList;


  WeatherModelData(
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
      this.weatherDayList);

}




// localtime = forecastData.list[0]['dt_txt'];
// currentTemp = forecastData.list[0]['main']['temp'];
// weather_descriptions = forecastData.list[0]['weather'][0]['description'];
// wind_speed = forecastData.list[0]['wind']['speed'];
// wind_degree = forecastData.list[0]['wind']['deg'];
// pressure = forecastData.list[0]['main']['pressure'];
// humidity = forecastData.list[0]['main']['humidity'];
// feelslike = forecastData.list[0]['main']['feels_like'];
// visibility = forecastData.list[0]['visibility'];
// timeDate = forecastData.list[0]['dt_txt'];
// sea_level = forecastData.list[0]['main']['sea_level'];
// grnd_level = forecastData.list[0]['main']['grnd_level'];
// temp_min = forecastData.list[0]['main']['temp_min'];
// cloudiness = forecastData.list[0]['clouds']['all'];