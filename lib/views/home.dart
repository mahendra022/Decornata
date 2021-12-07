import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:decornata/controllers/productController.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/widget.dart';
import 'package:decornata/views/productTile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> cardNotif = [
  'http://blog.fotor.com/wp-content/uploads/2017/09/1.jpg',
  'http://blog.fotor.com/wp-content/uploads/2017/09/font.jpg',
  'https://miro.medium.com/max/10008/1*9D-ZU7QWEO8w4iKF_IpZpA.jpeg',
];

class Home extends StatelessWidget {
  Widget _navbar(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width / 1.8,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.black26,
                    size: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Cari Tatakan',
                    style: TextStyle(color: Colors.black26),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
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
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print('cart');
                        }),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
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
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print('cart');
                        }),
                  )),
            ),
          ],
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
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 8),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
              items: cardNotif.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ),
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
        backgroundColor: color1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Center(child: _navbar(context)),
        ),
      ),
      body: _initHome(context),
    );
  }
}
