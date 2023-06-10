import 'package:flutter/material.dart';
import 'package:khubaib_sqflite/db_handler.dart';
import 'package:khubaib_sqflite/notes_model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();

  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
// create a database class instance
  DbHelper dbHelper = DbHelper();
  // create a model class instance
  NotesModel? notesModel;
  // initialize a list 
  List<NotesModel> notesModellist = [];

 // int updatIndex=0;
 //create a global form key for check validation 
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  //  List<NotesModel> notesModellist = [];
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
                keyboardType: TextInputType.number,
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
                 
                  _submittedButton(context);
                  
                  setState(() {});
                },
                child: Text('Submitted'),
              ),
              SizedBox(
                height: 20,
              ),
              // Expanded(
              //   child: FutureBuilder(
              //     future: dbHelper.getNotesList(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         notesModellist = snapshot.data as List<NotesModel>;
              //         return ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: snapshot.data!.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             NotesModel st = notesModellist[index];
              //             return Row(
              //               children: [
              //                 Card(
              //                   color: Colors.red,
              //                   child: Column(
              //                     children: [
              //                       Text(
              //                         'Title ${st.title}',
              //                         style: TextStyle(
              //                             color: Colors.white, fontSize: 16),
              //                       ),
              //                       SizedBox(
              //                         height: 20,
              //                       ),
              //                       Text('Age ${st.age}',
              //                           style: TextStyle(
              //                               color: Colors.white, fontSize: 15)),
              //                       SizedBox(
              //                         height: 20,
              //                       ),
              //                       Text('Email ${st.email}',
              //                           style: TextStyle(
              //                               color: Colors.white, fontSize: 16)),
              //                       SizedBox(
              //                         height: 20,
              //                       ),
              //                       Text('Description: ${st.description}',
              //                           style: TextStyle(
              //                               color: Colors.white, fontSize: 16)),
              //                     ],
              //                   ),
              //                 ),
              //                 IconButton(
              //                     onPressed: () {
              //                       // _titleController.text= st.title;
              //                       // _emailController.text= st.email;
              //                       // _ageController.text = st.email;
              //                       // _descriptionController.text= st.description;
              //                       // notesModellist =st as List<NotesModel>;
              //                       // updatIndex = index;
              //                     },
              //                     icon: Icon(
              //                       Icons.edit,
              //                       color: Colors.blue,size: 20,
              //                     )),
              //                 IconButton(
              //                     onPressed: () {
                                    
              //                       dbHelper.delete(st.id as int);
              //                       setState(() {
              //                         notesModellist.removeAt(index);
              //                       });
              //                     },
              //                     icon: Icon(
              //                       Icons.delete,
              //                       color: Colors.red,size: 20,
              //                     )),
              //               ],
              //             );
              //           },
              //         );
              //       }
              //       return CircularProgressIndicator();
              //     },
              //   ),
              // ),
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
            age: int.parse(_ageController.text),
            description: _descriptionController.text);
        dbHelper.insert(notesModel).then(
          (id) {
            print('Submitted form successfuly ${id}');
            print(' Titl :${_titleController.text}');
            print('Email: ${_emailController.text}');
            print('Age :${_ageController.text}');

            print(" Description : ${_descriptionController.text}");
            _titleController.clear();
            _ageController.clear();
            _emailController.clear();
            _descriptionController.clear();
            //Retrieve update note list
            dbHelper.getNotesList().then((updatedlist) {
              setState(() {
                notesModellist = updatedlist;
              });
            
            });
          },
        );
      }
      // else{
      //   // notesModellist.title =_titleController.text;
      //   // notesModel!.email=_emailController.text;
      //   // notesModel!.age=int.parse(_ageController.text);
      //   // notesModel!.description=_descriptionController.text;
      //   dbHelper.update(notesModel!).then((id) {
      //     setState(() {
      //       notesModellist[updatIndex]=  _titleController.text as NotesModel;
      //       notesModellist[updatIndex]=_emailController.text as NotesModel;
      //       notesModellist[updatIndex]=_ageController.text as NotesModel;
      //       notesModellist[updatIndex]= _descriptionController.text as NotesModel;
      //     });
      //     _titleController.clear();
      //       _ageController.clear();
      //       _emailController.clear();
      //       _descriptionController.clear();
      //         notesModel = null;
      //   });
      // }
    }
    Navigator.pop(context,notesModel);
  }
}
