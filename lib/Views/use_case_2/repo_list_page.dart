import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_thiran/Controllers/repo_controller.dart';
import 'package:task_thiran/Models/repo_model.dart';
import 'package:task_thiran/Models/transcation_model.dart';
import 'package:task_thiran/Services/db_helper.dart';

class RepoListPage extends StatefulWidget {
  const RepoListPage({super.key});

  @override
  State<RepoListPage> createState() => _RepoListPageState();
}

class _RepoListPageState extends State<RepoListPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Transaction> transcations = [];
  RepoController controller = Get.put(RepoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github repos "),
      ),
      body: FutureBuilder(
        future: controller.getRepoList(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              List<RepoModeL>? data = snapshot.data;
              if (data == null) {
                return const Text("Error Try Again!");
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return Card(
                          child: ListTile(
                        leading:
                            Image.network(data[i].owner!.avatarUrl.toString()),
                        trailing: Text(data[i].stargazersCount.toString()),
                        title: Text(data[i].name.toString()),
                        subtitle: Text(data[i].description ?? ""),
                      ));
                    },
                    itemCount: data.length,
                  ),
                );
              }
            }
          }
          // Displaying LoadingSpinner to indicate waiting state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
