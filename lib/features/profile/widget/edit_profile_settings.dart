import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20services/customer/customer_service.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/enums/gender_enum.dart';
import 'package:sadhana_cart/core/helper/file_picker_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_drop_down.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';
import 'package:sadhana_cart/core/widgets/loader.dart';

class EditProfileSettings extends ConsumerStatefulWidget {
  const EditProfileSettings({super.key});

  @override
  ConsumerState<EditProfileSettings> createState() =>
      _EditProfileSettingsState();
}

class _EditProfileSettingsState extends ConsumerState<EditProfileSettings> {
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer(
          builder: (context, ref, child) {
            final loader = ref.watch(loadingProvider);
            final image = ref.watch(profileImageProvider);
            return CustomElevatedButton(
              child: loader
                  ? const Loader()
                  : const Text("Save", style: customElevatedButtonTextStyle),
              onPressed: () async {
                final bool isSuccess =
                    await CustomerService.updateCustomerProfile(
                      context: context,
                      ref: ref,
                      contactNo: int.parse(phoneNumberController.text),
                      name: userNameController.text,
                      profileImage: image!,
                    );
                if (isSuccess && context.mounted) {
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
      ),
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
