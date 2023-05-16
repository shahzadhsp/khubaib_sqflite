import 'package:flutter/material.dart';
import 'package:khubaib_sqflite/db_handler.dart';
import 'package:khubaib_sqflite/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();

  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();

  DbHelper dbHelper = DbHelper();
  NotesModel? notesModel;
  List<NotesModel> notesModellist = [];

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqlite Demo'),
      ),
      body: Form(
          key: _formkey,
          child: Column(

            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Enter title'),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Enter email'),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(hintText: 'Enter age'),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Enter description'),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  //  Navigator.pop(context);
                  _submittedButton(context);
                },
                child: Text('Submitted'),
              ),
              FutureBuilder(
        future: dbHelper.getNotesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: notesModellist.length,
              itemBuilder: (context, index) {
                NotesModel st = notesModellist[index];
                return Card(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text(
                        'Name ${st.title}',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Name ${st.age}',
                          style: TextStyle(color: Colors.red)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Name ${st.email}',
                          style: TextStyle(color: Colors.red)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Name ${st.email}',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
            ],
          )),
    );
  }

  void _submittedButton(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      if (notesModel == null) {
        NotesModel notesModel = NotesModel(
            title: _titleController.text,
            email: _emailController.text,
            age:int.parse(_ageController.text),
            description: _descriptionController.text);
        dbHelper.insert(notesModel).then(
          (id) {
            // _titleController.clear();
            // _ageController.clear();
            // _emailController.clear();
            // _descriptionController.clear();
            print('Submitted form successfuly ${id}');
            print('Age :${_ageController.text}');
            print('Email: ${_emailController.text}');
            print(" Description : ${_descriptionController.text}");
            print(' Titl :${_titleController.text}');

          },
        );
      }
    }
  }
}
