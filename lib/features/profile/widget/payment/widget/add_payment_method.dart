import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Add Money to Wallet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final cardType = ref.watch(creditCardTypeProvider);
                final cardImage = ref.watch(creditCardImageProvider);
                return CreditCardWidget(
                  enableFloatingCard: false,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: '',
                  cardType: cardType,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange: (CreditCardBrand _) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: cardType,
                      cardImage: Image.asset(cardImage, height: 48, width: 48),
                    ),
                  ],
                );
              },
            ),

            CreditCardForm(
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              formKey: formKey,
              onCreditCardModelChange: onCreditCardModelChange,
              inputConfiguration: const InputConfiguration(
                cardNumberDecoration: InputDecoration(
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: InputDecoration(
                  labelText: 'Expired Date',
                  hintText: 'MM/YY',
                ),
                cvvCodeDecoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(labelText: 'Card Holder'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(height: size.height * 0.2),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 1,
              child: null,
              // child: Consumer(builder: (context, ref, child){
              //   return CustomElevatedButton(
              //       onPressed: () async {
              //         final bool isSuccess = await provider.addCreditCard(
              //           driverId: 'driver1',
              //           cardid: '1',
              //           maskedNumber: cardNumber,
              //           expiryDate: expiryDate,
              //           cardHolderName: cardHolderName,
              //           paymentToken: 'token1',
              //           cardBrand: uiController.selectedCardbrand.toString(),
              //           last4Digits: cvvCode,
              //           context: context,
              //         );
              //         if (isSuccess && context.mounted) {
              //           successSnackBar(
              //             message: 'Credit Card Added Successfully',
              //             context: context,
              //           );
              //           Navigator.pop(context);
              //         }
              //       },
              //       child: isLoading
              //           ? const Loader()
              //           : const Text(
              //               "Add Your Credit Card",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //     );
              // })
            ),
          ],
        ),
      ),
    );
  }
}
