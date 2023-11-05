import 'package:get/get.dart';
import 'package:task_thiran/Models/repo_model.dart';
import 'package:task_thiran/Services/api_helper.dart';

class RepoController extends GetxController {
  ApiHelper apiHelper = ApiHelper();

//getRepoList---------
  Future<List<RepoModeL>?> getRepoList() {
    return apiHelper.getRepoList();
  }
}
