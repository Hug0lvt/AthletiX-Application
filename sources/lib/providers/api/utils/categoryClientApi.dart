import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/category.dart';

class CategoryClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'categories';

  CategoryClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Category> createCategory(Category category) async {
    return categoryFromJson(await _clientApi.postData(_endpoint, categoryToJson(category)));
  }

  Future<Category> getCategoryById(int categoryId) async {
    return categoryFromJson(await _clientApi.getDataById(_endpoint, categoryId));
  }

  // TODO LIST
  Future<Category> getCategory(String categoryEmail) async {
    return categoryFromJson(await _clientApi.getData(_endpoint));
  }

  Future<Category> updateCategory(int categoryId, Category updatedCategory) async {
    return categoryFromJson(await _clientApi.putData('$_endpoint/$categoryId', categoryToJson(updatedCategory)));
  }

  Future<Category> deleteCategory(int categoryId) async {
    return categoryFromJson(await _clientApi.deleteData('$_endpoint/$categoryId'));
  }
}