// ignore_for_file: constant_identifier_names

const String OPEN_AI_KEY = "GET YOUR OWN KEY FROM OPEN AI";

const String baseURL = "https://api.openai.com/v1";

String endPoint(String endPoint) => "$baseURL/$endPoint";

Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
