import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static const String id = "payment_screen";
  final int amount = 0;
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Razorpay _razorpay = Razorpay();
  String currentString = '';
  num currentNum = 0;

  void openCheckout() {
    //For now options is hardcoded
    //lataer on it will take values for many parameters from actual donation requester data and donor data
    var options = {
      'key': 'rzp_test_zESrJgJgccb3qt', //key ID
      'amount': currentNum * 100,
      //RazorPay deals with paise
      //If user entered 3 it is '3 paise' for razor pay
      //Hence we need to multiply by 100 to get rupee equivalent
      'name': 'Unknown NGO', //name of receiver
      'description': 'Donation to some cause',
      'currency': 'INR',
      'wallet': 'paytm',
      'prefill': {
        'contact': '8888888888',
        'email': 'sample@sample.com',
      }
      //done - all parameters : https://razorpay.com/docs/payments/payment-gateway/flutter-integration/standard/build-integration/#17-add-checkout-options

      //done - see what all parameters are useful to you
      //done - use those paremeters
    };

    _razorpay.open(options);
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  //understand PaymentSuccessResponse object so that you can use its parameters properly
  //understand PaymentFailureResponse object so that you can use its parameters properly
  //understand ExternalWalletResponse object so that you can use its parameters properly

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //TODO: 4. Do something when payment succeeds, show a widget of confirmation and re-direct to Thank You screen
    print(
        'Order ID : ${response.orderId} \nPayment ID : ${response.paymentId} \nSignature: ${response.signature}');
    //order ID : null | Payment ID : somevlaue | Signature: null
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //TODO: 5. Do something when payment fail, show a widget of confirmation and re-direct to some error information screen(to be createad)

    print(
        'Error Code : ${response.code} \nError Message : ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //TODO: 6. Do something when an external wallet was selected, at least print data of wallet
    print('External Wallet : ${response.walletName}');
  }

  //TODO: 7. Add exception handling
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Amount Verification',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
              child: TextField(
            decoration: InputDecoration(
                hintText: "Enter Amount For Donation",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onChanged: (typedAmount) {
              currentString = typedAmount;
              print(currentString);
              try {
                currentNum = num.parse(currentString);
                if (currentNum >= 0 && currentNum <= kMaxAmountAllowed) {
                  //proper input
                  //add payment feature by watching that video
                } else {
                  //improper input
                  print('Improper Input :  $currentNum');
                }
              } catch (e) {
                print('Error Message is given here : $e');
              }
            },
          )),
          ActionButton(
            buttonText: 'Fund',
            buttonActionCallback: () {
              openCheckout();
            },
            verticalPadding: 0.0,
            horizontalPadding: 0.0,
            buttonColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
    print('razor pay is cleaerd ');
  }
}
