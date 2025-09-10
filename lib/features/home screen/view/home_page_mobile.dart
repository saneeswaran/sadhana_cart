import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/home%20screen/model/custom_home_page_drawer.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/banner_list_mobile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/categories_list_mobile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/featured_product_tile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/recommanded_product_tile.dart';
import 'package:sadhana_cart/features/notification/view/notification_page_mobile.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      drawer: const CustomHomePageDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.pureWhite,
        centerTitle: true,
        title: const Text(
          "Sadhana Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Badge.count(
            count: 5,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: () {
                  navigateTo(
                    context: context,
                    screen: const NotificationPageMobile(),
                  );
                },
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
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
                // "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              FeaturedProductTile(),
              // CategoryTile(),
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
