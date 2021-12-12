import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/models/cart_model.dart';
import 'package:decornata/utilitis/alert.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  Widget _navbarBottom(context) {
    final cart = Provider.of<CartController>(context);
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
                          'Total price',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            letterSpacing: 2,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kToolbarHeight,
                      child: Center(
                        child: Text(
                          '\$${cart.mountPrice.toString()}',
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
                  ],
                ),
              ),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }

  Widget _tableData(context) {
    final cart = Provider.of<CartController>(
      context,
    );
    final items = cart.items.values.toList();
    if (items.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.4,
        child: Center(
            child: Text(
          'Your cart is still empty!!',
          style: TextStyle(color: Colors.black45, fontSize: 25),
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
                  controlAffinity: ListTileControlAffinity.leading,
                  value: product.selected,
                  onChanged: (value) => product.statusSelected(),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            child: Image.network(
                              items[index].image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.1,
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
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  'Quantity  ${items[index].qty.toString()}',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Price  \$${items[index].price.toString()}',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          cart.deleteCart(items[index].id!);
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

  Widget _cart(context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        _tableData(context),
        Container(
          child: Row(
            children: [],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color1,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            'CART',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
        ),
        body: SingleChildScrollView(child: Container(child: _cart(context))),
        bottomNavigationBar: _navbarBottom(context));
  }
}
