import 'package:featureminds/core/navigators/navigators.dart';
import 'package:featureminds/core/utils/app_strings.dart';
import 'package:featureminds/features/dashboard/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_snackbar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/text_input.dart';
import '../models/product_constants.dart';
import '../provider/transaction_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  final _category = TextEditingController();
  List<ProductModel>? response;
  String? errText;

  getSearchProduct({required String searchTerm, int? pageIndex = 0, bool showLoading = true}) {
    ProductConstants.loadingHistory = showLoading;
    setState(() {
      loading = showLoading;
    });
    ref.read(getProductsProvider.notifier).getProducts(
        searchterm: searchTerm,
        showLoading: ProductConstants.loadingHistory,
        pageIndex: pageIndex!,
        then: (data) {
          response = data;
          setState(() {
            if (pageIndex == 1) ProductConstants.history.clear();
            ProductConstants.history.addAll(response!);
            ProductConstants.loadingHistory = false;
            loading = false;
          });
          ProductConstants.currentPageNum = pageIndex = 10;
          Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
        },
        errorCB: (err) {
          ProductConstants.history.clear();
          setState(() {
            ProductConstants.loadingHistory = false;
            setState(() {
              loading = false;
            });
            errText = err;
          });
        },
        context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppString.createAccount,
                    height: 150,
                    width: 222,
                  ),
                  const CustomText(
                    'Search Category',
                    fontSize: 32,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  const CustomText(
                    "Search for a product using either Shirt, Shoe, Short, Bag, Cap etc or Generic to get all Products",
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(20),
                  TextInputNoIcon(
                    controller: _category,
                    text: 'Enter Product Category',
                    requiredField: true,
                    inputType: TextInputType.emailAddress,
                    hintText: '',
                    validator: (value) {
                      return isName(value) ? null : "Input a valid search word";
                    },
                  ),
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PrimaryButton(
                       isLoading: loading,
                        title: 'Proceed',
                        onPress: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          String search = "";
                          if(_category.text.toLowerCase() == "generic"){
                            search = "";
                          }else{
                            search = _category.text;
                          }
                          getSearchProduct(
                              searchTerm: search,
                          );
                          //
                        }),
                  ),
                  const Gap(30),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
