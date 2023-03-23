// ignore_for_file: constant_identifier_names

const String OPEN_AI_KEY =
    "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";

const String baseURL = "https://api.openai.com/v1";

String endPoint(String endPoint) => "$baseURL/$endPoint";

Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
