import 'package:flutter/material.dart';
import 'package:task_thiran/Services/db_helper.dart';
import 'package:task_thiran/Views/use_case_1/form_list_page.dart';
import 'package:task_thiran/Views/use_case_2/repo_list_page.dart';
import 'package:task_thiran/Views/use_case_3/tickets_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DatabaseHelper().init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormListPage()));
                    },
                    child: const Card(
                      elevation: 10.0,
                      child: Center(child: Text("USECASE 1")),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RepoListPage()));
                    },
                    child: const Card(
                      elevation: 10.0,
                      child: Center(child: Text("USECASE 2")),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TicketsListpage()));
                    },
                    child: const Card(
                      elevation: 10.0,
                      child: Center(child: Text("USECASE 3")),
                    ),
                  ),
                ]),
          )),
    );
  }
}
