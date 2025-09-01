import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final streetNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    streetNameController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Address here",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 20,
              children: [
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: nameController,
                  labelText: "Name",
                ),
                CustomTextFormField(
                  controller: streetNameController,
                  labelText: "Street Name",
                ),
                CustomTextFormField(
                  controller: cityController,
                  labelText: "City",
                ),
                CustomTextFormField(
                  controller: stateController,
                  labelText: "State",
                ),
                CustomTextFormField(
                  controller: zipCodeController,
                  labelText: "Zip Code",
                ),
                CustomTextFormField(
                  controller: phoneNumberController,
                  labelText: "Phone Number",
                ),

                const SizedBox(height: 30),
                CustomElevatedButton(
                  child: const Text(
                    "Get Current Location",
                    style: customElevatedButtonTextStyle,
                  ),
                  onPressed: () {},
                ),
                CustomElevatedButton(
                  child: const Text(
                    "Save",
                    style: customElevatedButtonTextStyle,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
