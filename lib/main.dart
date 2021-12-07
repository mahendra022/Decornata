import 'package:decornata/controllers/productController.dart';
import 'package:decornata/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
          ),
          home: Home(),
        ),
      ),
    );
  }
}
