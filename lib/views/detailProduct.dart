import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/models/product_model.dart';
import 'package:decornata/utilitis/alert.dart';
import 'package:decornata/utilitis/animation.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/widget.dart';
import 'package:decornata/views/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _route = AnimationRoute();

class DetailProduct extends StatelessWidget {
  _navbar(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, bottom: 5),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: color4,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  'ITEM DETAIL',
                  style: TextStyle(
                      color: color4,
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700),
                )),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Consumer<CartController>(
                    builder: (context, value, child) => Badge(
                      value: '0',
                      color: Colors.red,
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.favorite_border,
                            color: color4,
                          ),
                          onPressed: () {
                            print('ini favorite');
                          }),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, top: 5),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Consumer<CartController>(
                    builder: (context, value, child) => Badge(
                      value: value.mountQty.toString(),
                      color: Colors.red,
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            color: color4,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(_route.sliderDown(Cart()));
                          }),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  _tagLine(context) {
    final product = Provider.of<Product>(context, listen: false);
    return Column(
      children: [
        Container(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(
                    product.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87.withAlpha(180)),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Consumer<Product>(
                        builder: (context, product, child) => IconButton(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: !product.isFavorite
                              ? Icon(
                                  Icons.favorite_border,
                                  size: 25,
                                )
                              : Icon(
                                  Icons.favorite,
                                  size: 25,
                                ),
                          color: Colors.red[300],
                          onPressed: () {
                            product.statusFavorite();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$ ${product.price}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w900, color: color1),
              ),
            ),
            Row(
              children: [
                product.rating != null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: color2,
                            ),
                            Text(
                              ' ${product.rating.toString()}  |  Sold ${product.id}',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: color2,
                            ),
                            Text(
                              '0.0 | 0 reviews',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
              ],
            )
          ],
        )),
      ],
    );
  }

  _description(context) {
    final product = Provider.of<Product>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Description',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 1.3,
                color: color1),
          ),
        ),
        Container(
            child: Text(
          product.description!,
          style: TextStyle(color: Colors.black54),
        ))
      ],
    );
  }

  _detailProduct(context) {
    final product = Provider.of<Product>(context, listen: false);
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            clipBehavior: Clip.antiAlias,
            height: MediaQuery.of(context).size.height / 2.2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1))
              ],
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Image.network(
              product.imageLink!,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _tagLine(context),
        SizedBox(
          height: 20,
        ),
        _description(context),
      ],
    ));
  }

  _navbarBottom(context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartController>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Row(
          children: [
            Material(
              color: color1,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              child: InkWell(
                onTap: () {
                  cart.addCart(product.id.toString(), product.name!,
                      product.price!, product.imageLink!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.transparent,
                    duration: const Duration(milliseconds: 1800),
                    elevation: 0,
                    content: SnackBarSuccess(title: "Product add to cart"),
                  ));
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: 120,
                  child: Center(
                    child: Text(
                      'Add to Cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: color4,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: InkWell(
                  onTap: () {
                    print('Buy Now');
                  },
                  child: const SizedBox(
                    height: kToolbarHeight,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'BUY NOW',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: Center(child: _navbar(context)),
          ),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: _detailProduct(context))),
        bottomNavigationBar: _navbarBottom(context));
  }
}
