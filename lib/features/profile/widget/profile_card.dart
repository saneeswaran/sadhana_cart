import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
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
      child: Row(
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width * 0.3,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text("Name"),
              subtitle: const Text("Email"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
