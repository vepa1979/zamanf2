import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'dart:io';


class HomeScreen extends StatelessWidget {


  int _selectedIndex=0;









  Future<List> _loadData() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const apiUrl = 'https://sanlysahypa.com/index.php/urunler/getforhome';

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zaman Türkmenistan'),
      ),
      // implement FutureBuilder
      body: FutureBuilder(
          future: _loadData(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
          snapshot.hasData
              ? ListView.builder(
            // render the list
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) => Card(
              margin: const EdgeInsets.all(10),
              // render list item
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: SizedBox(
                    height: 100.0,
                    width: 100.0, // fixed width and height
                    child: Image.network(snapshot.data![index]['suraty'])
                ),
                title: Text(snapshot.data![index]['suraty']),
                subtitle: Text(snapshot.data![index]['ady']),
              ),
            ),
          )
              : const Center(
            // render the loading indicator
            child: CircularProgressIndicator(),
          )),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Esasy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Täze',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Agza',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          switch (index) {
            case 0:
            // only scroll to top when current index is selected.
              showModal(context);
              break;
            case 1:
              showModal(context);
              break;
          }

        },
      ),
    );

  }



  void showModal(BuildContext context) {

    Navigator.pushNamed(context, '/details');



  }




}


