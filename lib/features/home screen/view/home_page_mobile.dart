import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/home%20screen/model/custom_home_page_drawer.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/banner_list_mobile.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/categories_list_mobile.dart';

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
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            CategoriesListMobile(),
            SizedBox(height: 20),
            BannerListMobile(),
          ],
        ),
      ),
    );
  }
}
