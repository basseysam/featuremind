import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:featureminds/core/utils/app_colors.dart';
import 'package:featureminds/core/utils/app_strings.dart';
import 'package:featureminds/core/widgets/custom_shimmer.dart';
import 'package:featureminds/core/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/local_data_storage.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/product_cart.dart';
import '../../../core/widgets/text_input.dart';
import '../models/product_constants.dart';
import '../models/product_model.dart';
import '../provider/transaction_provider.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  final CarouselController _controller = CarouselController();

  final _formKey = GlobalKey<FormState>();
  int _current = 0;
  List<String> image = [
    AppString.bannerOne,
    AppString.bannerTwo,
    AppString.bannerThree,
    AppString.bannerFour,
  ];

  bool loading = false;
  final _category = TextEditingController();
  List<ProductModel>? response;
  String? errText;


  List<String> myList = [];
  late List<String> suggestions = [];

  getSearchProduct({required String searchTerm, int? pageIndex = 0, bool showLoading = true}) {
    ProductConstants.loadingHistory = showLoading;
    FocusScope.of(context).unfocus();
    setState(() {
      loading = showLoading;
    });
    ref.read(getProductsProvider.notifier).getProducts(
      searchterm: searchTerm,
      showLoading: ProductConstants.loadingHistory,
      pageIndex: pageIndex!,
      then: (data) async {
        ProductConstants.history.clear();
        response = data;
        setState(() {
          if (pageIndex == 1) ProductConstants.history.clear();
          ProductConstants.history.addAll(response!);
          ProductConstants.loadingHistory = false;
          loading = false;
        });
        myList.add(searchTerm);
        await saveSearchHistory(myList);
        ProductConstants.currentPageNum = pageIndex = 10;
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
  Future<void> didChangeDependencies() async {
    suggestions = await getSearchHistory();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: Transform(
            transform: Matrix4.translationValues(20, 0, 0),
            child: Image.asset(AppString.appLogo)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SvgPicture.asset(AppString.heart),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SvgPicture.asset(AppString.bell),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SvgPicture.asset(AppString.cart),
          ),
          const Gap(20),
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return suggestions;
                      },
                      onSelected: (String selection) {
                        _category.text = selection;
                      },
                      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {

                        return TextInputNoIcon(
                          text: '',
                          controller: textEditingController,
                          showTitle: false,
                          inputType: TextInputType.name,
                          hintText: 'Search Product',
                          focusNode: focusNode,
                          onChanged: (value){
                            _category.text = value!;
                          },
                          validator: (value) {
                            return isName(value) ? null : "Input a valid search word";
                          },
                        );

                      },
                      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                        return Visibility(
                          visible: suggestions.isNotEmpty ? true : false,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                height: 400,
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: CustomText(option),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: (){
                      if(!_formKey.currentState!.validate()){
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
                      _category.clear();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: AppColors.primaryColor),
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14),
                        child: Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colors.white,
            child: CarouselSlider.builder(
              itemCount: image.length,
              carouselController: _controller,
              itemBuilder: (context, index, realIndex) {
                final urlImage = image[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                height: double.maxFinite,
                autoPlay: true,
                viewportFraction: 1,
                pauseAutoPlayOnTouch: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: _current,
                count: image.length,
                effect: const WormEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.borderColor,
                    dotHeight: 9,
                    dotWidth: 8),
              ),
            ],
          ),
          const Gap(10),
          Expanded(
            child: loading ? const SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    CustomShimmer(),
                  ],
                ),
              ),
            ) : ProductConstants.history.isNotEmpty ? SizedBox(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: AlignedGridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  itemBuilder: (context, index) {
                    return ProductWidget(productModel: ProductConstants.history[index],);
                  },
                  itemCount: ProductConstants.history.length,
                ),
              ),
            ) : const SingleChildScrollView(
              child: Center(
                child:
                EmptyWidget(title: 'No Product Found',),

              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Image.asset(
        fit: BoxFit.fitWidth,
        urlImage,
        height: 200,
        width: MediaQuery.of(context).size.width,
      );
}


