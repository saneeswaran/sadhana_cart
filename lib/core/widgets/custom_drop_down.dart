import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  const CustomDropDown({super.key, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(items: items, onChanged: onChanged);
  }
}
