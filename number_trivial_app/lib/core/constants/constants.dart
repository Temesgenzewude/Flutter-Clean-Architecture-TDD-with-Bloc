class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'c23ffe9e198c05988d27ef9953b72a20';
  static String currentWeatherByName(String city) {
    return '$baseUrl/weather?q=$city&appid=$apiKey';
  }

  static String weatherIcon(String icon) {
    return 'http://openweathermap.org/img/wn/$icon@2x.png';
  }

  static const String numberTriviaBaseUrl = "http://numbersapi.com/";
}
