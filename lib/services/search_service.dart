import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class SearchService {
  searchByField(String searchField) {
    return Firestore.instance
        .collection('collection-name')
        .where('document-field', isEqualTo: searchField.substring(0, 1))
        .getDocuments();
  }

  static Future<String> searchDjangoApi(String query) async {

    String url = 'http://192.168.43.129:8000/api/questions/?search=$query';
    http.Response response = await http.get(Uri.encodeFull(url));

    print("search_service.dart: searchDjangoApi: ${response.body}");

    return response.body;

  }

}
