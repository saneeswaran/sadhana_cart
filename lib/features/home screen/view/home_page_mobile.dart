import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/home%20screen/model/custom_home_page_drawer.dart';

class HomePageMobile extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  const HomePageMobile({super.key, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomHomePageDrawer(),
      appBar: appBar,
      body: Column(children: [
          
        ],
      ),
    );
  }
}
