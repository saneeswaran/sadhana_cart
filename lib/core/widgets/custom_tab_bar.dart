import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;

  const CustomTabBar({
    super.key,
    required this.tabTitles,
    required this.tabViews,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Custom Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            tabs: widget.tabTitles.map((title) => Tab(text: title)).toList(),
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}
