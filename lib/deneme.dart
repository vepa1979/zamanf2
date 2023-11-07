import 'dart:async';
import 'dart:convert';

//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:localstorage/localstorage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:change_app_package_name/change_app_package_name.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:tapsana/CalendarScreen.dart';
import 'package:tapsana/search.dart';

import 'firebase_options.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'dart:io';
import 'imagePicker.dart';
import 'package:tapsana/ParentScreen.dart';
import 'package:tapsana/ChildScreen.dart';
import "package:tapsana/OptionsScreen.dart";
import 'WelayatScreen.dart';

import 'CalendarScreen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tapsana/DetailScreen.dart';

import 'package:dio/dio.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  //print('Handling a background message ${message.notification?.title}');

  showSimpleNotification(
    InkWell(
      onTap: (){

        navService.pushNamed('/single',

          args:  ScreenArguments(
            '${message.notification?.title}',
            'Habarlar',
            '${message.notification?.body}',
          ),

        );

      },
      child:
      Padding(
        padding: EdgeInsets.symmetric(horizontal:10.0),
        child:
        Text('${message.notification?.title}',style: TextStyle(color:Colors.black)),



      ),

    ),
    subtitle:
    Text('',style: TextStyle(color:Colors.black)),
    leading:
    Image.asset(
      'assets/images/zamanlogo.jpg',
      fit: BoxFit.contain,
      height:26,

    ),




    background: Colors.white,
    duration: Duration(seconds: 5),
  );

}



List<String> listcats = <String>[];



List<String> listcategorychild = <String>[];

//List<String> listchild = <String>[];

String listchild="";

final List<String> listselected= <String>[];









List<String> welayat = <String>["Aşgabat","Ahal","Balkan","Mary","Lebap","Daşoguz"];

String dynamicText="";
String dynamicTextwel="";

String hinttext="Gözleg";

String hinttextbolumler="Bölümler";



int selectedcategoryid=0;


LocalStorage storage = new LocalStorage('localstorage_app');





List posts = [];







void main() async{

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  storage.setItem('lang', 'tm');



  HttpOverrides.global = MyHttpOverrides();






  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      showSimpleNotification(
        InkWell(
          onTap: (){

            navService.pushNamed('/single',

              args:  ScreenArguments(
                '${message.notification?.title}',
                'Habarlar',
                '${message.notification?.body}',
              ),

            );

          },
          child:
          Padding(
            padding: EdgeInsets.symmetric(horizontal:10.0),
            child:
            Text('${message.notification?.title}',style: TextStyle(color:Colors.black)),



          ),

        ),
        subtitle:
        Text('',style: TextStyle(color:Colors.black)),
        leading:
        Image.asset(
          'assets/images/zamanlogo.jpg',
          fit: BoxFit.contain,
          height:26,

        ),




        background: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
  });
  var token = await FirebaseMessaging.instance.getToken();
  settoken(token);









  runApp(MyApp());


}



settoken(token) async {
  List posts = [];


  try {
    // This is an open REST API endpoint for testing purposes
    String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/tokens/newtoken?Tokens='+token;

    final http.Response response = await http.get(Uri.parse(apiUrl));
    //posts = json.decode(response.body);

    print(response.body);





  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
  }

  return posts;
}

















