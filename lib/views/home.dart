import 'package:decornata/controllers/productController.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/widget.dart';
import 'package:decornata/views/product.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Widget _navbar(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, left: 20),
          child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                'Dekornata',
                style: TextStyle(
                    fontSize: 20, color: color1, fontWeight: FontWeight.w600),
              )),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SizedBox(
              height: 40,
              width: 40,
              child: Badge(
                value: '0',
                color: Colors.amber,
                child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: color1,
                    ),
                    onPressed: () {
                      print('cart');
                    }),
              )),
        ),
      ],
    );
  }

  Widget _viewProduct(context) {
    return Expanded(
        child: ChangeNotifierProvider<ProductController>(
            create: (context) => ProductController(),
            child: Consumer<ProductController>(builder: (context, provider, _) {
              if (provider.allProduct == null) {
                provider.fatchProduct();
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.black38,
                  color: Colors.cyan[600],
                  strokeWidth: 3,
                ));
              }
              return StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  itemCount: provider.allProduct!.length,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) {
                    return ProductTile(provider.allProduct![index]);
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1));
            })));
  }

  Widget _initHome(context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          _viewProduct(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Center(child: _navbar(context)),
        ),
      ),
      body: _initHome(context),
    );
  }
}
