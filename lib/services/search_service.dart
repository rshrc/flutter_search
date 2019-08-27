import 'package:http/http.dart' as http;

class SearchService {
  static Future<String> searchDjangoApi(String query) async {
    String url = 'http://192.168.43.129:8000/api/questions/?search=$query';
    http.Response response = await http.get(Uri.encodeFull(url));

    print("search_service.dart: searchDjangoApi: ${response.body}");

    return response.body;
  }
}