class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xfffafafa, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffce5641 ),//10%
      100: const Color(0xffb74c3a),//20%
      200: const Color(0xffa04332),//30%
      300: const Color(0xff89392b),//40%
      400: const Color(0xff733024),//50%
      500: const Color(0xff5c261d),//60%
      600: const Color(0xff451c16),//70%
      700: const Color(0xff2e130e),//80%
      800: const Color(0xff170907),//90%
      900: const Color(0xff000000),//100%
    },
  );
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});



  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(

        navigatorKey: NavigationService.navigationKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case '/single':
              return MaterialPageRoute(builder: (_) => DetailScreen());
            default:
              return null;
          }
        },

        title: 'Zaman Türkmenistan',
        theme: ThemeData(
          // Define the default brightness and colors.
          // brightness: Brightness.light,
          primaryColor: Colors.black,
          primarySwatch: Palette.kToDark,

          // Define the default font family.
          fontFamily: 'Arial',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Arial'),
          ),
        ),
        routes: {
          '/home': (context) => HomeScreen(),
          '/details': (context) => MultipleImageSelector(),
          '/single': (context) => DetailScreen(),
          '/category': (context) => CategoryScreen(),
          '/search': (context) => SearchScreen(),
          '/parent': (context) => ParentScreen(),
          '/options': (context) => OptionsScreen(),
          '/mostview': (context) => MostviewScreen(),
          '/arhiw': (context) => CalendarScreen(),
          '/arhiwhabarlar': (context) => ChildScreen(),
          '/contact': (context) => ParentScreen(),
        },

        home: const MyHomePage(title: 'Zaman Türkmenistan gazeti'),


      ),
    );
  }




}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String sel_lang="tm";

  String lang="tm";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(

              child:
              ClipOval(
                child:
                Image.asset(
                  'assets/images/zamanlogo.jpg',
                  // fit: BoxFit.fitWidth,
                  scale:0.1,
                  width: 200,

                ),


              ),

            ),
            Padding(padding: EdgeInsets.all(10),
              child:
              const Text(
                'Siz haýsy dilde habarlary okamak isleýäňiz',
              ),

            )
            ,
            Column(
              children: [

                Container(
                  width:70,
                  child:
                  Column(
                    children: [
                      Row(

                        mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                        children: [


                          Padding(
                            padding: EdgeInsets.only(top:15),
                            child:

                            InkWell(
                              onTap: () {
                                storage.setItem('lang', 'tm');

                                sel_lang=storage.getItem('lang');

                                hinttext="Gözleg";
                                hinttextbolumler="Bölümler";

                                Navigator.pushNamed(
                                  context,
                                  "/home",
                                );


                              }, // Image tapped
                              splashColor: Colors.white10, // Splash color over image
                              child: Ink.image(
                                fit: BoxFit.cover, // Fixes border issues
                                width: 24,
                                height: 16,
                                image: AssetImage(
                                  'assets/images/tm.jpg',
                                ),


                              ),
                            ),

                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top:15),
                            child:

                            InkWell(
                              onTap: () {

                                storage.setItem('lang', 'ru');
                                sel_lang=storage.getItem('lang');

                                hinttext="Поиск";
                                hinttextbolumler="Категории";

                                Navigator.pushNamed(
                                  context,
                                  "/home",
                                );




                              }, // Image tapped
                              splashColor: Colors.white10, // Splash color over image
                              child: Ink.image(
                                fit: BoxFit.cover, // Fixes border issues
                                width: 24,
                                height: 16,
                                image: AssetImage(
                                  'assets/images/ru.jpg',
                                ),


                              ),
                            ),

                          ),



                        ],


                      ),


                    ],

                  )
                  ,

                )



              ],

            )

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


























class HomeScreen extends StatelessWidget {


  int _selectedIndex=0;




  String sel_lang="tm";

  String lang="tm";


  List<String> listfour = <String>[];
  List<String> listfourady = <String>[];
  List<String> listfouraciklama = <String>[];
  List<String> listfourid = <String>[];








  void grid() async{

    await storage.ready;
    String lang = await storage.getItem('lang');

    List posts = [];




    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://www.zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/topcategoriesf?lang='+lang;

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);

