import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/pages/project_view.dart';
import 'package:final_project/pages/make_projects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:final_project/models/projects.dart';

class show_projects extends StatefulWidget {
  @override
  State<show_projects> createState() => _show_projectsState();
}

class _show_projectsState extends State<show_projects> {
  List<Project> projects = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => make_projects(),
            ),
          );
        }
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("projects").snapshots(),
        builder: (context, snapshot) {
          projects = [];
          for (DocumentSnapshot doc in snapshot.data!.docs) {
            projects.add(Project.fromSnapshot(doc));
          }
          print(projects.length);
          return _showAll(projects);
        });
  }

  _showAll(List<Project> projects) {
    return Column(
      children: [
        Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Card(
            child: ListTile(
              leading: Image.asset("assets/woman.jpg"),
              title: Text(
                "Denise",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: 95,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.notifications_none),
                    Icon(Icons.settings_sharp),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          height: 100,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.red, Colors.cyan],
                  stops: [0.5, 0.8])),
          child: Text(
            "Projects",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: projects.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        print(projects);
                        return view_project(projects[index]);
                      },
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.format_list_bulleted),
                  title: Text("${projects[index].reference?.id}"),
                  trailing: Text("1"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
