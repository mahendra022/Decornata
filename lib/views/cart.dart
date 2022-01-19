import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/models/cart_model.dart';
import 'package:decornata/utilitis/alert.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  Widget _navbarBottom(context) {
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
    final cart = Provider.of<CartController>(context, listen: true);
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
                            child: Image.network(
                              items[index].image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
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
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      'Quantity  ',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
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
            backgroundColor: color1,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  _exit(context, cart);
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
          bottomNavigationBar: _navbarBottom(context)),
    );
  }
}
