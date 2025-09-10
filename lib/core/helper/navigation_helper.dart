import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/constants/category_constants.dart';
import 'package:sadhana_cart/core/ui_template/category_list_page.dart';
import 'package:sadhana_cart/core/ui_template/foot_wear/view/foot_wear_design.dart';
import 'package:sadhana_cart/core/ui_template/head%20phones/view/head_phone_template.dart';
import 'package:sadhana_cart/core/ui_template/laptop/view/laptop_template.dart';
import 'package:sadhana_cart/core/ui_template/mobile/view/mobile_template.dart';
import 'package:sadhana_cart/core/ui_template/clothing/view/clothing_products_details.dart';

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateBack({required BuildContext context}) {
  Navigator.pop(context);
}

void navigateToReplacement({
  required BuildContext context,
  required Widget screen,
}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void navigateToProductDesignBasedOnCategory({
  required BuildContext context,
  required String categoryName,
  required ProductModel product,
  required List<ProductModel> products,
}) {
  final categoryLowerCase = categoryName.toLowerCase().replaceAll(' ', '_');

  if (categoryLowerCase == CategoryConstants.electronics.toLowerCase()) {
    navigateTo(
      context: context,
      screen: CategoryListPage(
        title: CategoryConstants.electronics,
        products: products,
      ),
    );
  } else if (categoryLowerCase == CategoryConstants.books.toLowerCase()) {
    navigateTo(
      context: context,
      screen: CategoryListPage(
        title: CategoryConstants.books,
        products: products,
      ),
    );
  } else if (categoryLowerCase == CategoryConstants.home.toLowerCase()) {
    navigateTo(
      context: context,
      screen: CategoryListPage(
        title: CategoryConstants.home,
        products: products,
      ),
    );
  } else if (categoryLowerCase == CategoryConstants.accessories.toLowerCase()) {
    navigateTo(
      context: context,
      screen: CategoryListPage(
        title: CategoryConstants.accessories,
        products: products,
      ),
    );
  } else {
    // default fallback
    navigateTo(
      context: context,
      screen: CategoryListPage(title: categoryName, products: products),
    );
  }

  /*

  if (categoryLowerCase == CategoryConstants.clothing.toLowerCase()) {
    navigateTo(
      context: context,
      screen: ClothingProductsDetails(product: product),
    );
  } else if (categoryName == CategoryConstants.footwear.toLowerCase()) {
    navigateTo(
      context: context,
      screen: FootWearDesign(product: product),
    );
  } else if (categoryLowerCase.toLowerCase() ==
      CategoryConstants.mobile.toLowerCase()) {
    navigateTo(
      context: context,
      screen: MobileTemplate(product: product),
    );
  } else if (categoryLowerCase.toLowerCase() ==
      CategoryConstants.laptop.toLowerCase()) {
    navigateTo(
      context: context,
      screen: LaptopTemplate(product: product),
    );
  } else if (categoryLowerCase == CategoryConstants.headphone.toLowerCase()) {
    log('Category tapped: $categoryLowerCase');
    navigateTo(
      context: context,
      screen: HeadPhoneTemplate(product: product),
    );
  } 
  */
}
