import 'package:flutter/material.dart';
import 'package:khubaib_sqflite/db_handler.dart';
import 'package:khubaib_sqflite/home_screen.dart';
import 'package:khubaib_sqflite/notes_model.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  DbHelper dbHelper = DbHelper();
  List<NotesModel> notesModellist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Click');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
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
                      // Text('Name ${st.age}',
                      //     style: TextStyle(color: Colors.red)),
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
    );
  }
}
