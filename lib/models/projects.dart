import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  String? task; //name of task
  bool? completed; //task completion status

  late DocumentReference? reference;

  Project.fromMap(Map<String, dynamic> map, {this.reference}){
    task = map['task']; //sub-collection
    completed = map['completed']; //task completion status
  }
  Project.fromSnapshot(DocumentSnapshot snapshot)
  :this.fromMap(snapshot.data() as Map<String, dynamic>,
    reference: snapshot.reference
  );
  Map<String, dynamic> toJson(){
    return {
      'task' : task,
      'completed' : completed,
    };
  }
  void storeTasks(String? value){
    task = value;
    reference?.update(toJson());
  }
  void storeProject(String? value){
    reference?.update(toJson());
  }

  void storeCompleted(bool? value){
    completed = value;
    reference?.update(toJson());
  }
}