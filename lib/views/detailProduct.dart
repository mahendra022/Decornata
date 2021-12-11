import 'package:decornata/models/product_model.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:flutter/material.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({Key? key, required this.product}) : super(key: key);

  final Product product;

  Widget _detailProduct(context) {
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
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
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
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '\$ ${product.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: color1),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color1,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'ITEM DETAILS',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              fontSize: 17),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Row(
          children: [
            Material(
              color: color2,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              child: InkWell(
                onTap: () {
                  print('add Cart');
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
                color: color1,
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
      body: SingleChildScrollView(child: _detailProduct(context)),
    );
  }
}
