import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class newScreen extends StatefulWidget {
  const newScreen({super.key});

  @override
  State<newScreen> createState() => _newScreenState();
}

class _newScreenState extends State<newScreen> {
  late Map data;
  late Map newdata;
  List moredata = [];
  Future getdata() async {
    var response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        moredata = data['data'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(data);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.network(moredata[index]['avatar']),
                Text(moredata[index]['first_name']),
              ],
            ),
          );
        },
        itemCount: moredata == null ? 0 : moredata.length,
      ),
    );
  }
}
