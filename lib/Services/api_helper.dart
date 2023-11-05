import 'package:dio/dio.dart';
import 'package:task_thiran/Models/repo_model.dart';

class ApiHelper {
  final dio = Dio();

  Future<List<RepoModeL>?> getRepoList() async {
    try {
      final response = await dio.get(
          "https://api.github.com/search/repositories?q=created:%3E2023-09-05&sort=stars&order=desc");
      //  print(response.data);
      if (response.statusCode == 200) {
        Map data = response.data;
        List repoList = data['items'];
        return repoList.map((e) => RepoModeL.fromJson(e)).toList();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
