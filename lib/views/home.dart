import 'package:carousel_slider/carousel_slider.dart';
import 'package:decornata/controllers/cartController.dart';
import 'package:decornata/controllers/productController.dart';
import 'package:decornata/controllers/recomendProductController.dart';
import 'package:decornata/utilitis/animation.dart';
import 'package:decornata/utilitis/color.dart';
import 'package:decornata/utilitis/widget.dart';
import 'package:decornata/views/cart.dart';
import 'package:decornata/views/productView.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> cardNotif = [
  'https://image.freepik.com/free-vector/hand-painted-makeup-selfcare-web-sale-banner-design-with-beautiful-woman_60389-28.jpg',
  'https://image.freepik.com/free-vector/vector-realistic-cosmetic-promo-poster_33099-1346.jpg',
  'https://image.freepik.com/free-psd/top-view-makeup-mock-up-concept_23-2148685167.jpg',
];

final _route = AnimationRoute();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? pageController;

  _navbar(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color4.withOpacity(0.2),
          ),
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width / 1.6,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Search eyebrow',
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Consumer<CartController>(
                builder: (context, value, child) => Badge(
                  value: '0',
                  color: Colors.red,
                  child: SizedBox(
                    height: 40,
                    width: 35,
                    child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.favorite_border,
                          color: color4,
                        ),
                        onPressed: () {
                          print('ini Favorite');
                        }),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              child: Consumer<CartController>(
                builder: (context, value, child) => Badge(
                  value: value.mountQty.toString(),
                  color: Colors.red,
                  child: SizedBox(
                    height: 40,
                    width: 35,
                    child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: color4,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(_route.sliderDown(Cart()));
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _recomendProduct(context) {
    final productData = Provider.of<RecomendProductController>(context);
    final allProduct = productData.allProduct;
    if (allProduct == null) {
      productData.fatchProduct();
      return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.black38,
          color: color1,
          strokeWidth: 4,
        )),
      );
    }
    return SizedBox(
        height: 250,
        child: ListView.builder(
          controller: pageController,
          itemCount: 9,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                value: allProduct[index], child: RecomendProduct());
          },
        ));
  }

  _viewProduct(context) {
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
            reverse: true,
            shrinkWrap: true,
            itemCount: 14,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: allProduct[index], child: ProductTile());
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
        SizedBox(height: 10),
      ],
    );
  }

  _initHome(context) {
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Flash Sale!',
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: color1),
                  ),
                ),
              ],
            ),
            _recomendProduct(context),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/banner1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Special For You!',
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: color1),
                  ),
                ),
              ],
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
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Center(child: _navbar(context)),
        ),
      ),
      body: _initHome(context),
    );
  }
}
