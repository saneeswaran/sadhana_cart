import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';

class UserAddressData extends StatelessWidget {
  final AddressModel address;
  const UserAddressData({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(12),
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
        children: [
          const ListTile(
            leading: Icon(Icons.dangerous),
            title: Text(
              "Send To",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "Address",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(address.streetName),
        ],
      ),
    );
  }
}
