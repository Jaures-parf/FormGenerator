import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_generator/bd.dart';
import 'package:form_generator/home.dart';
import 'package:form_generator/models/models.dart';

class Titre extends StatefulWidget {

  Formulaire formulaire;
  @override
  _TitreState createState() => _TitreState();
}

class _TitreState extends State<Titre> {

  final titrecontroller = TextEditingController();
  DB db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = new DB();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(' Smartsurvey'),

          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(8),

          child: Card(
            child: Form(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      leading: new Container(),
                      backgroundColor: Colors.green,
                      title: Text('Titre du formulaire'),
                      centerTitle: true,
                      actions: <Widget>[
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titrecontroller,
                        onSaved: (val) => widget.formulaire.label = val,
                        validator: (val) =>
                        val.length > 5 ? null : ' Titre invalide',
                        decoration: InputDecoration(
                          //  labelText: 'Titre du formulaire',
                          hintText: 'Entrer le titre du formulaire',
                        ),
                      ),




                    ),
                    SizedBox(height: 50,),
                    RaisedButton(
                      onPressed: () async {
                        int id = await db.insertForm(new Titres(
                          titre: titrecontroller.text
                        ));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(id: id)
                        ));

                      },
                      color: Colors.green,
                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Text("Suivant",
                        style: TextStyle(color: Colors.white),),
                    ),
                  ],
                )
            ),),)
    );
  }
}
