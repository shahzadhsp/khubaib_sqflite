// import 'package:flutter/material.dart';
// import 'package:khubaib_sqflite/db_handler.dart';
// import 'package:khubaib_sqflite/form_screen.dart';
// import 'package:khubaib_sqflite/notes_model.dart';

// class ShowData extends StatefulWidget {
//   const ShowData({super.key});

//   @override
//   State<ShowData> createState() => _ShowDataState();
// }

// class _ShowDataState extends State<ShowData> {
//   DbHelper dbHelper = DbHelper();

//   @override
//   Widget build(BuildContext context) {
//     List<NotesModel> notesModellist = [];
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Notes'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async{
//             print('Click');
//           var value= await  Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FormScreen(),
//               ),
//             );
//             setState(
//                 () {
//                   if (value.title != "" &&
//                       value.email != "" &&
//                       value.age != "" &&
//                       value.description != "") {
//                     NotesModel notesModel = NotesModel(
//                       title: value.title,
//                       email: value.email,
//                       age: int.parse(value.age),
//                       description: value.description,
//                     );
//                     dbHelper.insert(notesModel);
//                   }
//                 },
//               );
//           },
//           child: Icon(Icons.add),
//         ),
//         body: notesModellist.isNotEmpty
//             ? Expanded(
//                 child: FutureBuilder(
//                   future: dbHelper.getNotesList(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       notesModellist = snapshot.data as List<NotesModel>;
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           NotesModel st = notesModellist[index];
//                           return Row(
//                             children: [
//                               Card(
//                                 color: Colors.red,
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       'Title ${st.title}',
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 16),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text('Age ${st.age}',
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 15)),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text('Email ${st.email}',
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 16)),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text('Description: ${st.description}',
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 16)),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     // _titleController.text= st.title;
//                                     // _emailController.text= st.email;
//                                     // _ageController.text = st.email;
//                                     // _descriptionController.text= st.description;
//                                     // notesModellist =st as List<NotesModel>;
//                                     // updatIndex = index;
//                                   },
//                                   icon: Icon(
//                                     Icons.edit,
//                                     color: Colors.blue,
//                                     size: 20,
//                                   )),
//                               IconButton(
//                                   onPressed: () {
//                                     dbHelper.delete(st.id as int);
//                                     setState(() {
//                                       notesModellist.removeAt(index);
//                                     });
//                                   },
//                                   icon: Icon(
//                                     Icons.delete,
//                                     color: Colors.red,
//                                     size: 20,
//                                   )),
//                             ],
//                           );
//                         },
//                       );
//                     }
//                     return CircularProgressIndicator();
//                   },
//                 ),
//               )
//             : Center(
//                 child: Text(
//                   'No Record Found Here',
//                   style: TextStyle(fontSize: 30),
//                 ),
//               ));
//   }
// }
