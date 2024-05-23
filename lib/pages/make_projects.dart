import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/pages/project_list.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/firestoreServices.dart';

class make_projects extends StatefulWidget {
  @override
  State<make_projects> createState() => _make_projectsState();
}

class _make_projectsState extends State<make_projects> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? title;
  String? task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a Project!"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff4527A0),
          ),
          padding: EdgeInsets.all(25),
          child: Container(
            color: Colors.white70,
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        color: Colors.greenAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a title for the project.';
                                }
                              },
                              onSaved: (value) {
                                title = value!;
                              },
                              decoration: InputDecoration(
                                  labelText: "Enter title of Project:"),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "Task:"),
                              onSaved: (value) {
                                task = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              FirebaseFirestore.instance
                                  .collection("projects")
                                  .doc(title)
                                  .set({
                                "task" : task,
                                "completed" : false,
                              });
                            }
                          },
                          child: Text("Confirm")),
                      ElevatedButton(onPressed: (){
                        setState(() {

                        });
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context){
                                  return show_projects();
                                },
                            ),
                        );
                      },
                          child: Text("View Project List"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
