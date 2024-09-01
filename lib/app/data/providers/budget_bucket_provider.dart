import 'package:get/get.dart';

import '../models/budget_bucket_model.dart';

class BudgetBucketProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return BudgetBucket.fromJson(map);
      if (map is List) {
        return map.map((item) => BudgetBucket.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<BudgetBucket?> getBudgetBucket(int id) async {
    final response = await get('budgetbucket/$id');
    return response.body;
  }

  Future<Response<BudgetBucket>> postBudgetBucket(
          BudgetBucket budgetbucket) async =>
      await post('budgetbucket', budgetbucket);
  Future<Response> deleteBudgetBucket(int id) async =>
      await delete('budgetbucket/$id');
}
