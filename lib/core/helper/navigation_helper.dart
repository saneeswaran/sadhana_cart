import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/constants/category_constants.dart';
import 'package:sadhana_cart/core/ui_template/accessories/view/accessories_screen.dart';
import 'package:sadhana_cart/core/ui_template/clothing/view/clothing_products_details.dart';
import 'package:sadhana_cart/core/ui_template/other_product/view/other_product_details.dart';

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
}) {
  // final categoryLowerCase = categoryName.toLowerCase().replaceAll(' ', '_');

  final clothingList = CategoryConstants.clothingCategory;

  final isClothing = clothingList.any(
    (clothing) => categoryName.toLowerCase().contains(clothing.toLowerCase()),
  );

  final accessoryList = CategoryConstants.accessoriesKeywords;

  final isAccessories = accessoryList.any(
    (e) => categoryName.toLowerCase().contains(e.toLowerCase()),
  );

  if (isClothing) {
    navigateTo(
      context: context,
      screen: ClothingProductsDetails(product: product),
    );
  } else if (isAccessories) {
    navigateTo(
      context: context,
      screen: AccessoriesScreen(product: product),
    );
  } else {
    navigateTo(
      context: context,
      screen: OtherProductDetails(product: product),
    );
  }
  //  else if (categoryLowerCase == CategoryConstants.footwear.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.fashion.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase ==
  //     CategoryConstants.personalCare.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.stationary.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.home.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.books.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.electronics.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.groceries.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryLowerCase == CategoryConstants.cosmetics.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // } else if (categoryName == CategoryConstants.photoFrame.toLowerCase()) {
  //   navigateTo(
  //     context: context,
  //     screen: AccessoriesScreen(product: product),
  //   );
  // }
  /*

else if (categoryLowerCase.toLowerCase() ==
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
  } else if (categoryName.toLowerCase() ==
      CategoryConstants.accessories.toLowerCase()) {
    navigateTo(
      context: context,
      screen: AccessoriesScreen(product: product),
    );
  } else if (categoryName.toLowerCase() ==
      CategoryConstants.personalCare.toLowerCase()) {
    navigateTo(
      context: context,
      screen: PersonalCarePage(product: product),
    );
  }

  */
}
