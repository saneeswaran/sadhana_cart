import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/widgets/custom_search_field.dart';

class SearchProductMobile extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  const SearchProductMobile({super.key, this.appBar});

  @override
  State<SearchProductMobile> createState() => _SearchProductMobileState();
}

class _SearchProductMobileState extends State<SearchProductMobile> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: widget.appBar,
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    controller: controller,
                    backgroundColor: AppColors.pureWhite,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
