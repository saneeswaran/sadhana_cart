import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SavedAddressPage extends ConsumerWidget {
  const SavedAddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final addressList = ref.watch(addressprovider);
    Future.microtask(() {
      ref.read(addressprovider.notifier).updateAddress();
    });

    if (addressList.isEmpty) {
      return Skeletonizer(
        child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              height: size.height * 0.15,
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.home, size: 40),
                    title: Text("This is for address"),
                    subtitle: Text("This is for city"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "address.streetName",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
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
        ),
      );
    }
    Future.delayed(const Duration(seconds: 10), () {
      if (addressList.isEmpty) {
        return const Center(child: Text("No address found"));
      }
    });
    return ListView.builder(
      itemCount: addressList.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final address = addressList[index];
        final icons = IconData(address.icon, fontFamily: 'MaterialIcons');
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          height: size.height * 0.15,
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  address.streetName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
  }
}
