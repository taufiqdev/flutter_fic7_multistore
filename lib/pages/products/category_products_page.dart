// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_multistore/bloc/products/products_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter_fic7_multistore/data/models/products_response_model.dart';

import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../base_widgets/custom_app_bar.dart';
import '../home/widgets/product_item.dart';

class CategoryProductsPage extends StatefulWidget {
  const CategoryProductsPage({
    Key? key,
    required this.id,
    this.name,
  }) : super(key: key);

  final int id;
  final String? name;

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductsBloc>().add(
          ProductsEvent.getByCategory(widget.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(title: widget.name),

          const SizedBox(height: Dimensions.paddingSizeSmall),

          // Products
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }, loaded: (model) {
                return Expanded(
                  child: MasonryGridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall),
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    itemCount: model.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductItemWidget(product: model.data![index]);
                    },
                  ),
                );
              }, error: (message) {
                return Center(
                  child: Text(message),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
