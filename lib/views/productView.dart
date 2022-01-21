import 'package:decornata/models/product_model.dart';
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
          ],
        ),
      ),
    );
  }
}

class RecomendProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_route.sliderDown(
            ChangeNotifierProvider.value(
                value: product, child: DetailProduct())));
      },
      child: Container(
        width: 130,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1.0,
                  offset: Offset(
                    0,
                    1,
                  ),
                  color: Colors.black12.withOpacity(0.04),
                  spreadRadius: 2),
            ]),
        child: Column(
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Image.network(
                product.imageLink!,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                  color: Colors.white,
                ),
                width: 180,
                height: 85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            product.name!.toUpperCase(),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '\$${product.price!}',
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.black,
                                fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 14,
                              width: 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: color4,
                              ),
                              child: Text(
                                '%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 1,
                                    color: Colors.white,
                                    fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                '\$${45.76}',
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.lineThrough,
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 17,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              //size image 300x130 pixsel
                              image: AssetImage('assets/images/FreeOngkir.png'),
                              fit: BoxFit.fill)),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
