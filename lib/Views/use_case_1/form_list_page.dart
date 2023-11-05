import 'package:flutter/material.dart';
import 'package:task_thiran/Models/transcation_model.dart';
import 'package:task_thiran/Services/db_helper.dart';
import 'package:task_thiran/Views/use_case_1/form_page.dart';

class FormListPage extends StatefulWidget {
  const FormListPage({super.key});

  @override
  State<FormListPage> createState() => _FormListPageState();
}

class _FormListPageState extends State<FormListPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Transaction> transcations = [];

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  ///get all data from DB
  Future getDataFromDB() async {
    await dbHelper.queryAllRows().then((value) {
      transcations = value
          .map((e) => Transaction(
              tDescription: e['description'],
              tDateTime: e['datetime'],
              tStatus: e['status']))
          .toList();
      setState(() {});
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Transactions"),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10.0,
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FormPage()))
                .then((value) {
              if (value != null && value) {
                getDataFromDB();
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Card(
                  child: ListTile(
                leading: const Icon(Icons.receipt),
                title: Text(transcations[i].tDescription),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(transcations[i].tStatus),
                      Text(transcations[i].tDateTime),
                    ]),
              ));
            },
            itemCount: transcations.length,
          ),
        ));
  }
}
