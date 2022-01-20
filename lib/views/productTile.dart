import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/models/product_model.dart';
import 'package:decornata/utilitis/alert.dart';
import 'package:decornata/utilitis/animation.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detailProduct.dart';

final _route = AnimationRoute();

class ProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartController>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_route.sliderDown(
            ChangeNotifierProvider.value(
                value: product, child: DetailProduct())));
      },
      child: Card(
        color: color1,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Image.network(
                    product.imageLink!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: 15,
                    bottom: 20,
                    child: Consumer<Product>(
                      builder: (context, product, child) => Center(
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: !product.isFavorite
                              ? Icon(
                                  Icons.favorite_border,
                                  size: 35,
                                )
                              : Icon(
                                  Icons.favorite,
                                  size: 35,
                                ),
                          color: color4,
                          onPressed: () {
                            product.statusFavorite();
                          },
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                product.name!.toUpperCase(),
                maxLines: 2,
                textAlign: TextAlign.left,
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 3),
            product.rating != null
                ? Container(
                    margin: EdgeInsets.only(left: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: color3,
                        ),
                        Text(
                          '${product.rating.toString()}  |  ${product.id} Sold',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(left: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: color3,
                        ),
                        Text(
                          '0.0 | 0 Sold',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('\$${product.price}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Center(
            //     child: SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       cart.addCart(product.id.toString(), product.name!,
            //           product.price!, product.imageLink!);
            //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       //   backgroundColor: Colors.transparent,
            //       //   duration: const Duration(milliseconds: 1800),
            //       //   elevation: 0,
            //       //   content: SnackBarSuccess(title: "Product add to cart"),
            //       // ));
            //     },
            //     child: Text(
            //       'ADD TO CART',
            //       style: TextStyle(fontSize: 10),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       primary: color1, //background color of button
            //       //border width and color
            //       elevation: 3, //elevation of button
            //       shape: RoundedRectangleBorder(
            //           //to set border radius to button
            //           borderRadius: BorderRadius.circular(
            //               5)), //content padding inside button
            //     ),
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}
