import 'package:sadhana_cart/core/common%20model/banner/banner_model.dart';

class AppImages {
  //images
  static const String onboard = "assets/images/onboard.png";
  static const String onboard1 = "assets/images/onboard1.png";
  static const String onboard2 = "assets/images/onboard2.png";
  static const String onboard3 = "assets/images/onboard3.png";

  //order status
  static const String orderCompleted = "assets/order/order_completed.png";
  static const String orderPending = "assets/order/order_pending.png";
  static const String orderProcessing = "assets/order/order_processing.png";
  static const String orderShipped = "assets/order/order_shipped.png";
  static const String orderDelivered = "assets/order/order-delivered.png";
  static const String orderCanceled = "assets/order/order_canceled.png";

  //vectors
  static const String googleSvg = "assets/vectors/google.svg";
  static const String appleSvg = "assets/vectors/apple.svg";

  //icons
  static const String drawerIcons = "assets/icons/drawer.png";

  //testing purpose only
  static const String carousel = "assets/images/carousel.png";

  static const String noProfile = "assets/images/noprofile.jpg";

  static List<BannerModel> bannerImages = [
    BannerModel(
      bannerId: "1",
      bannerName: "banner1",
      bannerImage: carousel,
      productId: "1",
    ),
    BannerModel(
      bannerId: "2",
      bannerName: "banner1",
      bannerImage: carousel,
      productId: "2",
    ),
    BannerModel(
      bannerId: "2",
      bannerName: "banner1",
      bannerImage: carousel,
      productId: "2",
    ),
  ];
}
