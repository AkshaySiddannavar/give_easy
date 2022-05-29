import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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
  String errorToastMessage = '';
  bool isFundButtonActive = true;
  String donationAmountGuidelines =
      'Guidelines for donation amount:\n\n1.Should be number only\n\n2.Should be more than 0\n\n3.Should be less than $kMaxAmountAllowed\n\nNote: Fund button won\'t be activated if guidelines are not followed';
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

  //done - understand PaymentSuccessResponse object so that you can use its parameters properly
  //done - understand PaymentFailureResponse object so that you can use its parameters properly
  //done - understand ExternalWalletResponse object so that you can use its parameters properly

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //Do something when payment succeeds, show a widget of confirmation and/or re-direct to Thank You screen
    print(
        'Order ID : ${response.orderId} \nPayment ID : ${response.paymentId} \nSignature: ${response.signature}');
    //order ID : null | Payment ID : somevlaue | Signature: null
    Navigator.pushNamed(context, ThankYouScreen.id);
    showToast(
      'Payment Successful ✅',
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: Colors.greenAccent,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //Do something when payment fail, show a widget of confirmation and/or re-direct to some error information screen(to be created)

    print(
        'Error Code : ${response.code} \nError Message : ${response.message}');

    //depending upon error codes you have to decide whether to show a toast or to go to some error screen
    if (response.message ==
        'Invalid amount (should be passed in integer paise. Minimum value is 100 paise, i.e. ₹ 1)') {
      errorToastMessage =
          'Invalid amount\n1.Enter Amount In Rupees\n2.Enter A Valid Number more than 0';
    } else if (response.message ==
        '{"error":{"code":"BAD_REQUEST_ERROR","description":"Payment processing cancelled by user","source":"customer","step":"payment_authentication","reason":"payment_cancelled"}}') {
      errorToastMessage = 'Payment Cancelled By You';
    } else if (response.message == '{"description":"Network error"}') {
      errorToastMessage =
          'Network Issues\nPlease Connect To Internet\nor\nPlease check your network connection';
    } else if (response.message == '{"description":"Network error"}') {
      errorToastMessage =
          'Network Issues\nPlease Connect To Internet\nor\nPlease check your network connection';
    } else {
      errorToastMessage =
          'Error Occurred ☹️\n\nError Message : ${response.message}';
    }
    showToast(
      errorToastMessage,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 5),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: Colors.redAccent,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //Do something when an external wallet was selected, at least print data of wallet
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
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: SizedBox(
              height: 30.0,
            ),
          ),
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
                currentNum = num.parse(
                    currentString); //converting string input into number
                if (currentNum > 0 && currentNum <= kMaxAmountAllowed) {
                  //proper input
                  isFundButtonActive = true;
                  setState(() {});
                } else {
                  //improper input
                  //show toast directly or call a function which will show toast and disable payment button
                  isFundButtonActive = false;
                  setState(() {});
                  print('Improper Input :  $currentNum');
                }
              } catch (e) {
                //show toast directly or call a function which will show toast
                isFundButtonActive = false;
                setState(() {});

                print('Error Message is given here : $e');
              }
            },
          )),
          Flexible(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          Text(
            donationAmountGuidelines,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.left,
          ),
          Flexible(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          Text(
            'Your donation will be used to futher the cause that matters to you ❤️',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: SizedBox(
              height: 20.0,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Center(
              child: ActionButton(
                buttonText: 'Fund',
                buttonActionCallback: () {
                  openCheckout();
                },
                verticalPadding: 0.0,
                horizontalPadding: 0.0,
                buttonColor: Colors.greenAccent,
                isActive: isFundButtonActive,
              ),
            ),
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
