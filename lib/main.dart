import 'package:decornata/controllers/productController.dart';
import 'package:decornata/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controllers/cartController.dart';
import 'controllers/recomendProductController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // change colors status bar app
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // block rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Material(
      type: MaterialType.transparency,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductController>(
            create: (context) => ProductController(),
          ),
          ChangeNotifierProvider<CartController>(
            create: (context) => CartController(),
          ),
          ChangeNotifierProvider<RecomendProductController>(
            create: (context) => RecomendProductController(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'FontTwo',
            scaffoldBackgroundColor: Colors.white,
          ),
          home: Home(),
        ),
      ),
    );
  }
}
