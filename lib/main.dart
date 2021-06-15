import 'package:flutter/material.dart';
import 'package:form_generator/titre.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Smartsurvey'),
        backgroundColor: Colors.green,

        centerTitle: true,

      ),
      body:
      Center(

        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/smartsurvey.jpg'),
            SizedBox(height: 50,),
            RaisedButton(

              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Titre()
                ));
              },
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Text("Nouveau Questionnaire",
                style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 30,),
            RaisedButton(
              onPressed: (){},
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Text("Afficher Questionnaire",
                style: TextStyle(color: Colors.white),),
            ),
          ],
        ),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}