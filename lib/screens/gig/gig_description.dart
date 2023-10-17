import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../components/AppColors.dart';
import '../../models/serializable_model/CategoryResponse.dart';
import '../register/widgets/text_field.dart';
import 'Create_first_gig.dart';

class GigDescription extends StatefulWidget {
  final PageController pageController;
  final InputData inputData;

  const GigDescription(
      {Key? key, required this.inputData, required this.pageController})
      : super(key: key);

  @override
  State<GigDescription> createState() => _GigDescriptionState();
}

class _GigDescriptionState extends State<GigDescription> {
  void _onDataCollected(String data) {
    widget.inputData.desc = data;

    // You can perform other operations with the data if needed
    // ...

    // Move to the next page
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  TextEditingController _descriptionController = TextEditingController();
  String _generatedDescription = '';
  String apiUri = 'https://api.openai.com/v1/models/text-davinci-003';
  String apiUrl = 'https://api.openai.com/v1/completions';
  String apiKey = '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';

  final TextEditingController _descController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool isValidDesc = true;
  bool isValidTitle = true;

  void initState() {
    super.initState();
    print('bbbb');
    _rateController.text = widget.inputData.price ?? '';
    _descController.text = widget.inputData.desc ?? '';
  }

  Future<String> generateDescription(
    String skills,
  ) async {
    Map<String, dynamic> body = {
      "model": "text-davinci-003",
      "prompt":
          "suggest professional description depending upon my knowledge and skills, ${skills}",
      "max_tokens": 40,
      "temperature": 0
    };
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );

    print('Printing response: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String generatedText = data['choices'][0]['text'];
      return generatedText.substring(2);
    } else {
      return 'Failed to generate description.';
    }
  }

  bool isLoading = false;
  Category selectedcatagory = Category(
      id: -1,
      name: "Select a Service",
      createdAt: "",
      image: "",
      description: "");
  List<String> addedSkills = [];

  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _extraRateController = TextEditingController();
  PageController pageContro = PageController();

  bool isValidRate = true;
  bool isValidExtraRate = true;
  bool priceFill = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Navigator.push(context, route)
            widget.pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: KeyboardVisibilityBuilder(builder: (context, isVisible) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: isVisible
                    ? MediaQuery.of(context).viewInsets.bottom
                    : 0),
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height - (isVisible ? -100 : 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add a Short description\nto your GiG',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const Text(
                    "Write your gig's description\nmanually or tap 'Auto Generate'\nfor AI-crafted content.",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        // color: Colors.amber,
                        borderRadius: BorderRadius.circular(35)),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _descController,
                          hintText:
                              "Showcase your skills,tell customers why they should pick you,and stand out.Make it catchy toget noticed!",
                          // 'Description | Cover letter – why should user hire you?',
                          suffixIcon: IconButton(
                            icon: isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Icon(Icons.replay_circle_filled),
                            onPressed: () async {
                              String skills =
                                  'my job title is ${_titleController.text} and my skills are the following : ${widget.inputData.skills.toString()}';
                              setState(() {
                                isLoading = true;
                              });
                              String description =
                                  await generateDescription(skills);

                              setState(() {
                                isLoading = false;
                                _generatedDescription = description;
                                _descController.text = _generatedDescription;
                                widget.inputData.setDesc(_generatedDescription);
                              });
                            },
                            color: Colors.blue,
                          ),
                          hintTextStyle: TextStyle(
                            // color: Colors.black,
                            // fontFamily: "Montserrat-Medium",
                            fontWeight: FontWeight.w100,
                            // fontFamily: 'Raleway',
                            fontSize: ScreenUtil().setSp(14),
                          ),
                          keyboardType: TextInputType.text,
                          maxlines: 5,
                          isValid: isValidDesc,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              isValidDesc = true;
                            } else {
                              isValidDesc = false;
                            }
                            widget.inputData.setDesc(value);
                            setState(() {});
                          },
                          validator: (value) =>
                              value!.isEmpty ? "Enter Your Description" : null,
                        ),
                        Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                onPressed: () async {
                                  String skills =
                                      'my job title is ${widget.inputData.title} and my skills are the following : ${widget.inputData.skills.toString()}';
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String description =
                                      await generateDescription(skills);

                                  if (description.contains('Failed')) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Sorry, auto-description is unavailable. Please write your description manually. Thank you')));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                      _generatedDescription = description;
                                      _descController.text =
                                          _generatedDescription;
                                      widget.inputData
                                          .setDesc(_generatedDescription);
                                    });
                                  }
                                },
                                child: isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text('Auto Generate by AI'))),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),
                  // Center(
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(50))),
                  //         onPressed: () async {
                  //           String skills =
                  //               'i am ${selectedcatagory} and my job title is ${_titleController.text} and my skills are the following : ${addedSkills.toString()}';
                  //           setState(() {
                  //             isLoading = true;
                  //           });
                  //           String description =
                  //               await generateDescription(skills);

                  //           if (description.contains('Failed')) {
                  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //                 content: Text(
                  //                     'Sorry, auto-description is unavailable. Please write your description manually. Thank you')));
                  //             setState(() {
                  //               isLoading = false;
                  //             });
                  //           } else {
                  //             setState(() {
                  //               isLoading = false;
                  //               _generatedDescription = description;
                  //               _descController.text = _generatedDescription;
                  //               widget.inputData.setDesc(_generatedDescription);
                  //             });
                  //           }
                  //         },
                  //         child: isLoading
                  //             ? SizedBox(
                  //                 height: 20,
                  //                 width: 20,
                  //                 child: CircularProgressIndicator(
                  //                   color: Colors.white,
                  //                 ),
                  //               )
                  //             : Text('Auto Generate by AI'))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    'Set Hourly Price for\nYour Gig',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 23,
                        color: Color(0xff374151),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    "Specify your hourly rate. Ensure\nit's competitive and  reflects the\nvalue you offer.",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                    1, 1), // changes the shadow position
                              ),
                            ],
                          ),
                          child: CustomTextFormField(
                            padding: EdgeInsets.zero,
                            controller: _rateController,
                            hintText: '',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icon(Icons.euro_symbol_outlined),
                            isTransparent: true,
                            isValid: isValidRate,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isValidRate = true;
                              } else {
                                isValidRate = false;
                              }
                              widget.inputData.setPrice(value);
                              setState(() {});
                            },
                            validator: (value) => value!.isEmpty
                                ? "Enter \€ per hour"
                                : value!.length > 2
                                    ? "Enter valid \€ per hour"
                                    : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'per hour',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 25,
                              color: Color(0xff656565)),
                        ),
                      ),
                    ],
                  ),
                  if (!isValidRate)
                    const Text(
                      "Pls enter the price",
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  Visibility(
                    visible: false,
                    child: CustomTextFormField(
                      controller: _extraRateController,
                      hintText: 'Extra \€ for urgent need',
                      keyboardType: TextInputType.number,
                      prefixIcon: ImageIcon(
                        AssetImage('assets/icons/price.png'),
                        color: AppColors.app_color,
                      ),
                      isValid: isValidExtraRate,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          isValidExtraRate = true;
                        } else {
                          isValidExtraRate = false;
                        }

                        setState(() {});
                      },
                      validator: (value) => value!.isEmpty
                          ? "Enter extra \€"
                          : value!.length > 2
                              ? "Enter valid extra \€"
                              : null,
                    ),
                  ),
                  if(!isVisible)
                  const Expanded(child: SizedBox()),

                  Padding(
                    padding: EdgeInsets.only(
                      top: isVisible?50:0,
                        bottom: 10),
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {
                            widget.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text('Next')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
