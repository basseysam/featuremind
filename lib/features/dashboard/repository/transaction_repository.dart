import 'package:featureminds/features/dashboard/models/product_model.dart';
import 'package:logger/logger.dart';

import '../../../core/logger.dart';
import '../../../core/network/notifiers.dart';
import '../../../core/network/service_response.dart';

class ProductRepository {
  static Future<NotifierState<List<ProductModel>>> getProducts(
      {int pageIndex = 0, int? limit, String? search}) async {
    //String url = "/transaction/history?page=$pageIndex";
    String url = "title=$search&offset=$pageIndex&limit=10";
    return (await ApiService<List<ProductModel>>().getCall(
      url,
      onReturn: (res) => logResponse(res),
      getDataFromResponse: (data) {
        List<ProductModel> list = [];
        if (data != null && data.isNotEmpty) {
          list = List<ProductModel>.from(
              data.map((x) => ProductModel.fromJson(x)));
        }
        return list;
      },
    )).toNotifierState();
  }
}
