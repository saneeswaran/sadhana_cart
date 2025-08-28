import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sadhana_cart/core/common%20model/banner_model.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';

class MainHelper {
  //inits
  static Future<void> inits() async {
    //bindings
    WidgetsFlutterBinding.ensureInitialized();

    //initialize hive
    await Hive.initFlutter();

    //register adapters
    Hive.registerAdapter<BannerModel>(BannerModelAdapter());
    Hive.registerAdapter<CategoryModel>(CategoryModelAdapter());

    //open boxes
    await Hive.openBox<BannerModel>('bannerBox');
    await Hive.openBox<CategoryModel>('categoryBox');
  }
}
