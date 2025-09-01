import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            height: size.height * 0.1,
            width: size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Slidable(
              closeOnScroll: true,
              direction: Axis.horizontal,
              endActionPane: ActionPane(
                dragDismissible: true,
                closeThreshold: 0.5,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    icon: Icons.delete,
                    label: "Delete",
                    backgroundColor: AppColors.onboardButtonColor,
                    borderRadius: BorderRadius.circular(12),
                    autoClose: true,
                    onPressed: (context) {},
                  ),
                ],
              ),
              child: const ListTile(
                title: Text(
                  "Notification Title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  "Notification subtitle",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                leading: Icon(
                  Icons.notifications,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
