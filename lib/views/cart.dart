import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/models/cart_model.dart';
import 'package:decornata/models/product_model.dart';
import 'package:decornata/utilitis/alert.dart';
import 'package:decornata/utilitis/animation.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/widget.dart';
import 'package:decornata/views/detailProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _route = AnimationRoute();

class Cart extends StatelessWidget {
  _navbar(context) {
    final cart = Provider.of<CartController>(context);
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
                    _exit(context, cart);
                  }),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  'MY CART',
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
              margin: EdgeInsets.only(top: 5, right: 10),
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
          ],
        ),
      ],
    );
  }

  _navbarBottom(context) {
    return Container(
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: Center(
                        child: Text(
                          'Total Price',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            letterSpacing: 2,
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kToolbarHeight,
                      child: Consumer<CartController>(
                        builder: (context, value, child) => Center(
                          child: Text(
                            '\$${value.mount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 20,
                              letterSpacing: 2,
                              color: color1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<CartController>(
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  if (value.mount == 0.0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      duration: const Duration(milliseconds: 2000),
                      elevation: 0,
                      content:
                          SnackBarDanger(title: "Please select item for buy"),
                    ));
                  } else {
                    print('HAI');
                  }
                },
                child: Container(
                  color: color1,
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
          ],
        ),
      ),
    );
  }

  _tableData(context) {
    final cart = Provider.of<CartController>(context, listen: true);
    final items = cart.items.values.toList();
    if (items.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.4,
        child: Center(
            child: Text(
          'Your cart is still empty!!',
          style: TextStyle(color: Colors.black45, fontSize: 20),
        )),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider<CartModel>(
              create: (context) => CartModel(),
              child: Consumer<CartModel>(
                builder: (context, product, child) => CheckboxListTile(
                  activeColor: color1,
                  visualDensity: VisualDensity.standard,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: product.selected,
                  onChanged: (value) {
                    product.statusSelected();
                    cart.getMount(product.selected, items[index]);
                  },
                  title: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                items[index].image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: Text(
                                  items[index].title!,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: color1),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (items[index].qty! > 1) {
                                        cart.removeQuantity(
                                            items[index].id.toString());
                                        cart.getMountQuantity(product.selected,
                                            true, items[index]);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.black12),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black54,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 7),
                                    child: Text(
                                      items[index].qty.toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cart.addQuantity(
                                          items[index].id.toString());
                                      cart.getMountQuantity(product.selected,
                                          false, items[index]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.black12),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black54,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${items[index].price.toString()}',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                          color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          product.selected = false;
                                          cart.deleteCart(items[index].id!,
                                              items[index], product.selected);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.transparent,
                                            duration: const Duration(
                                                milliseconds: 1800),
                                            elevation: 0,
                                            content: SnackBarSuccess(
                                                title: "Product remove"),
                                          ));
                                        },
                                        icon: Icon(
                                          Icons.delete_outlined,
                                          color: Colors.black45,
                                          size: 18,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Divider(
                            color: Colors.black38,
                            height: 2,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  _cart(context) {
    return Column(
      children: [
        _tableData(context),
        Container(
          child: Row(
            children: [],
          ),
        ),
      ],
    );
  }

  _exit(context, cart) {
    Navigator.pop(context);
    cart.resetMount();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);
    return WillPopScope(
      onWillPop: () => _exit(context, cart),
      child: Scaffold(
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
                  margin: EdgeInsets.only(top: 10), child: _cart(context))),
          bottomNavigationBar: _navbarBottom(context)),
    );
  }
}
