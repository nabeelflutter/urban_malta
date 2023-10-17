import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/Language.dart';
import 'package:kappu/screens/gig/Create_first_gig.dart';
import 'package:kappu/screens/location/choose_location_screen.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';
import 'package:kappu/screens/register/widgets/text_field2.dart';
import 'package:validators/validators.dart';

import '../../constants/icons.dart';
import '../../net/http_client.dart';
import '../privacy_policy/privacy.dart';

class SignUp extends StatefulWidget {
  final bool isprovider;

  const SignUp(
      {Key? key,
      required this.isprovider,
      this.loginType = '',
      this.socialId = '',
      this.name = '',
      this.email = ''})
      : super(key: key);
  final String loginType;
  final String socialId;
  final String name;
  final String email;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  Future<String> checkUser({required String email}) async {
    final url = Uri.parse('https://urbanmalta.com/api/user/checkemail');
    final body = {
      'email': email.toString(),
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      print('response success');
      final jsonData = jsonDecode(response.body);
      // print('Printing json data  ${jsonData['message'].toString()}${jsonData['data'] == []}' );
      return '${jsonData['message']}';
    }

    return 'Please check your internet connection and try again later';
  }

  String email = '';
  String password = '';
  String checkPassword = '';
  bool loading = false;
  bool _showPassword = true;
  bool _showCheckPassword = true;
  bool? isLockedIn = false;
  String passwordStrength = '';
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  final _formState = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  // final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _phnocontroller = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addresscontoller = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  bool isVaildFirstName = true;
  bool isVaildLastName = true;
  bool isVaildEmail = true;
  bool isVaildPhone = true;
  bool isVaildAge = true;
  bool isVaildNati = true;
  bool isVaildPassword = true;
  bool isVaildConfirm = true;

  /*List<Language> languages = [
    Language(id: -1, name: 'English'),
    Language(id: -2, name: 'Maltese'),
    Language(id: -3, name: 'Italian'),
    Language(id: -4, name: 'Spanish'),
    Language(id: -5, name: 'French'),
    Language(id: -6, name: 'German'),
    Language(id: -7, name: 'Polish'),
    Language(id: -8, name: 'Arabic'),
    Language(id: -9, name: 'Dutch')
  ];*/

  // Category selectedcatagory =
  //     Category(id: -1, name: "Select a Service", createdAt: "");
  Language selectedLanguage = Language(id: -1, name: 'English');

