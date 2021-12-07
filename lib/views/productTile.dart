import 'package:decornata/models/product_model.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    product.imageLink!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red[300],
                        ),
                        onPressed: () {
                          print('hai');
                        },
                      ),
                    )),
              ],
            ),
            SizedBox(height: 8),
            Text(
              product.name!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text('\$ ${product.price}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: color1)),
                ),
              ],
            ),
            SizedBox(height: 10),
            product.rating != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: color2,
                        ),
                        Text(
                          '${product.rating.toString()}  |  ${product.id} reviews',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 10),
            Center(
                child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(fontSize: 10),
                ),
                style: ElevatedButton.styleFrom(
                  primary: color1, //background color of button
                  //border width and color
                  elevation: 3, //elevation of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(
                          5)), //content padding inside button
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
