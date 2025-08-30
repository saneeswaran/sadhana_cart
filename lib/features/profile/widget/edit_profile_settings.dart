import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';

class EditProfileSettings extends StatefulWidget {
  const EditProfileSettings({super.key});

  @override
  State<EditProfileSettings> createState() => _EditProfileSettingsState();
}

class _EditProfileSettingsState extends State<EditProfileSettings> {
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: const CachedNetworkImageProvider(
                  AppImages.noProfile,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      shadowColor: Colors.grey.shade300,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                controller: userNameController,
                labelText: "Username",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
