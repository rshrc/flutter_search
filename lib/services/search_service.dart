import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByField(String searchField) {
    return Firestore.instance
        .collection('collection-name')
        .where('document-field', isEqualTo: searchField.substring(0, 1))
        .getDocuments();
  }
}
