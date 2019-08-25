import 'package:flutter_search/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var targetValue = value.substring(0, 1) + value.substring(1);

    print("search_page.dart: initiateSearch: $targetValue");

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByField(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          print("search_page.dart: initiateSearch: ${docs.documents[i].data}");
          setState(() {
            queryResultSet.add(docs.documents[i].data);
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['document-field'].startWith(targetValue)) {
          setState(() {
            print("search_page.dart: initiateSearch: $element");
            print("search_page.dart: elemnt type: ${element.runtimeType}");
            print("search_page.dart ${element['document-field']}");
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build function: ${queryResultSet.toString()}");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Search"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  initiateSearch(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by Document Field',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      // initialte search
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GridView.count(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                primary: false,
                shrinkWrap: true,
                children: queryResultSet.map((element) {
                  print("search_page.dart: $element");
                  return buildResultCard(element);
                }).toList())
          ],
        ),
      ),
    );
  }
}

Widget buildResultCard(data) {
  print("search_page.dart: $data and type: ${data.runtimeType}");

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2.0,
    child: Container(
      child: Center(
        child: Text(
          data['document-field'],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    ),
  );
}
