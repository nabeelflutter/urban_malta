import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/account/withdrow.dart';

import '../../components/AppColors.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController countryController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController bicController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the form key here
    countryController.text = '';
    ibanController.text = '';
    bicController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: Container(
      //     padding: EdgeInsets.only(left: 20, top: 20),
      //     child: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back_ios,
      //         color: Color(0xff161D35),
      //         // size: 24,
      //       ),
      //     ),
      //   ),
      //   title: Container(
      //     padding: EdgeInsets.only(top: 20),
      //     child: const Text(
      //       ' Account Details',
      //       style: TextStyle(
      //         fontSize: 28,
      //         fontWeight: FontWeight.w700,
      //         color: Color(0xff161D35),
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Account Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(onPressed: (){
         Navigator.of(context).popUntil((route) => route.isFirst);
        }, icon: const Icon(Icons.arrow_back_ios,color: AppColors.iconColor,))
      ),
      body: Form(
        key: _formKey, // Step 2: Provide the _formKey to the Form widget
        child: KeyboardVisibilityBuilder(
          builder: (context,isVisible) {
            final maxWidth = MediaQuery.of(context).size.width;
            final textFieldWidth =
             maxWidth -40;
            return Padding(
              padding:  EdgeInsets.only( left: 20,bottom:isVisible?MediaQuery.of(context).viewInsets.bottom+350:0 ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    buildTextField(
                        controller: countryController,
                        hintText: "Country of recipient’s bank",
                        width: textFieldWidth,
                        isRequired: true),
                    const SizedBox(height: 25),
                    buildTextField(
                        controller: ibanController,
                        hintText: "IBAN",
                        width: textFieldWidth,
                        isRequired: true),
                    const SizedBox(height: 25),
                    buildTextField(
                      controller: bicController,
                      hintText: "BIC | SWIFT",
                      width: textFieldWidth,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Optional',
                      style: TextStyle(color: Color(0xff7B7D83)),
                    ),
                    const SizedBox(height: 8),
                    buildTextField(
                        controller: firstNameController,
                        hintText: "First and middle name",
                        width: textFieldWidth,
                        isRequired: true),
                    const SizedBox(height: 25),
                    buildTextField(
                        controller: lastNameController,
                        hintText: "Last Name",
                        width: textFieldWidth,
                        isRequired: true),
                    const SizedBox(height: 25),
                    buildTextField(
                      controller: emailController,
                      hintText: "Email",
                      width: textFieldWidth,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Optional',
                        style: TextStyle(color: Color(0xff7B7D83)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 55,
                      width: textFieldWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey!.currentState!.validate()) {
                            // If form is valid, send the POST request
                            sendPostRequest();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return WithDraw();
                                }));
                          }
                        },
                        child: const Text(
                          'ADD',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  // Function to send the POST request with bearer token
  void sendPostRequest() async {
    final String token =
        StorageManager().accessToken; // Replace with your bearer token
    final int userId = StorageManager().userId;
    final String url = Constants.BASE_URL +
        "/api/bank/create"; // Replace with your endpoint URL

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    //1021|t98dBlZkbref3gA92cQzTvFlOeKxz19F08qoNwT6

    Map<String, dynamic> body = {
      "user_id": userId,
      "country": countryController.text,
      "iban": ibanController.text,
      "bic_swift": bicController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
    };

    try {
      print(body);
      var response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        // Successful POST request, handle response here
        print("Post Request Successful");
        print(response.body);

        // Show success message in an alert dialog
        final responseData = json.decode(response.body);
        final message = responseData['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.push(context,
                  //                   MaterialPageRoute(builder: (context) {
                  //                 return WithDraw();
                  //               }));
                  // // Pop the alert dialog and navigate back to the previous screen
                  // Navigator.of(context).pop();
                  // Navigator.of(context)
                  //     .pop(); // Assuming this screen is the previous one in the navigation stack
                },
                child: Text('OK'),
              ),
            ],
          ),
        );

        // Reset the form after a successful request
        _formKey.currentState?.reset();
      } else {
        // Handle other status codes or errors
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Reset the loading state to false to enable the button again
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to check if an email is valid using regular expressions
  bool isEmailValid(String email) {
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required double width,
    bool isRequired = false,
    bool isEmail = false,
    bool showError =
        false, // Add a new optional parameter to control error visibility
    String?
        errorText, // Add a new optional parameter to display custom error message
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
            color: const Color(0xfffbfbfb),
            border: Border.all(width: 1, color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return "This field is required.";
              }

              if (isEmail && value != null && value.isNotEmpty) {
                if (!isEmailValid(value)) {
                  return "Please enter a valid email address.";
                }
              }

              // Add other custom validations here if needed
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xff7B7D83),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        if (showError &&
            errorText !=
                null) // Show error only when showError is true and errorText is not null
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 4),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
