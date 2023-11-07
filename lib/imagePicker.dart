import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:xid/xid.dart';

import 'dart:io';
import 'main.dart';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';








String dropDownValuewel="Welaýat";
String dropDownValuecats="Bölüm";

class MultipleImageSelector extends StatefulWidget {
  const MultipleImageSelector({super.key});





  @override
  State<MultipleImageSelector> createState() => _MultipleImageSelectorState();
}












class _MultipleImageSelectorState extends State<MultipleImageSelector> {






  List<File> selectedImages = [];


  String hid=Xid().toString();

  final picker = ImagePicker();

  String dropdownValue ="";
  String dropdownchildValue = "";
  String dropdownValuewelayat ="aaa";


final _controller=TextEditingController();
  final _controller2=TextEditingController();
  final _controller_price=TextEditingController();


  List<Widget> widgets = [];


  bool _addNewTax = false;








  Future<List> _loadDatacats() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const apiUrl = 'https://sanlysahypa.com/index.php/categories/getcats';

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);


    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }


  Future<List> _loadWelaat() async {
    List posts =[{"ady":"Aşgabat"},{"ady":"Ahal"},{"ady":"Balkan"},{"ady":"Mary"},{"ady":"Lebap"},{"ady":"Daşoguz"}];


    return posts;
  }











  @override
  Widget build(BuildContext context) {
    // display image selected from gallery
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Täze reklama goş'),
        //backgroundColor: Colors.green,
        actions: const [],
      ),
      body: SingleChildScrollView(

    child: Padding(
    padding: EdgeInsets.all(16.0),
    child:

    Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [



            Padding(
              padding: EdgeInsets.only(left:16.0),
              child:Text("Suratlary saýlaň"),
            ),
            Center(

              child:FloatingActionButton(

                backgroundColor:Colors.deepOrange,
                onPressed: (){

                  getImages();

                },
                tooltip: 'Increment',
                child: new Icon(Icons.add),
                elevation: 6.0,
              ),

            ),

            Padding(
              padding: EdgeInsets.only(left:16.0),
              child:Text(""),
            ),
            Center(

              child: Container(
                width: 300.0,
                height: 100.0,
                child: selectedImages.isEmpty
                    ? Center(

                    child: Text("Haryda degişli suratlar"),

                )
                    : GridView.builder(
                  itemCount: selectedImages.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: kIsWeb
                            ? Image.network(selectedImages[index].path)
                            : Image.file(selectedImages[index]));
                  },
                ),
              ),
            ),



             Column(
              children: [

                Row(
                  children: [
                    Container(
                      width:200,
                      child:
                        Padding(
                          padding: EdgeInsets.only(left:16.0),
                          child:Text("Welaýat saýlaň"),

                        ),
                    ),
                    Container(
                      child:Padding(
                        padding: EdgeInsets.only(left:16.0),
                        child:Padding(
                          padding: EdgeInsets.all(0),

                          child:new Row(
                            children: [
                              FutureBuilder(
                                future:_loadWelaat(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  return snapshot.hasData
                                      ? Container(
                                    child: DropdownButton<String>(
                                      hint: Text(dropDownValuewel ?? 'Make a selection'),
                                      items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                        return DropdownMenuItem<String>(
                                          value:item["ady"],
                                          child: Text(item["ady"]),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropDownValuewel =value.toString();
                                          dynamicText="";

                                          listselected.clear();

                                          listselected.add(value.toString());

                                          Navigator.pushNamed(
                                            context,
                                            "/welayat",
                                            arguments: WelayatArguments(
                                                value.toString()
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  )
                                      : Container(
                                    child: Center(
                                      child: Text('Loading...'),
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),


                        ),

                      ),
                    ),
                  ],
            ),




          ]
            ),


            Padding(
              padding: EdgeInsets.only(left:16.0),
              child: Text(
                '$dynamicTextwel',
                style: TextStyle(color: Colors.grey),
              ),
            ),


            Column(
                children: [

                  Row(
                    children: [
                      Container(
                        width:200,
                        child:
                        Padding(
                          padding: EdgeInsets.only(left:16.0),
                          child:Text("Bölüm saýlaň"),

                        ),
                      ),
                      Container(
                        child:Padding(
                          padding: EdgeInsets.only(left:16.0),
                          child:Padding(
                            padding: EdgeInsets.all(0),

                            child:new Row(
                              children: [


                                FutureBuilder(
                                  future:_loadDatacats(),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    return snapshot.hasData
                                        ? Container(
                                      child: DropdownButton<String>(
                                        hint: Text(dropDownValuecats ?? 'Make a selection'),
                                        items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                          return DropdownMenuItem<String>(
                                            value:item["ady"],
                                            child: Text(item["ady"]),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            dropDownValuecats =value.toString();
                                            dynamicText="";

                                                  listselected.clear();

                                                  listselected.add(value.toString());

                                                  Navigator.pushNamed(
                                                    context,
                                                    "/parent",
                                                    arguments: ParentArguments(
                                                        value!
                                                    ),
                                                  );
                                          });
                                        },
                                      ),
                                    )
                                        : Container(
                                      child: Center(
                                        child: Text('Loading...'),
                                      ),
                                    );
                                  },
                                ),






                              ],
                            ),


                          ),

                        ),
                      ),
                    ],
                  ),




                ]
            ),





            Padding(
              padding: EdgeInsets.only(left:16.0),
              child: Text(
                '$dynamicText',
                style: TextStyle(color: Colors.grey),
              ),
            ),





            Padding(
              padding: EdgeInsets.only(left:16,top:16),
              child: Text(
                "Haryt barada",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                maxLines:2, //or null
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Haryt barada giňişleýin maglumat',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:16.0),
              child: Text(
                "Bahasy",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _controller_price,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '1000,25',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left:16.0),
              child: Text(
                "Mobil Belgiňiz",
                style: TextStyle(color: Colors.black),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _controller2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '+9936xxxxxxx',
                ),
              ),
            ),




            Padding(
              padding: EdgeInsets.all(16.0),
            child:Row(

              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {

                    uploadpost(this._controller,this._controller2);

                  },
                  child: const Text('+ Goş'),


                ),
                SizedBox(width:16), // give it width
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {

                    uploadpost(this._controller,this._controller2);

                  },
                  child: const Text('Bes Et'),


                ),
              ],


            )



        ),


          ],
        ),
    ),
      ),
    );
  }


