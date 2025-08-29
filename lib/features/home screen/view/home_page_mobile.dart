import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/home%20screen/model/custom_home_page_drawer.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/banner_list_mobile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/categories_list_mobile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/featured_product_tile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/recommanded_product_tile.dart';

class HomePageMobile extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  const HomePageMobile({super.key, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      drawer: const CustomHomePageDrawer(),
      appBar: appBar,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              CategoriesListMobile(),
              SizedBox(height: 20),
              BannerListMobile(),
              SizedBox(height: 20),
              Text(
                "Featured Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              FeaturedProductTile(),
              SizedBox(height: 20),
              Text(
                "Recommended Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              RecommandedProductTile(),
            ],
          ),
        ),
      ),
    );
  }
}
