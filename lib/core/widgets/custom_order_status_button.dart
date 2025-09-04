import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';
import 'package:sadhana_cart/core/helper/string_helper.dart';

class CustomOrderStatusButton extends StatelessWidget {
  final int index;
  const CustomOrderStatusButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final selectedIndex = ref.watch(orderStatusIndexProvider);
        final selected = index == selectedIndex;
        final items = OrderStatusEnums.values[index].name;
        final text = StringHelper.firstLetterCapital(input: items);
        return GestureDetector(
          onTap: () =>
              ref.read(orderStatusIndexProvider.notifier).state = index,
          child: Container(
            margin: const EdgeInsets.all(12),
            height: size.height * 0.07,
            width: size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selected ? AppColors.orderStatusColor : Colors.white,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
