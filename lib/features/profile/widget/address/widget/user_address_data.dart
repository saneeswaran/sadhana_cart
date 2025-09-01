import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/widgets/custom_text_button.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';

class UserAddressData extends ConsumerWidget {
  const UserAddressData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresAsyncData = ref.watch(addressAsync);
    final Size size = MediaQuery.of(context).size;
    return addresAsyncData.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final address = data[index];
            final icons = IconData(address.icon, fontFamily: 'MaterialIcons');
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              height: size.height * 0.2,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(icons, size: 40),
                    title: Text(address.title),
                    subtitle: Text(address.city),
                    trailing: CustomTextButton(text: "Edit", onPressed: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      address.streetName,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () {
        return const ListTile();
      },
    );
  }
}
