import 'package:http/http.dart' as http;
import 'api_client.dart';

mixin AppApiClient on ApiClient {

  Future<String> getVersion() async {
    final response = await http.get(Uri.parse('$baseUrl/app/version'));

    switch (response.statusCode) {
      case 200:
        return response.body;
      default:
        throw Exception('Failed to get application version');
    }
  }
}