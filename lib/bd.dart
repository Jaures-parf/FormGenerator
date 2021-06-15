import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/models.dart';

class DB {

static Database _database;

  Future<Database> get database async{
    if (_database != null) return _database;
    _database =await initDB();
    return _database;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'form_generator.db'),
      onCreate: (db,version){
        db.execute('CREATE TABLE question(id INTEGER PRIMARY KEY, id_form INTEGER, question TEXT, typevariable TEXT, typequestion TEXT)');
        db.execute('CREATE TABLE option(id INTEGER PRIMARY KEY, id_question INTEGER, valeur TEXT)');
        db.execute('CREATE TABLE questionnaire(id INTEGER PRIMARY KEY, id_question INTEGER)');
        db.execute('CREATE TABLE reponse(id INTEGER PRIMARY KEY, id_question INTEGER, valeur TEXT, longitude TEXT, latitude TEXT)');
        db.execute('CREATE TABLE form(id INTEGER PRIMARY KEY, titre INTEGER, valeur TEXT)');
        return 1;
      },
      version: 1,
    );
  }

  insertQuestion(Question question) async {
    final Database db = await database;

    return await db.insert('question',
    question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //insertReponse()

  insertOption(Option option) async {
    final Database db = await database;

    return await db.insert('option',
    option.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insertForm(Titres titre) async {
    final Database db = await database;

    return await db.insert('form',
      titre.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Question>> getAllQuestions() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('question');

    // Convert the List<Map<String, dynamic> into a List<Question>.
    return List.generate(maps.length, (i) {
      return Question(
        id: maps[i]['id'],
        id_form: maps[i]['id_form'],
        question: maps[i]['question'],
        typevariable: maps[i]['typevariable'],
        typequestion: maps[i]['typequestion'],
      );
    });
  }

Future<List<Option>> getAllOptions(int id_question) async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('option', where: "id_question = ?", whereArgs: [id_question]);

  // Convert the List<Map<String, dynamic> into a List<Question>.
  return List.generate(maps.length, (i) {
    return Option(
      id: maps[i]['id'],
      id_question: maps[i]['id_question'],
      valeur: maps[i]['valeur'],
    );
  });
}

Future<List<Titres>> getAllTitles() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('form');

  // Convert the List<Map<String, dynamic> into a List<Question>.
  return List.generate(maps.length, (i) {
    return Titres(
      id: maps[i]['id'],
      titre: maps[i]['titre']
    );
  });
}

  updateQuestion(Question question) async {
    // Get a reference to the database.
    final db = await database;
    // Update the given Dog.
    return await db.update(
      'question',
      question.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [question.id],
    );
  }

  Future<Question> getQuestionById(int id) async {
    final db = await database;
    var result = await db.query('question', where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty? Question.fromMap(result.first):null;
  }

}