      for(int t=0;t<posts.length;t++) {
        listfour.add(posts[t]["suraty"]);
        listfourady.add(posts[t]["ady"]);
        listfourid.add(posts[t]["id"]);

        //print(posts[t]["suraty"]);
      }

    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }


  }






  Future<List> _loadDatabanners() async {

    //String lang="tm";

    await storage.ready;
    String lang = await storage.getItem('lang');



    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://www.zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/topcategoriesf?lang='+lang;

      final http.Response response = await http.get(Uri.parse(apiUrl),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer Setupvpn20223!',
      });



      posts = json.decode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }





  Future<List> _loadData() async {
    List posts = [];

    var token = "Setupvpn2022!";

    await storage.ready;
    String lang = await storage.getItem('lang');

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);


    try {
      // This is an open REST API endpoint for testing purposes








      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/getjsonhometabsf?lang='+lang+'&cat=Iň täze habarlar';

      final http.Response response = await http.get(Uri.parse(apiUrl),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer Setupvpn2022!',
      });
      posts = json.decode(response.body);




    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }



  Future<List> _loadDatacats() async {


    await storage.ready;
    String lang = await storage.getItem('lang')??"tm";





    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/buttons/buttonsf?lang='+lang??"tm";

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);


    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }








  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leadingWidth:250,
          leading:
          Padding(
            padding: EdgeInsets.all(0),
            child: Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.contain,
              height: 80,

            ),






          ),




          title:Container(
            child:
            Row(
              children: [

                Flexible(
                  // padding: EdgeInsets.all(4),
                  child:

                  InkWell(
                    onTap: () {





                      storage.setItem('lang', 'tm');

                      sel_lang=storage.getItem('lang');

                      hinttext="Gözleg";
                      hinttextbolumler="Bölümler";

                      Navigator.pushNamed(
                        context,
                        "/",
                      );


                    }, // Image tapped
                    splashColor: Colors.white10, // Splash color over image
                    child: Ink.image(
                      fit: BoxFit.cover, // Fixes border issues
                      width: 24,
                      height: 16,
                      image: AssetImage(
                        'assets/images/tm.jpg',
                      ),


                    ),
                  ),

                ),
                Spacer(),
                Flexible(
                  // padding: EdgeInsets.all(4),
                  child:

                  InkWell(
                    onTap: () {

                      storage.setItem('lang', 'ru');
                      sel_lang=storage.getItem('lang');

                      hinttext="Поиск";
                      hinttextbolumler="Категории";

                      Navigator.pushNamed(
                        context,
                        "/",
                      );




                    }, // Image tapped
                    splashColor: Colors.white10, // Splash color over image
                    child: Ink.image(
                      fit: BoxFit.cover, // Fixes border issues
                      width: 24,
                      height: 16,
                      image: AssetImage(
                        'assets/images/ru.jpg',
                      ),


                    ),
                  ),

                ),



              ],


            ),
          )









      ),

      // implement FutureBuilder
      body:








      Container(
        child:


        Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.all(16),
              child:
              TextField(
                autofocus: false,

                  onSubmitted: (value){

                    Navigator.pushNamed(
                      context,
                      "/search",
                      arguments: SeacrhArguments(
                      value
                      ),
                    );




                    // or do whatever you want when you are done editing
                    // call your method/print values etc
                  },


                decoration: InputDecoration(
                    hintText: hinttext,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),

                    suffixIcon: IconButton(icon:Icon(Icons.search), onPressed: () {
                    },)
                ),
                style: TextStyle(color: Colors.black, fontSize: 16.0,height:0.6),
              ),


            ),



            Container(
              height: 144,
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    // color: Colors.blue,
                    // height: 100,
                    // width: 100,
                    child:
                    FutureBuilder(
                        future: _loadDatabanners(),
                        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                          // render the list
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, index) => Card(
                              margin: const EdgeInsets.all(0),

                              // render list item

                              child:



                              Container(

                                  width: 120,
                                  child:

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      InkWell(
                                        onTap: (){





                                          Navigator.pushNamed(
                                            context,
                                            "/single",
                                            arguments: ScreenArguments(
                                              snapshot.data![index]['ady'],
                                              snapshot.data![index]['bolum'],
                                              snapshot.data![index]['id'],
                                            ),
                                          );


                                        },

                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 48, // Image radius
                                              backgroundImage: NetworkImage(snapshot.data![index]['suraty']),
                                            )

                                            ,
                                            Padding(

                                              padding:EdgeInsets.all(4),
                                              child:

                                              Text(
                                                snapshot.data![index]['bolum'],
                                                textAlign: TextAlign.center, // no impact
                                                style: TextStyle(color: Colors.blue,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                              ),

                                            )
                                            ,


                                          ],


                                        ),


                                      ),






                                    ],


                                  )

                              )








                          ),
                        )
                            : const Center(
                          // render the loading indicator
                          child: CircularProgressIndicator(),
                        )),
                  ),

                ],


              ),
            ),



            Expanded(
              flex:2,
              // color: Colors.blue,
              // height: 100,
              // width: 100,
              child:
              FutureBuilder(
                future: _loadData(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  // render the list

                  itemCount:3,
                  itemBuilder: (BuildContext context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    // render list item

                    child:

                    Column(

                      children: [

                        Row(

                          children: [




                            ClipRRect(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(50), // Image radius
                                child: Image.network(snapshot.data![index]['suraty'], fit: BoxFit.cover),
                              ),
                            ),


                            // Image.network(snapshot.data![index]['suraty'],width: 100,),

                            Expanded(
                              flex: 1,
                              child:
                              InkWell(

                                child:
                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.all(12),

                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Padding(padding: EdgeInsets.all(4),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  Text(snapshot.data![index]['wagty'],style:TextStyle(color:Colors.blue) ,),

                                                ],

                                              ),

                                            ),

                                            Padding(padding: EdgeInsets.all(4),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [


                                                  Text(snapshot.data![index]['ady']),


                                                ],

                                              ),

                                            ),

                                            Padding(padding: EdgeInsets.all(4),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index]['bolum'],style:TextStyle(color:Colors.grey) ,),

                                                ],

                                              ),

                                            )






                                          ],

                                        )



                                    )

                                  ],

                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/single",
                                    arguments: ScreenArguments(
                                      snapshot.data![index]['ady'],
                                      snapshot.data![index]['bolum'],
                                      snapshot.data![index]['id'],
                                    ),
                                  );
                                },

                              ),









                            )


                          ],


                        )

                      ],

                    ),






                  ),
                )
                    : const Center(


                  // render the loading indicator
                    child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))



                ),



              ),
            ),



            Container(
              height: 144,
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    // color: Colors.blue,
                    // height: 100,
                    // width: 100,
                    child:
                    FutureBuilder(
                        future: _loadDatabanners(),
                        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                          // render the list
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, index) => Card(
                              margin: const EdgeInsets.all(0),

                              // render list item

                              child:



                              Container(

                                  width: 120,
                                  child:

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      InkWell(
                                        onTap: (){





                                          Navigator.pushNamed(
                                            context,
                                            "/single",
                                            arguments: ScreenArguments(
                                              snapshot.data![index]['ady'],
                                              snapshot.data![index]['bolum'],
                                              snapshot.data![index]['id'],
                                            ),
                                          );


                                        },

                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 48, // Image radius
                                              backgroundImage: NetworkImage(snapshot.data![index]['suraty']),
                                            )

                                            ,
                                            Padding(

                                              padding:EdgeInsets.all(4),
                                              child:

                                              Text(
                                                snapshot.data![index]['bolum'],
                                                textAlign: TextAlign.center, // no impact
                                                style: TextStyle(color: Colors.blue,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                              ),

                                            )
                                            ,


                                          ],


                                        ),


                                      ),






                                    ],


                                  )

                              )








                          ),
                        )
                            : const Center(
                          // render the loading indicator
                          child: CircularProgressIndicator(),
                        )),
                  ),

                ],


              ),
            ),


            Expanded(
              flex:2,
              // color: Colors.blue,
              // height: 100,
              // width: 100,
              child:
              FutureBuilder(
                future: _loadData(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  // render the list

                  itemCount:3,
                  itemBuilder: (BuildContext context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    // render list item

                    child:

                    Column(

                      children: [

                        Row(

                          children: [




                            ClipRRect(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(50), // Image radius
                                child: Image.network(snapshot.data![index]['suraty'], fit: BoxFit.cover),
                              ),
                            ),


                            // Image.network(snapshot.data![index]['suraty'],width: 100,),

                            Expanded(
                              flex: 1,
                              child:
                              InkWell(

                                child:
                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.all(12),

                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Padding(padding: EdgeInsets.all(4),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  Text(snapshot.data![index]['wagty'],style:TextStyle(color:Colors.blue) ,),

                                                ],

                                              ),

                                            ),

                                            Padding(padding: EdgeInsets.all(4),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [


                                                  Text(snapshot.data![index]['ady']),


                                                ],

                                              ),

                                            ),

                                            Padding(padding: EdgeInsets.all(4),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index]['bolum'],style:TextStyle(color:Colors.grey) ,),

                                                ],

                                              ),

                                            )






                                          ],

                                        )



                                    )

                                  ],

                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/single",
                                    arguments: ScreenArguments(
                                      snapshot.data![index]['ady'],
                                      snapshot.data![index]['bolum'],
                                      snapshot.data![index]['id'],
                                    ),
                                  );
                                },

                              ),









                            )


                          ],


                        )

                      ],

                    ),






                  ),
                )
                    : const Center(


                  // render the loading indicator
                    child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))



                ),



              ),
            ),






          ],
        ),
      ),

      endDrawer: Drawer(
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
          child:
          Container(

            padding: EdgeInsets.only(left:0,top:0),
            child:



            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,

              children: [


                Center(

                  child:
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                      //color: AppColor.appColor,
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: new DecorationImage(
                                image: Image.asset('assets/images/zamanlogo.jpg').image,
                                fit: BoxFit.contain,
                              ))),
                    ),
                  ),




                ),



                Padding(padding: EdgeInsets.only(left:16,top:16),

                  child:
                  Text("Bölümler"),

                ),


                Expanded(

                  child:









                  FutureBuilder(


                      future: _loadDatacats(),
                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ?
                      ListView.separated(
                        itemCount: snapshot.data!.length,
                        padding:EdgeInsets.all(0),
                        separatorBuilder: (_, __) => Container(height: 1, color: Colors.grey[300]),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title:
                            Container(
                              // padding: const EdgeInsets.all(0),

                              // render list item

                                child:



                                Stack(
                                  children: [



                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child:

                                      TextButton(onPressed: (){

                                        Navigator.pushNamed(
                                          context,
                                          "/category",
                                          arguments: CategoryArguments(
                                            snapshot.data![index]['ady'],
                                          ),
                                        );

                                      },
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [



                                            Icon(Icons.circle_outlined,
                                              size: 20.0,
                                              color: Colors.grey,
                                            ),
                                            Expanded(

                                              //padding: EdgeInsets.only(left:16),

                                              child:

                                              Text(
                                                " "+snapshot.data![index]['ady'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.grey,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                              ),



                                            )



                                          ],
                                        )

                                        ,




                                      ),





                                    )
                                  ],


                                )




                            ),



                          );
                        },
                      )





                          : const Center(
                        // render the loading indicator
                        child: CircularProgressIndicator(),
                      )),


                )





              ],
            ),



          )






      ),


      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(child: IconButton(icon: Icon(Icons.show_chart), onPressed: () {
              //mostview
              Navigator.pushNamed(
                context,
                "/mostview",

              );



            },),),
            //  Expanded(child: new Text('')),
            Expanded(child: IconButton(icon: Icon(Icons.calendar_today), onPressed: () {
              Navigator.pushNamed(
                context,
                "/arhiw",

              );


            },),),
            Expanded(child: IconButton(icon: Icon(Icons.contacts_sharp), onPressed: () {



              Navigator.pushNamed(
                context,
                "/contact",

              );




            },),),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,





    );

  }



  void showModal(BuildContext context) {

    Navigator.pushNamed(context, '/details');



  }




}












