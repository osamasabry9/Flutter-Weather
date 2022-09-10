abstract class WeatherAppStates {}

// ------------InitialState----------------
class WeatherAppInitialState extends WeatherAppStates {}

class WeatherAppFetchForecastInfoForLocationLoadingState extends WeatherAppStates {}
class WeatherAppFetchForecastInfoForLocationSuccessState extends WeatherAppStates {}
class WeatherAppFetchForecastInfoForLocationErrorState extends WeatherAppStates {
  final String error;

  WeatherAppFetchForecastInfoForLocationErrorState(this.error);
}
class WeatherAppFetchForecastInfoByCountryLoadingState extends WeatherAppStates {}
class WeatherAppFetchForecastInfoByCountrySuccessState extends WeatherAppStates {}
class WeatherAppFetchForecastInfoByCountryErrorState extends WeatherAppStates {
  final String error;

  WeatherAppFetchForecastInfoByCountryErrorState(this.error);
}
class WeatherAppFetchAllCitiesFromLocalJsonLoadingState extends WeatherAppStates {}
class WeatherAppFetchAllCitiesFromLocalJsonSuccessState extends WeatherAppStates {}
class WeatherAppFetchAllCitiesFromLocalJsonErrorState extends WeatherAppStates {
  final String error;

  WeatherAppFetchAllCitiesFromLocalJsonErrorState(this.error);
}


