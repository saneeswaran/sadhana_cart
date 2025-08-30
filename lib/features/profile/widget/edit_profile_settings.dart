import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/enums/gender_enum.dart';
import 'package:sadhana_cart/core/helper/file_picker_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_drop_down.dart';
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
              child: Consumer(
                builder: (context, ref, child) {
                  final image = ref.watch(profileImageProvider);
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: image != null && image.path.isNotEmpty
                        ? FileImage(image)
                        : const CachedNetworkImageProvider(AppImages.noProfile),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 1,
                          shadowColor: Colors.grey.shade300,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () async {
                          final pickedFile = await FilePickerHelper.pickImage();
                          if (pickedFile != null) {
                            ref.read(profileImageProvider.notifier).state =
                                pickedFile;
                          }
                        },
                        icon: Icon(
                          image != null && image.path.isNotEmpty
                              ? Icons.edit
                              : Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                controller: phoneNumberController,
                labelText: "Phone number",
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer(
                builder: (context, ref, child) {
                  final gender = ref.watch(genderProvider);
                  final items = GenderEnum.values
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.label)),
                      )
                      .toList();
                  return CustomDropDown(
                    labelText: "Select gender",
                    value: gender,
                    items: items,
                    onChanged: (gender) {
                      ref.read(genderProvider.notifier).state = gender;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
