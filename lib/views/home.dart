import 'package:carousel_slider/carousel_slider.dart';
import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/controllers/productController.dart';
import 'package:decornata/utilitis/animation.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/widget.dart';
import 'package:decornata/views/cart.dart';
import 'package:decornata/views/productTile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> cardNotif = [
  'http://blog.fotor.com/wp-content/uploads/2017/09/1.jpg',
  'http://blog.fotor.com/wp-content/uploads/2017/09/font.jpg',
  'https://miro.medium.com/max/10008/1*9D-ZU7QWEO8w4iKF_IpZpA.jpeg',
];
final _route = AnimationRoute();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  child: Consumer<CartController>(
                    builder: (context, value, child) => Badge(
                      value: value.mountQty.toString(),
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
                            Navigator.of(context)
                                .push(_route.sliderDown(Cart()));
                          }),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Consumer<CartController>(
                    builder: (context, value, child) => Badge(
                      value: value.mountQty.toString(),
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

  Widget _viewProduct(context) {
    final productData = Provider.of<ProductController>(context);
    final allProduct = productData.allProduct;
    if (allProduct == null) {
      productData.fatchProduct();
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.black38,
          color: color1,
          strokeWidth: 4,
        )),
      );
    }
    return Column(
      children: [
        StaggeredGridView.countBuilder(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            itemCount: 8,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: allProduct[index], child: ProductTile());
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
        SizedBox(height: 10),
        Center(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'See More',
                style: TextStyle(fontSize: 15),
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
          ),
        )),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _initHome(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
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
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image.network(
                      item,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Best Product',
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: color1),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            _viewProduct(context),
          ],
        ),
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
