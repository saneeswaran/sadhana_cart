import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int length;
  final List<Widget> tabs;
  final double tabBarViewHeight;
  final List<Widget> tabBarViewChildren;
  const CustomTabBar({
    super.key,
    required this.length,
    required this.tabs,
    required this.tabBarViewHeight,
    required this.tabBarViewChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: length,
          child: TabBar(tabs: tabs),
        ),
        SizedBox(
          height: tabBarViewHeight,
          child: TabBarView(children: tabBarViewChildren),
        ),
      ],
    );
  }
}
