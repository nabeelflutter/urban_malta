/////////////////////////////
///

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/main.dart';
import 'package:local_auth/local_auth.dart';

import '../../components/AppColors.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  bool _showPrefixIcon = false;
  String intentId = '';
  bool isFinished = false;
  int selectedButtonIndex = -1;
  TextEditingController textEditingController = TextEditingController();

  bool isTextFieldEmpty() {
    return textEditingController.text.isEmpty;
  }

  String currencySymbol = "€";
  bool isValueSelectedFromButtons = false;

  bool? _hasBioSensor;

  LocalAuthentication authentication = LocalAuthentication();

  Future<void> _checkBio() async {
    try {
      _hasBioSensor = await authentication.canCheckBiometrics;
      print(_hasBioSensor);
      if (_hasBioSensor!) {
        _getAuth();
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAuth() async {
    bool isAuth = false;
    try {
      isAuth = await authentication.authenticate(
          localizedReason: 'Scan your fingerprint to access the app',
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true));
      if (isAuth) {
        print(textEditingController.text);
        String amount = textEditingController.text.split(" ").last;
        print(amount);

        String am = (int.parse(amount) * 100).toString();

        await makepayment(amount: am);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.iconColor,
            )),
        title: const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "Top Up",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: KeyboardVisibilityBuilder(
          builder: (p0, isKeyboardVisible) => Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 40,
                bottom: isKeyboardVisible
                    ? MediaQuery.of(context).size.height * .28
                    : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Select Nomina",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  children: [
                    buildNominalButton(0, "€ 10", "assets/images/j5.png"),
                    buildNominalButton(1, "€ 25", "assets/images/j6.png"),
                    buildNominalButton(2, "€ 50", "assets/images/j7.png"),
                    buildNominalButton(3, "€ 75", "assets/images/j8.png"),
                    buildNominalButton(4, "€ 100", "assets/images/j9.png"),
                    buildNominalButton(5, "€ 125", "assets/images/j9.png"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Or input nominal top up here",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6B769B),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {
                        _showPrefixIcon = value.isNotEmpty;
                        // if (value.isNotEmpty) {
                        //   currencySymbol = "€";
                        // } else {
                        //   currencySymbol = "";
                        // }

                        int newIndex = -1;
                        for (int i = 0; i < nominalValues.length; i++) {
                          if (value == nominalValues[i]) {
                            newIndex = i;
                            break;
                          }
                        }

                        selectedButtonIndex = newIndex;
                      });
                    },
                    onTap: () {
                      // textEditingController.clear();
                      textEditingController.clear();
                      setState(() {
                        selectedButtonIndex = -1;
                      });
                    },
                    decoration: InputDecoration(
                      prefix: Text(
                        '€',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000),
                        ),
                      ),
                      suffixIcon: _showPrefixIcon
                          ? IconButton(
                              onPressed: () {
                                textEditingController.clear();
                                setState(() {
                                  // currencySymbol = "";
                                  selectedButtonIndex = -1;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                      hintText: "Minimal €10",
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8E98BD),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: isKeyboardVisible ? 20 : 150,
                ),
                // Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff4995EB),
                    ),
                    // onPressed: () {
                    //   _checkBio();
                    // },
                    onPressed: () async {
                      if (!isTextFieldEmpty()) {
                        try {
                          _checkBio();
                        } catch (e) {
                          // Handle any errors here
                          print('Error occurred: $e');
                        }
                      }
                    },
                    // async {
                    //   print(textEditingController.text);
                    //   String amount = textEditingController.text.split(" ").last;
                    //   print(amount);

                    //   String am = (int.parse(amount) * 100).toString();

                    //   await makepayment(amount: am);
                    // },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNominalButton(int index, String amount, String imagePath) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final buttonWidth = (screenWidth - 60) / 3;
    final buttonWidth = screenWidth * 0.28;
    return SizedBox(
      height: buttonWidth,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1,
            color: selectedButtonIndex == index ? Colors.red : Colors.white,
          ),
          backgroundColor: selectedButtonIndex == index
              ? const Color(0xfffeeeee)
              : Colors.white,
          shadowColor: Colors.grey.withOpacity(0.2),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
            print(amount);
            textEditingController.text = amount.substring(2);
          });
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              SizedBox(
                  height: buttonWidth * 0.45,
                  width: buttonWidth * 0.45,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<String> nominalValues = [
    "€ 10",
    "€ 25",
    "€ 50",
    "€ 75",
    "€ 100",
    "€ 125",
  ];
  String apiAmount = "";

  // Stripe payment///

  Map<String, dynamic>? paymentIntentData;

  Future<void> makepayment({
    required String amount,
  }) async {
    try {
      paymentIntentData = await createPaymentIntentBackend(amount: amount);
      print("********************************");
      print(paymentIntentData!["client_secret"].runtimeType);
      print(paymentIntentData!["client_secret"]);
      // var gpay = const PaymentSheetGooglePay(
      //   merchantCountryCode: "GB",
      //   currencyCode: "GBP",
      //   testEnv: true,
      // );

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "UrbanMalta",
      ));
      displayPaymentsheet();
    } catch (e, s) {
      print(
        "EXCAPTION ===  $e$s",
      );
    }
  }

