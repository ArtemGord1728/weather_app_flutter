class OpenWeatherApi {

  final String apiKey;
  OpenWeatherApi(this.apiKey);


  static const String _apiBaseUrl = "api.openweathermap.org";
  static const String _apiPath = "/data/2.5/";

  Uri weather(String city, String units) => _buildUrl(
    endpoint: "weather",
    parametersBuilder: () => cityQueryParams(city, units),
  );

  Uri forecast(String city, String units) => _buildUrl(
    endpoint: "forecast",
    parametersBuilder: () => cityQueryParams(city, units),
  );

  Uri _buildUrl({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> cityQueryParams(String city, String units) => {
    "q": city,
    "appid": apiKey,
    "units": units
  };
}