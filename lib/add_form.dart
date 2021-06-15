import 'package:flutter/material.dart';
import 'package:form_generator/add_options.dart';
import 'package:form_generator/bd.dart';
import 'package:form_generator/home.dart';
import 'package:form_generator/models/models.dart';


class AddForm extends StatefulWidget {
  final int id;
  AddForm({@required this.id});

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  String titre, type_var, type_champ, option;
  bool _isOptions = false;
  //List<String> _options = [];
  var _type_vars = ['Nombre', 'Chaine de caractère', 'Date'];
  var _type_champ = ['Zone de texte', 'Liste déroulante', 'Case à cocher', 'Choix multiple'];
  DB db;
  List<Option> _options = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = new DB();
    getOptions();
  }

  getOptions() async {
    _options = await db.getAllOptions(widget.id);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isOptions == true?Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Text("Ajouter les options"),
                    IconButton(
                        icon: Icon(Icons.add, color: Colors.blue,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddOption(id: widget.id,)));
                        }
                    ),
                  ],
                ),
              ):Container(),

              TextFormField(
                //controller: widget.question == null?null: TextEditingController(text: widget.question.titre),
                decoration: InputDecoration(
                    hintText: 'Intitulé de la question'
                ),
                validator: (titre){
                  if(titre.isEmpty)
                    return 'Champ obligatoire';
                  else
                    this.titre = titre;
                  return null;
                },
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.arrow_drop_down_circle),
                    ),
                    isDense: false,
                    elevation: 1,
                    isExpanded: true,
                    onChanged: (String selected){
                      setState(() {
                        type_var = selected;
                      });
                    },
                    value: type_var,
                    hint: Text('Type de la variable',
                      style: tStyle(Colors.grey),),
                    items: _type_vars.map((String name){
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name,
                          style: tStyle(Colors.black),),
                      );
                    }).toList(),
                  )
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.arrow_drop_down_circle),
                    ),
                    isDense: false,
                    elevation: 1,
                    isExpanded: true,
                    onChanged: (String selected){
                      setState(() {
                        type_champ = selected;
                        if(type_champ == 'Zone de texte' || type_champ == null){
                          _isOptions = false;
                        }else {
                          _isOptions = true;
                        }
                      });
                    },
                    value: type_champ,
                    hint: Text('Type de champ',
                      style: tStyle(Colors.grey),),
                    items: _type_champ.map((String name){
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name,
                          style: tStyle(Colors.black),),
                      );
                    }).toList(),
                  )
              ),
              _options != []?DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: new Icon(Icons.arrow_drop_down_circle),
                    ),
                    isDense: false,
                    elevation: 1,
                    isExpanded: true,
                    onChanged: (String selected){
                      setState(() {
                        option = selected;
                      });
                    },
                    value: option,
                    hint: Text('Options',
                      style: tStyle(Colors.grey),),
                    items: _options.map((Option option){
                      return DropdownMenuItem<String>(
                        value: option.valeur,
                        child: Text(option.valeur,
                          style: tStyle(Colors.black),),
                      );
                    }).toList(),
                  )
              ):Container(),

              InkWell(

                onTap: () async {
                  if(_form.currentState.validate()) {
                    Question question = new Question(
                        id_form: widget.id,
                        question: titre,
                        typequestion: type_champ,
                        typevariable: type_var,
                    );
                    db.insertQuestion(question);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MyHomePage(id: widget.id)));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(child: Text("Valider", style: tStyle(Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle tStyle(Color color) {
    return TextStyle(
        color: color
    );
  }
}