//  'amount': calculateAmount(amount),
//         'currency': currency,
  createPaymentIntent({
    required String amount,
  }) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': "EUR",
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                "Bearer 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",
            'Content-Type': 'application/x-www-form-urlencoded',
          });
      // farooq        // "Bearer sk_test_51NXrWpIT6hf4mQbFZ2xQoc8lVezl3faQb7V8uyOVwI2ER1TuFbtyTixXyOwC4r0WyhRmLFow8xoZUIMv7VPJ51vz00KpDigmFV",

      // "Bearer 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",
      var decoded = json.decode(response.body);
      print(decoded);
      print(decoded["amount"]);
      apiAmount = decoded["amount"].toString();
      return jsonDecode(response.body);
    } catch (err) {
      print("err charging user  $err");
    }
  }

  createPaymentIntentBackend({
    required String amount,
  }) async {
    try {
      final body = {
        'amount': amount,
        'currency': "EUR",
        'user_id': StorageManager().userId.toString()
      };
      final token = StorageManager().accessToken;

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final jsonBody = json.encode(body);

      var response = await http.post(
        Uri.parse('https://urbanmalta.com/api/wallet/paymentintent'),
        headers: headers,
        body: jsonBody,
      );
      // farooq        // "Bearer sk_test_51NXrWpIT6hf4mQbFZ2xQoc8lVezl3faQb7V8uyOVwI2ER1TuFbtyTixXyOwC4r0WyhRmLFow8xoZUIMv7VPJ51vz00KpDigmFV",

      // "Bearer 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",
      var decoded = json.decode(response.body);
      print(decoded);
      print(decoded["amount"]);
      apiAmount = decoded["amount"].toString();
      setState(() {
        intentId = decoded["id"];
      });
      return decoded;
    } catch (err) {
      print("err charging user  $err");
    }
  }

  void displayPaymentsheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print("*********************)(*******************)");
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(
              const Duration(seconds: 2),
              () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const InitialScreen();
                }));
              },
            );
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            );
          },
        );

        String amountToSend = (int.parse(apiAmount) / 100).toString();
        await topUpAPI(amounts: amountToSend);
      });
    } catch (e) {
      print("error = $e");
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(
            const Duration(seconds: 2),
            () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InitialScreen();
              }));
            },
          );
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 100.0,
                ),
                SizedBox(height: 10.0),
                Text("Payment Unsuccessful!"),
              ],
            ),
          );
        },
      );
      print("excaption === $e");
    }
  }

  topUpAPI({
    required String amounts,
  }) async {
    const url = '${Constants.BASE_URL}/api/wallet/topup';
    final token = StorageManager().accessToken;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': StorageManager().userId,
      'amount': amounts,
      'intentid': intentId,
    };

    print("payload : $body ");

    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      var decoded = json.decode(response.body);
      print("+++++++++++++++++++++++topup api+++++++++++++++++++++++");
      print(decoded);
      print("+++++++++++++++++++++++topup api+++++++++++++++++++++++");
    } catch (error) {
      topUpAPI(amounts: amounts);
      print(error);
      throw Exception('Failed to fetch data');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
