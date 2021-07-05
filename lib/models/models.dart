import 'dart:ffi';

import 'package:form_generator/main.dart';

class Question {
  int id;
  int id_form;
  String question;
  String typevariable;
  String typequestion;
  Question({this.id, this.id_form, this.question, this.typevariable, this.typequestion});

  Question.fromMap(Map<String, dynamic> map)
    :id = map['id'],
    id_form = map['id_form'],
    question = map['question'],
    typevariable = map['typevariable'],
    typequestion = map['typequestion'];

  Map<String, dynamic>toMap(){
    return {
      'id': id,
       'id_form': id_form,
       'question': question,
      'typevariable': typevariable,
      'typequestion': typequestion,
    };
  }



  @override
  String toString() {
    return 'Question{id: $id, question: $question, typevariable: $typevariable, typequestion: $typequestion}';
  }
}

class Reponse {
  int id;
  int id_question;
  String valeur;
  double longitude;
  double latitude;

  Reponse({this.id, this.id_question, this.valeur, this.latitude, this.longitude});

  Map<String, dynamic>toMap(){
    return {
      'id':id,
      'id_question': id_question,
      'valeur': valeur,
      'longitude': longitude,
      'latitude': latitude
    };
  }

  @override
  String toString() {
    return 'Reponse{id: $id, id_question: $id_question, valeur: $valeur, longitude: $longitude, latitude: $latitude}';
  }
}


class Option {
  int id;
  int id_question;
  String valeur;

  Option({this.id, this.id_question, this.valeur});

  Map<String, dynamic>toMap(){
    return {
      'id':id,
       'id_question': id_question,
      'valeur': valeur
    };
  }

  @override
  String toString() {
    return 'Option{id: $id, id_question: $id_question, valeur: $valeur}';
  }
}


class Titres {
  int id;
  String titre;

  Titres({this.id, this.titre});

  Map<String, dynamic>toMap(){
    return {
      'id':id,
      'titre': titre
    };
  }

  @override
  String toString() {
    return 'Option{id: $id, titre: $titre}';
  }
}

class Formulaire {
  String label;
  List<Question> questions;
  Formulaire({this.label, this.questions});
}