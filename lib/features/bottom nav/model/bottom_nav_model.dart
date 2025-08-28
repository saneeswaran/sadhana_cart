import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/features/cart/view/cart_page_mobile.dart';
import 'package:sadhana_cart/features/favorites/view/favorite_page_mobile.dart';
import 'package:sadhana_cart/features/home%20screen/view/home_page_mobile.dart';
import 'package:sadhana_cart/features/search%20product/view/search_product_mobile.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

List<BottomBarItem> bottomBarItems = [
  BottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: AppColors.primaryColor,
    selectedIcon: const Icon(Icons.home),
  ),
  BottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Search"),
    selectedColor: AppColors.primaryColor,
    selectedIcon: const Icon(Icons.search),
  ),
  BottomBarItem(
    icon: const Icon(Icons.favorite),
    title: const Text("favorite"),
    selectedColor: AppColors.primaryColor,
    selectedIcon: const Icon(Icons.favorite),
  ),
  BottomBarItem(
    icon: const Icon(Icons.shopping_bag),
    title: const Text("Cart"),
    selectedColor: AppColors.primaryColor,
    selectedIcon: const Icon(Icons.shopping_bag),
  ),
];

final List<Widget> bottomPages = [
  HomePageMobile(
    appBar: AppBar(
      backgroundColor: AppColors.pureWhite,
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
          count: 1,
          child: const Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(Icons.notifications),
          ),
        ),
        const SizedBox(width: 20),
      ],
    ),
  ),
  SearchProductMobile(
    appBar: AppBar(
      backgroundColor: AppColors.pureWhite,
      centerTitle: true,
      title: const Text(
        "Discover Something New",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  const FavoritePageMobile(),
  const CartPageMobile(),
];
