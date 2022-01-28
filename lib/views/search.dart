import 'package:decornata/controllers/productController.dart';
import 'package:decornata/models/product_model.dart';
import 'package:decornata/utilitis/animation.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'detailProduct.dart';

final _route = AnimationRoute();

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  _appBar(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: color1,
              ),
        ),
        child: TypeAheadField<Product?>(
          textFieldConfiguration: TextFieldConfiguration(
            scrollPadding: EdgeInsets.all(5),
            autocorrect: false,
            autofocus: true,
            style: TextStyle(
                decoration: TextDecoration.none, decorationThickness: 0.0),
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Icon(Icons.search_outlined),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40,
                minHeight: 25,
              ),
              prefixIconColor: color1,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              isCollapsed: true,
              hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
              hintText: 'Search Product',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color1),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color1),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          suggestionsCallback: ProductAPI.getListProduct,
          itemBuilder: (context, Product? suggestion) {
            final _productAll = suggestion!;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(_route.sliderDown(
                    ChangeNotifierProvider.value(
                        value: _productAll, child: DetailProduct())));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.network(_productAll.imageLink!),
                  ),
                  dense: true,
                  title: Text(
                    _productAll.name!.toLowerCase().toTitleCase(),
                    style: TextStyle(color: color2, fontSize: 16),
                  ),
                ),
              ),
            );
          },
          onSuggestionSelected: (Product? suggestion) {},
          noItemsFoundBuilder: (context) => Center(
            child: Text(
              'Product Not Found!',
              style: TextStyle(fontSize: 16, color: color1),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Center(child: _appBar(context)),
        ),
      ),
    );
  }
}
