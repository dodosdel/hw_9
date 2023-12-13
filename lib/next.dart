import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lab_9/db_helper.dart';
import 'package:lab_9/registration_screen.dart';
import 'package:path/path.dart' as pth;
import 'dart:async';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = DBHelper().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Text(
                      'Phone: ${user.phone}\nEmail: ${user.email}\nAddress: ${user.address}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
