import 'package:flutter/material.dart';

class CustomTileDropdown extends StatelessWidget {
  final String title;
  final Widget value;
  const CustomTileDropdown({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [value],
    );
  }
}
