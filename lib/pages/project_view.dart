import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/projects.dart';
class view_project extends StatefulWidget {
  // final db = FirebaseFirestore.instance;
  Project project;
  view_project(this.project);
  @override
  State<view_project> createState() => _view_projectState();
}

class _view_projectState extends State<view_project> {
  Color cardColor = Colors.yellow;
  @override

  Widget build(BuildContext context) {
    if(widget.project.completed == true){
      cardColor = Colors.greenAccent;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.project.reference?.id}", style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: 1,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index){
                return Card(
                  color: cardColor,
                  child: ListTile(
                    leading: Container(
                      height: 20,
                      width: 20,
                      decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle
                      ),
                    ),
                    title: Text("${widget.project.task}"),
                    trailing: ElevatedButton(
                      onPressed: (){
                        FirebaseFirestore.instance.collection('projects')
                            .doc(widget.project.reference!.id)
                        .update({'completed' : true});
                        cardColor = Colors.greenAccent;
                        setState(() {

                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue)
                      ),
                      child: Text("Complete!", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}