  String vaidatePassword(String password) {
    if (password.contains(
        RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$'))) {
      return 'Strong';
    } else {
      return 'Weak';
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.iconColor,
            )),
        shadowColor: Colors.white,
        elevation: 0,
      ),
      body: KeyboardVisibilityBuilder(builder: (context, isVisible) {
        return SingleChildScrollView(
          child: Form(
            key: _formState,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 0.h),
              child: SizedBox(
                height: MediaQuery.of(context).size.height +
                    (isVisible
                        ? 140.h + MediaQuery.of(context).viewInsets.bottom
                        : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90.h,
                      child: Image.asset('assets/images/login_pageview1.png'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Text(
                      'Join urbanmalta',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Create an account and discover thousands of relevant services, connet with freelancers, and check out easily on Urban Malta trusted platform.",
                        style: TextStyle(
                          fontSize: 16,
                          // fontFamily: 'Montserrat-Regular',
                          color: AppColors.text_desc,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                    // Center(
                    //   child: Image.asset(
                    //     "assets/icons/logo.png",
                    //     height: 90.h,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // 30.verticalSpace,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextFormField(
                      controller: _nameController,
                      validator: (value) =>
                          value!.isEmpty ? "Enter Your Name" : null,
                      keyboardType: TextInputType.text,
                      prefixIcon: ImageIcon(
                        AssetImage('assets/icons/prf.png'),
                        color: AppColors.app_color,
                      ),
                      hintText: 'Name',
                      isValid: isVaildFirstName,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          isVaildFirstName = true;
                        } else {
                          isVaildFirstName = false;
                        }
                        setState(() {});
                      },
                    ),
                    // CustomTextFormField(
                    //   controller: _lastnameController,
                    //   validator: (value) =>
                    //   value!.isEmpty ? "Enter Your Name" : null,
                    //   keyboardType: TextInputType.text,
                    //   prefixIcon: profileIcon,
                    //   hintText: 'Last Name',
                    //   isValid: isVaildLastName,
                    //   onChanged: (value) {
                    //     if (value.isNotEmpty) {
                    //       isVaildLastName = true;
                    //     } else {
                    //       isVaildLastName = false;
                    //     }
                    //     setState(() {});
                    //   },
                    // ),
                    CustomTextFormField2(
                      controller: _emailController,
                      validator: (value) =>
                          isEmail(value!) ? null : "Check your email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const ImageIcon(
                        AssetImage('assets/icons/ft-4.png'),
                        color: AppColors.app_color,
                      ),
                      suffixIcon: isEmail(email) ? checkIcon : null,
                      hintText: 'Email',
                      isValid: isVaildEmail,
                      enabled: widget.socialId.isEmpty,
                      onChanged: (value) {
                        if (value.isNotEmpty && isEmail(value)) {
                          isVaildEmail = true;
                        } else {
                          isVaildEmail = false;
                        }
                        setState(() {});
                      },
                    ),
                    // CustomTextFormField(
                    //   controller: _phnocontroller,
                    //   hintText: 'Phone Number',
                    //   keyboardType: TextInputType.number,
                    //   prefixIcon: profileIcon,
                    //   isValid: isVaildPhone,
                    //   onChanged: (value) {
                    //     if (value.isNotEmpty && value.length == 10) {
                    //       isVaildPhone = true;
                    //     } else {
                    //       isVaildPhone = false;
                    //     }
                    //     setState(() {});
                    //   },
                    //   validator: (value) => value!.length != 10
                    //       ? "Phone Number should be 10 digit long"
                    //       : null,
                    // ),
                    // if (!widget.isprovider)
                    //   CustomTextFormField(
                    //     controller: _addresscontoller,
                    //     hintText: 'Address',
                    //     keyboardType: TextInputType.text,
                    //     onChanged: (value) {
                    //       setState(() {});
                    //     },
                    //     prefixIcon: const Icon(Icons.location_on),
                    //     validator: (value) =>
                    //     value!.isEmpty ? "Enter Your Address" : null,
                    //   ),

                    // if (widget.isprovider)
                    //   GestureDetector(
                    //     onTap: () async {
                    //       DateTime? pickedDate = await showDatePicker(
                    //           context: context,
                    //           initialDate: DateTime(DateTime.now().year - 19),
                    //           firstDate: DateTime(1950),
                    //           //DateTime.now() - not to allow to choose before today.
                    //           lastDate: DateTime(DateTime.now().year - 18));
                    //
                    //       if (pickedDate != null) {
                    //         print(
                    //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    //         String formattedDate =
                    //             DateFormat('dd/MM/yyyy').format(pickedDate);
                    //         print(
                    //             formattedDate); //formatted date output using intl package =>  2021-03-16
                    //         setState(() {
                    //           _ageController.text = formattedDate;
                    //           //set output date to TextField value.
                    //         });
                    //       } else {}
                    //     },
                    //     child: CustomTextFormField(
                    //       controller: _ageController,
                    //       hintText: 'Date of Birth (dd/mm/yyyy)',
                    //       readOnly: true,
                    //       enabled: false,
                    //       isValid: isVaildAge,
                    //       onChanged: (value) {
                    //         if (value.isNotEmpty) {
                    //           isVaildAge = true;
                    //         } else {
                    //           isVaildAge = false;
                    //         }
                    //         setState(() {});
                    //       },
                    //       keyboardType: TextInputType.datetime,
                    //       prefixIcon: const ImageIcon(
                    //         AssetImage('assets/icons/age_icon.png'),
                    //         color: AppColors.app_color,
                    //       ),
                    //       validator: (value) => null,
                    //       suffixIcon: GestureDetector(
                    //           onTap: () async {
                    //             DateTime? pickedDate = await showDatePicker(
                    //                 context: context,
                    //                 initialDate:
                    //                     DateTime(DateTime.now().year - 19),
                    //                 firstDate: DateTime(1950),
                    //                 //DateTime.now() - not to allow to choose before today.
                    //                 lastDate:
                    //                     DateTime(DateTime.now().year - 18));
                    //
                    //             if (pickedDate != null) {
                    //               print(
                    //                   pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    //               String formattedDate =
                    //                   DateFormat('dd/MM/yyyy')
                    //                       .format(pickedDate);
                    //               print(
                    //                   formattedDate); //formatted date output using intl package =>  2021-03-16
                    //               setState(() {
                    //                 _ageController.text = formattedDate;
                    //                 //set output date to TextField value.
                    //               });
                    //             } else {}
                    //           },
                    //           child: Icon(Icons.calendar_month)),
                    //     ),
                    //   ),

                    // InkWell(
                    //   onTap: () async {
                    //     DateTime selectedDate = DateTime.now();
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //           title: const Text('Select Date'),
                    //           content: TimePickerSpinnerPopUp(
                    //             mode: CupertinoDatePickerMode.date,
                    //             initTime: selectedDate ?? DateTime.now(),
                    //             barrierColor: Colors.black12,
                    //             pressType: PressType.singlePress,
                    //             timeFormat: 'dd/MM/yyyy',
                    //             onChange: (dateTime) {
                    //               String formattedDate =
                    //                   DateFormat('dd/MM/yyyy')
                    //                       .format(dateTime);
                    //               setState(() {
                    //                 selectedDate = dateTime;
                    //                 _ageController.text =
                    //                     formattedDate.toString();
                    //                 Navigator.pop(context);
                    //               });
                    //             },
                    //           ),
                    //         );
                    //       },
                    //     );

                    //     print('ssss');
                    //     /*DateTime? pickedDate = await showDatePicker(
                    //         context: context,
                    //         initialDate:
                    //             DateTime(DateTime.now().year - 18),
                    //         firstDate: DateTime(1950),
                    //         //DateTime.now() - not to allow to choose before today.
                    //         lastDate: DateTime(DateTime.now().year - 18));*/

                    //     /*if (pickedDate != null) {
                    //       print(
                    //           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    //       String formattedDate =
                    //           DateFormat('dd/MM/yyyy').format(pickedDate);
                    //       print(
                    //           formattedDate); //formatted date output using intl package =>  2021-03-16
                    //       setState(() {
                    //         _ageController.text = formattedDate;
                    //         //set output date to TextField value.
                    //       });
                    //     } else {}*/
                    //   },
                    //   child: CustomTextFormField(
                    //     controller: _ageController,
                    //     hintText: 'Date of Birth',
                    //     readOnly: true,
                    //     enabled: false,
                    //     isValid: isVaildAge,
                    //     onChanged: (value) {
                    //       if (value.isNotEmpty) {
                    //         isVaildAge = true;
                    //       } else {
                    //         isVaildAge = false;
                    //       }
                    //       setState(() {});
                    //     },
                    //     keyboardType: TextInputType.none,
                    //     prefixIcon: ImageIcon(
                    //       AssetImage('assets/icons/age_icon.png'),
                    //       color: AppColors.app_color,
                    //     ),
                    //     validator: (value) => null,
                    //   ),
                    // ),

                    //  if (widget.isprovider)
                    /*   CustomTextFormField(
                        controller: _nationalityController,
                        hintText: 'Nationality',
                        keyboardType: TextInputType.text,
                        prefixIcon: ImageIcon(
                          AssetImage('assets/icons/flag.png'),
                          color: AppColors.app_color,
                        ),
                        isValid: isVaildNati,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            isVaildNati = true;
                          } else {
                            isVaildNati = false;
                          }
                          setState(() {});
                        },
                        validator: (value) => value!.isEmpty
                            ? "Enter Your Nationality"
                            : null,
                          ),*/
                    // if (!widget.isprovider)
                    //   Padding(
                    //     padding: EdgeInsets.only(top: 10.h),
                    //     child: CSCPicker(
                    //       showStates: true,
                    //       showCities: true,
                    //       flagState: CountryFlag.DISABLE,
                    //       dropdownDecoration: BoxDecoration(
                    //           borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //           color: Colors.white,
                    //           border:
                    //           Border.all(color: Colors.grey, width: 1)),
                    //       disabledDropdownDecoration: BoxDecoration(
                    //           borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //           color: Colors.grey.shade300,
                    //           border: Border.all(
                    //               color: Colors.grey.shade300, width: 1)),
                    //       countrySearchPlaceholder: "Country",
                    //       stateSearchPlaceholder: "State",
                    //       citySearchPlaceholder: "City",
                    //       countryDropdownLabel: "Country",
                    //       stateDropdownLabel: "State",
                    //       cityDropdownLabel: "City",
                    //       defaultCountry: CscCountry.Malta,
                    //       selectedItemStyle: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: ScreenUtil().setSp(15),
                    //       ),
                    //       dropdownHeadingStyle: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: ScreenUtil().setSp(15),
                    //       ),
                    //       dropdownItemStyle: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: ScreenUtil().setSp(15),
                    //       ),
                    //       dropdownDialogRadius: 15.0,
                    //       searchBarRadius: 10.0,
                    //       onCountryChanged: (value) {
                    //         countryValue = value;
                    //         setState(() {});
                    //       },
                    //       onStateChanged: (value) {
                    //         if (value != null) {
                    //           stateValue = value;
                    //         }
                    //         setState(() {});
                    //       },
                    //       onCityChanged: (value) {
                    //         if (value != null) {
                    //           cityValue = value;
                    //         }
                    //         setState(() {});
                    //       },
                    //     ),
                    //   ),

                    // 10.verticalSpace,
                    if (widget.isprovider)
                      Material(
                          borderRadius: BorderRadius.circular(
                              ScreenUtil().screenHeight * 0.03),
                          elevation: 3,
                          shadowColor: Colors.black.withOpacity(0.14),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*  SizedBox(
                                height: ScreenUtil().setHeight(40),
                                width: MediaQuery.of(context).size.width-50,
                                child: DropdownButtonFormField<Language>(
                                  selectedItemBuilder:
                                      (BuildContext context) {
                                    return languages.map((Language value) {
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          value.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  "Montserrat-Medium"),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .only(start: 15, end: 10),
                                        child: ImageIcon(
                                          AssetImage(
                                              'assets/icons/language.png'),
                                          color: AppColors.app_color,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.grey[100],
                                          fontFamily: "Montserrat-Medium"),
                                      hintText: "Language known",
                                      fillColor: Colors.red[100]),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(15),
                                  ),
                                  value: languages.first,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLanguage = value!;
                                    });
                                  },
                                  items: languages
                                      .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value.name,
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  ScreenUtil().setSp(15),
                                            ),
                                          )))
                                      .toList(),
                                ),
                              ),*/
                              ])),
                    10.verticalSpace,
                    if (widget.socialId.isEmpty)
                      CustomTextFormField(
                        controller: _passwordController,
                        validator: (value) => vaidatePassword(value!) == 'Weak'
                            ? "Must contain at least one Capital letter and a number"
                            : null,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: passwordIcon,
                        showPassword: _showPassword,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _showPassword = !_showPassword;
                              setState(() {});
                            },
                            child: _showPassword
                                ? passwordEyeIcon
                                : passwordGreenEyeIcon),
                        hintText: "Password",
                        isValid: isVaildPassword,
                        onChanged: (value) {
                          password = value;
                          passwordStrength = vaidatePassword(value);
                          setState(() {});
                          if (value.isNotEmpty &&
                              vaidatePassword(value) == 'Strong') {
                            isVaildPassword = true;
                          } else {
                            isVaildPassword = false;
                          }
                          setState(() {});
                        },
                      ),
                    passwordStrength == ''
                        ? SizedBox(height: ScreenUtil().setHeight(0))
                        : Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Password Strength:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF767F94),
                                      fontSize: ScreenUtil().setSp(13)),
                                ),
                                Text(
                                  passwordStrength,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: passwordStrength == 'Weak'
                                          ? Colors.red
                                          : const Color(0xFF05C46B),
                                      fontSize: ScreenUtil().setSp(13)),
                                )
                              ],
                            ),
                          ),
                    if (widget.socialId.isEmpty)
                      CustomTextFormField(
                        showPassword: _showCheckPassword,
                        controller: _checkPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        isValid: isVaildConfirm,
                        onChanged: (value) {
                          if (value.isNotEmpty && value == password) {
                            isVaildConfirm = true;
                          } else {
                            isVaildConfirm = false;
                          }
                          checkPassword = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (value != _passwordController.value.text) {
                              return "Passwords do not match";
                            } else {
                              return null;
                            }
                          } else {
                            return "Enter Your password";
                          }
                        },
                        prefixIcon: passwordIcon,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _showCheckPassword = !_showCheckPassword;
                              setState(() {});
                            },
                            child: _showCheckPassword
                                ? passwordEyeIcon
                                : passwordGreenEyeIcon),
                        hintText: "Confirm Password",
                      ),
                    SizedBox(height: 20),
                    Container(
                      height: ScreenUtil().screenHeight * 0.06,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.app_color),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().screenHeight * 0.03)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Opacity(
                            //   opacity: 0,
                            //   child: Icon(Icons.arrow_forward_ios),
                            // ),
                            Text(
                              "Sign in with Email",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14.sp,
                                // fontFamily: 'Montserrat-Medium',
                              ),
                            ),
                            // Image.asset('assets/icons/arw.png', scale: 1.0),
                          ],
                        ),
                        onPressed: () async {
                          if (widget.isprovider) {
                            setState(() {
                              this.loading = true;
                            });
                            String message =
                                await checkUser(email: _emailController.text)
                                    .then((value) {
                              setState(() {
                                this.loading = false;
                              });

                              return value;
                            });

                            if (message == 'No user found against this email') {
                              onregisterpressedprovider();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('User Already Exists')));
                            }
                          } else {
                            onregisterpressed();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'By signing up you accept our ',
                          style: TextStyle(
                            color: const Color(0xFF7b7d83),
                            fontSize: 14,
                            // fontFamily: 'Montserrat-Medium'
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Privacy();
                            }));
                          },
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                // fontFamily: "Montserrat-Medium",
                                fontSize: 14,
                                color: Color(0xFF4995EB)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  onregisterpressedprovider() async {
    print("inside>>>>>>>>>>>>");
    isVaildFirstName = !_nameController.text.isNullOrEmpty;
    isVaildEmail =
        !_emailController.text.isNullOrEmpty && isEmail(_emailController.text);
    isVaildAge = !_ageController.text.isNullOrEmpty;
    // isVaildNati = !_nationalityController.text.isNullOrEmpty;
    isVaildPassword = !_passwordController.text.isNullOrEmpty;
    isVaildConfirm = !_checkPasswordController.text.isNullOrEmpty &&
        _passwordController.text == _checkPasswordController.text;
    setState(() {});
    if (widget.socialId.isEmpty) {
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          !isEmail(_emailController.text) ||
          _passwordController.text.isEmpty ||
          passwordStrength == 'Weak' ||
          _checkPasswordController.text.isEmpty ||
          _checkPasswordController.text != _passwordController.text) {
        return;
      }
    }

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !isEmail(_emailController.text)) {
      return;
    }
    HttpClient()
        .checkEmail(_emailController.text.trim().toLowerCase())
        .then((value) {
      setState(() {
        this.loading = true;
      });
      if (value!.data["status"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('This Email already exists, please login')));
        return;
      } else {
        print('printing age ${_ageController.text}');
        Map<String, dynamic> bodyprovider = widget.socialId.isEmpty
            ? {
                'first_name': _nameController.text,
                'last_name': "",
                'username': "",
                'email': _emailController.text.trim().toLowerCase(),
                'phone_number': '',
                'password': _passwordController.text,
                "Age": _ageController.text,
                "nationality": 'India',
                'fcm_token': StorageManager().fcmToken,
                'os': Platform.isAndroid ? 'android' : 'ios',
                "language": 'English',
                "login_src": "",
                "social_login_id": "",
              }
            : {
                'first_name': _nameController.text,
                'last_name': "",
                'username': "",
                'email': _emailController.text.trim().toLowerCase(),
                'phone_number': '',
                'password': '',
                'login_src': widget.loginType,
                'social_login_id': widget.socialId,
                'fcm_token': StorageManager().fcmToken,
                'os': Platform.isAndroid ? 'android' : 'ios',
                "Age": _ageController.text,
                "nationality": 'India',
                "language": 'English ',
              };
        print(bodyprovider);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FirstGigPage(bodyprovider: bodyprovider)));
      }
    }).catchError((e) {
      setState(() {
        this.loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email id already exists, please login')));
      return;
    });
  }

  onregisterpressed() async {
    print('aacccdddddd');
    isVaildFirstName = !_nameController.text.isNullOrEmpty;
    isVaildEmail =
        !_emailController.text.isNullOrEmpty && isEmail(_emailController.text);
    // isVaildNati = !_nationalityController.text.isNullOrEmpty;
    isVaildPassword = !_passwordController.text.isNullOrEmpty;
    isVaildConfirm = !_checkPasswordController.text.isNullOrEmpty &&
        _passwordController.text == _checkPasswordController.text;

    setState(() {});
    // isVaildFirstName = !_nationalityController.text.isNullOrEmpty;
    if (widget.socialId.isEmpty) {
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          !isEmail(_emailController.text) ||
          _passwordController.text.isEmpty ||
          passwordStrength == 'Weak' ||
          _checkPasswordController.text.isEmpty ||
          _checkPasswordController.text != _passwordController.text) {
        return;
      }
    }
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !isEmail(_emailController.text)) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ChooseLocationScreen(
            email: _emailController.text.trim().toLowerCase(),
            password: _passwordController.text,
            name: _nameController.text,
            socialId: widget.socialId,
            loginType: widget.loginType);
        // return LocationScreen(
        //     email: _emailController.text.trim().toLowerCase(),
        //     password: _passwordController.text,
        //     name: _nameController.text,
        //     socialId: widget.socialId,
        //     loginType: widget.loginType);
      },
    ));

    /*  Map<String, dynamic> body = widget.socialId.isEmpty
          ? {
              'first_name': _nameController.text,
              'username': "",
              'last_name': "",
              'email': _emailController.text,
              'phone_number': "",
              'password': _passwordController.text,
              'fcm_token': StorageManager().fcmToken,
              'os': Platform.isAndroid ? 'android' : 'ios',
              'language': "English",
              'nationality': "Malta",
              'login_src': '',
              'social_login_id': '',
              'location' : '${location}',
              'lat' : '${lat}',
              'lng' : '${lng}',
            }
          : {
              'first_name': _nameController.text,
              'username': "",
              'last_name': "",
              'email': _emailController.text,
              'phone_number': "",
              'password': '',
              'login_src': widget.loginType,
              'social_login_id': widget.socialId,
              'fcm_token': StorageManager().fcmToken,
              'os': Platform.isAndroid ? 'android' : 'ios',
              'language': "English",
              'nationality': "Malta",
            };*/

    /*     await HttpClient().userSignup(body, new File("path")).then((value) {
        loading = false;
        if (value?.data['status']) {
          var provider = StorageManager();
          provider.accessToken = value?.data['token'];
          provider.name = _nameController.text;
          // provider.phone = _phnocontroller.text;
          provider.email = _emailController.text;
          provider.isProvider = false;
          provider.isSocialUser = !widget.socialId.isEmpty?true:false;
          provider.userId = value?.data['user']['id'];
          provider.nationality = value?.data['user']['nationality'];
          provider.language = value?.data['user']['languages'];
          provider.stripeId = "" + value?.data['user']['customer_stripe_id'];

        }
        setState(() {});

      }).catchError((e) {
        setState(() {
          this.loading = false;
        });
        BaseDio.getDioError(e);
      });*/
  }
}