Future getchild(parentcat) async{

   // this.dropdownchildValue=parentcat;

  listcategorychild.first="Bölüm saýlaň";
  listcategorychild.add("deneme");
  setState(() {
    _addNewTax = true;
  });

}




  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 500, maxWidth: 500);



    //pickedFile.add(XFile("assets/images/logo.jpg"));
    
    
    
    List<XFile> xfilePick = pickedFile;





    setState(
          () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
            final bytes = File(xfilePick[i].path).readAsBytesSync();
            String base64Image = base64Encode(bytes);



            var simg=new sendimg();
            simg.send(base64Image,this._controller,hid);




          }




        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }





  uploadpost(controller,controller2) async{



    final http.Response response = await http.post(
      Uri.parse('https://sanlysahypa.com/index.php/urunler/updatepost'),
      body: jsonEncode(<String, String>{
        'bolum': dropDownValuecats,
        'welayat': dropdownValuewelayat,
        'optionscat': dynamicText,
        'optionswel': dynamicTextwel,
        'title': controller.text,
        'artikul':hid,
      }),
    );


    showAlertDialog(context);

  }



  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(

      onPressed: () {

        Navigator.pushNamed(context, '/');

      },
        child: Text("OK",style: TextStyle(color: Colors.deepOrange),),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Siziň harydyňyz goşyldy"),
      content: Text("Sagbolyň!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }






}





class WelayatArguments {
  final String title;



  WelayatArguments(this.title);
}







class sendimg{




  void send(String title,controller,String hid) async{

    String id="0";

    final http.Response response = await http.post(
      Uri.parse('https://sanlysahypa.com/index.php/urunler/getimage'),
      body: jsonEncode(<String, String>{
        'name': "aaa",
        'title': title,
        'parent':hid,
      }),
    );

    id=response.body;
    print(id);

  }

}