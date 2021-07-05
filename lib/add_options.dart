import 'package:flutter/material.dart';
import 'package:form_generator/add_form.dart';
import 'package:form_generator/bd.dart';
import 'package:form_generator/models/models.dart';

class AddOption extends StatefulWidget {

  AddOption({this.id});
  final int id;

  @override
  _AddOptionState createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  GlobalKey<FormState> _form = new GlobalKey<FormState>();
  String option;
  DB db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = new DB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Intitulé de l\'option'
                  ),
                  validator: (option){
                    if(option.isEmpty)
                      return 'Champ obligatoire';
                    else{
                      this.option = option;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20,),

                InkWell(

                  onTap: () async {
                    if(_form.currentState.validate()){
                      print ("#################");
                      print (widget.id);
                     await db.insertOption(new Option(
                        id_question: widget.id,
                        valeur: this.option,
                      ));
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> AddForm(id: widget.id,)));

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
      ),
    );
  }

  TextStyle tStyle(Color color) {
    return TextStyle(
        color: color
    );
  }
}
