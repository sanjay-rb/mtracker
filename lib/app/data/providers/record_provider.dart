import 'package:get/get.dart';

import '../models/record_model.dart';

class RecordProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Record.fromJson(map);
      if (map is List) return map.map((item) => Record.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Record?> getRecord(int id) async {
    final response = await get('record/$id');
    return response.body;
  }

  Future<Response<Record>> postRecord(Record record) async =>
      await post('record', record);
  Future<Response> deleteRecord(int id) async => await delete('record/$id');
}
