import 'package:flutter_dotenv/flutter_dotenv.dart';

String getToken() {
  final apiKey = dotenv.get('API_KEY');
  return apiKey;
}

String getBaseUrl() {
  final baseUrl = 'https://api.clashofclans.com/';
  return baseUrl;
}