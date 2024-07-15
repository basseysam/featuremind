import 'package:featureminds/features/dashboard/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/notifiers.dart';
import '../repository/transaction_repository.dart';

final getProductsProvider = StateNotifierProvider<GetProductStateNotifier,
        NotifierState<List<ProductModel>>>(
    (ref) => GetProductStateNotifier());

class GetProductStateNotifier
    extends StateNotifier<NotifierState<List<ProductModel>>> {
  GetProductStateNotifier() : super(notifyIdle());

  void getProducts({
    required BuildContext context,
    required String searchterm,
    bool showLoading = false,
    int pageIndex = 1,
    int? limit,
    Function(List<ProductModel>?)? then,
    Function(String?)? errorCB,
  }) async {
    if (showLoading) state = notifyLoading();
    state = await ProductRepository.getProducts(
        pageIndex: pageIndex,
        limit: limit,
      search: searchterm
    );

    ProcessProviderState.run<List<ProductModel>>(
      state,
      onSuccessCallback: then,
      onErrorCallBack: errorCB,
      checkNoAuth: true,
      showErrorPopUp: false,
      context: context,
    );
  }

}
