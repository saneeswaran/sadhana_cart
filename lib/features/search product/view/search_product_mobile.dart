import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: widget.appBar,
      drawer: const Drawer(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchField(
                  controller: controller,
                  labelText: "Search",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