class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}















class CategoryScreen extends StatelessWidget {



  Future<List> _loadDatabycat(bolum) async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/getanabolumcatjf?bolum='+bolum;

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

    final args = ModalRoute.of(context)!.settings.arguments as CategoryArguments;



    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title:Text(args.title),
        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body: Container(
        child:


        Padding(
            padding: EdgeInsets.all(0),
            child:


            FutureBuilder(
              future: _loadDatabycat(args.title),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                // render the list

                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Card(
                  margin: const EdgeInsets.all(10),
                  // render list item

                  child:

                  Column(

                    children: [

                      Row(

                        children: [




                          ClipRRect(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(50), // Image radius
                              child: Image.network(snapshot.data![index]['suraty'], fit: BoxFit.cover),
                            ),
                          ),


                          // Image.network(snapshot.data![index]['suraty'],width: 100,),

                          Expanded(
                            flex: 1,
                            child:
                            InkWell(

                              child:
                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.all(12),

                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index]['ady']),
                                          Text(snapshot.data![index]['bolum']),

                                        ],

                                      )



                                  )

                                ],

                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/single",
                                  arguments: ScreenArguments(
                                    snapshot.data![index]['ady'],
                                    snapshot.data![index]['bolum'],
                                    snapshot.data![index]['id'],
                                  ),
                                );
                              },

                            ),









                          )


                        ],


                      )

                    ],

                  ),








                ),
              )
                  : const Center(
                // render the loading indicator
                  child: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))),
            )),






      ),


    );






  }
}







class ScreenArguments {



  final String title;
  final String bolum;
  final String  idsi;

  ScreenArguments(this.title,this.bolum, this.idsi);
}


class CategoryArguments {
  final String title;


  CategoryArguments(this.title);
}


class ParentArguments {
  final String title;


  ParentArguments(this.title);
}























