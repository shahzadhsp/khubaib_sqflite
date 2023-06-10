import 'package:flutter/material.dart';

import 'package:khubaib_sqflite/db_handler.dart';
import 'package:khubaib_sqflite/form_screen.dart';
import 'package:khubaib_sqflite/notes_model.dart';

class ShowDataGpt extends StatefulWidget {
  const ShowDataGpt({Key? key}) : super(key: key);

  @override
  _ShowDataGptState createState() => _ShowDataGptState();
}

class _ShowDataGptState extends State<ShowDataGpt> {
  DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('Click');
          var value = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(),
            ),
          );
          setState(() {
            if (value != null &&
                value.title != "" &&
                value.email != "" &&
                value.age != "" &&
                value.description != "") {
              NotesModel notesModel = NotesModel(
                title: value.title,
                email: value.email,
                age: int.parse(value.age),
                description: value.description,
              );
              dbHelper.insert(notesModel);
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: dbHelper.getNotesList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<NotesModel> notesModellist = snapshot.data as List<NotesModel>;

            if (notesModellist.isNotEmpty) {
              return ListView.builder(
                itemCount: notesModellist.length,
                itemBuilder: (BuildContext context, int index) {
                  NotesModel st = notesModellist[index];
                  return ListTile(
                    title: Text(st.title),
                    subtitle: Text('Age: ${st.age}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.delete(st.id!);
                        setState(() {
                          notesModellist.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No Record Found Here',
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Container(); // Placeholder widget while waiting for data
          }
        
        },
        
      ),
    );
  }
}
