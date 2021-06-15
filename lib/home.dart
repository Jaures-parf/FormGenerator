import 'package:flutter/material.dart';
import 'package:form_generator/add_form.dart';
import 'package:form_generator/bd.dart';
import 'package:form_generator/models/models.dart';

import 'gps.dart';

class MyHomePage extends StatefulWidget {
  final int id;
  MyHomePage({Key key, @required this.id}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController titreFormController, questionController;
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isthere = false;
  List<List<Option>> _mesOptions = [];
  List<String> option = [];
  List<Question> _questions = [];
  List<Titres> _titres = [];
  DB db;
  List<Option> _options = [];



  getOptions() async {
    _options = await db.getAllOptions(widget.id);
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("L'id retrieve: ${widget.id}");
    db = new DB();
    titreFormController = new TextEditingController();
    questionController = new TextEditingController();
    getAllTitles();
    getQuestions();
    getOptions();

  }



  getQuestions() async {
    List<Option> _options = [];
    _questions = await db.getAllQuestions();
    for(int i=0; i<_questions.length; i++){
      _options = await db.getAllOptions(_questions[i].id);
      print(_questions[i].toString());
      print(_options[i].toString());
      option.add(null);
      _mesOptions.insert(i, _options);
      print (_mesOptions[i].toString());
    }
    setState(() {});
  }

  getAllTitles() async {
    _titres = await db.getAllTitles();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(

        backgroundColor: Colors.green,
        title: Text('Smartsurvey', style: tStyle(),),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text('Map'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyLocation()));
            },

          ),
          Center(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                    onTap: (){
                      if(_form.currentState.validate()){
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => BaseDonnee(title:widget.title, question: widget.questionnaires, questionnaires: widget.questionnaires,)));
                      }
                    },
                    child: Text("Valider", style: tStyle(),)),
              ))
        ],
      ),
      body:SingleChildScrollView(

        child:  Form(
          key: _form,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text(_titres!= null && _titres != []?"${_titres[_titres.length - 1].titre}": ' ',  style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30.0, letterSpacing: 0.6, decoration: TextDecoration.underline, ),textAlign: TextAlign.center),
              SizedBox(height: 30,),
              _questions != null && _questions != []?Container(
                height: MediaQuery.of(context).size.height -  100,

                child: ListView.builder(
                    itemCount: _questions.length,
                    itemBuilder: (_, index){
                      //getOptions(_questions[index].id, index);
                      print(_questions);

                      return _questions[index].question != null? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${_questions[index].question}", style: TextStyle(fontSize: 16.0,)),
                            getTypeChamp(_questions[index].typequestion, index),
                          ],
                        ),
                      ):Container();
                    }
                ),
              ):Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text("Ajouter une nouvelle question", style: TextStyle(
                      color: Colors.black
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddForm(id: widget.id)));
        },
        tooltip: 'nouveau',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  TextStyle tStyle(){
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15
    );
  }

  Widget getTypeChamp(String type, int index){
    Widget _widget;
    switch(type){
      case 'Zone de texte':
        _widget = Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                  color: Colors.grey.withOpacity(.3),
                  width: 1
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Réponse'
              ),
            ),
          ),
        );
        break;
      case 'Liste déroulante':
        _widget = Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                  color: Colors.grey.withOpacity(.3),
                  width: 1
              )
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                underline: Container(),
                icon: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: new Icon(Icons.arrow_drop_down_circle),
                ),
                isDense: false,
                elevation: 1,
                isExpanded: true,
                onChanged: (String selected){
                  setState(() {
                    option.insert(index, selected);
                  });
                },
                value: option.elementAt(index),
                hint: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text('Type de champ',
                    style: dStyle(Colors.grey),),
                ),
                items:_mesOptions[index].map((Option option){
                  return DropdownMenuItem<String>(
                    value: option.valeur,
                    child: Padding(
                      padding:EdgeInsets.only(left: 15),
                      child: Text(option.valeur,
                        style: dStyle(Colors.black),),
                    ),
                  );
                }).toList(),
              )
          ),
        );
        break;
      case 'Case à cocher':
        _widget = Column(
          children: _mesOptions[index].map((e) =>
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Colors.grey.withOpacity(.3),
                          width: 1
                      )
                  ),

                  child: RadioListTile<String>(
                    title: Text("${e.valeur}"),
                    activeColor: Colors.green,
                    value: e.valeur,
                    groupValue: option.elementAt(index),
                    onChanged: (value) {
                      setState(() {
                        option.insert(index,value);
                        print("voici e  $e");
                      });
                    },
                  ),
                ),)
          ).toList(),
        );
        break;
      case 'Choix multiple':
      //_widget = ;
        break;
    }
    return _widget;
  }

  TextStyle dStyle(Color color) {
    return TextStyle(
        color: color
    );
  }
}
