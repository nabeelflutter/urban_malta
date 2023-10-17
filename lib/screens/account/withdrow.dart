import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/account/Review.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../components/AppColors.dart';
import 'accountD.dart';

class WithDraw extends StatefulWidget {
  const WithDraw({
    Key? key,
  }) : super(key: key);

  @override
  State<WithDraw> createState() => _WithDrawState();
}

class _WithDrawState extends State<WithDraw> {
  List<Map<String, dynamic>> selectedBank = [];

  String selectedBankName = '';
  bool isFinished = false;

  bool isIconTapped = false;

  void _toggleIconTapped() {
    setState(() {
      isIconTapped = !isIconTapped;
    });
  }

  bool isbuttonActive = true;
  final TextEditingController textFieldController = TextEditingController();

  bool isNextButtonEnabled() {
    return textFieldController.text.isEmpty;
  }

  int? selectedButtonIndex;
  int grapvalue = 0;

  onChanged(int value) {
    setState(() {
      grapvalue = value;
    });
  }

  int selectedButton = 0;

  int groupValue = 0;

  void handleRadioValueChange(int value) {
    // Update the groupValue and disable the radio button
    setState(() {
      groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading:  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,)),
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 20, top: 20),
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.arrow_back_ios, color: Color(0xff161D35)),
          //   ),
          // ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Transfer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: KeyboardVisibilityBuilder(builder: (_, isVisible) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 65,
                  left: 20,
                  right: 20,
                  bottom:isVisible?MediaQuery.of(context).viewInsets.bottom+250:
                       20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 180,
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 9.0,
                                    offset: const Offset(1, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child:
                                  Image.asset("assets/images/j12.png"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'UrbanMalta',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: const Text(
                          'to',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.2),
                                //     blurRadius: 9.0,
                                //     offset: const Offset(1, 5),
                                //   ),
                                // ],
                                border: Border.all(
                                    width: 1, color: Colors.red),

                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                "assets/images/j11.png",
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              selectedBankName.isNotEmpty
                                  ? selectedBankName
                                  : 'Choose Your Bank',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  bottmSheet();
                                },
                                child: Text(
                                  selectedBankName.isNotEmpty
                                      ? 'Change'
                                      : 'Select Bank',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff8FB0FF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Input your amount',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6B769B),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: 340,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: textFieldController,
                      onChanged: (value) {
                        setState(() {
                          // TextfiledData = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "EUR",
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8E98BD),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Spacer(),
                  SwipeableButtonView(
                    isActive:
                        !isNextButtonEnabled() && selectedBankName != "",
                    buttonText: "Next",
                    buttonWidget: Container(
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    activeColor: const Color(0xff3398F6),
                    isFinished: isFinished,
                    // isButtonEnabled:
                    //     !isTextFieldEmpty(), // Enable the button if the text field is not empty
                    onWaitingProcess: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ReviewTransfer(
                            price: textFieldController.text,
                            dataList: selectedBank);
                      })).then((value) {
                        setState(() {
                          isFinished = false;
                        });
                      });
                      FocusScope.of(context).unfocus();
                    },
                    onFinish: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ReviewTransfer(
                            price: textFieldController.text,
                            dataList: selectedBank);
                      })).then((value) {
                        setState(() {
                          isFinished = false;
                        });
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  updateIndex(int val) {
    setState(() {
      selectedButtonIndex = val;
    });
  }

  Widget bottomeSheetMoney(BuildContext context, StateSetter setState) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: 520,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: Color(0xffF6F8FF),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 216, 231),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 216, 231),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.6,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.6,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 275,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder<List<dynamic>>(
                future: getDataWithToken(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 7),
                          child: ListTile(
                            title: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '${snapshot.data![index]['first_name'] ?? ''} - ${snapshot.data![index]['last_name'] ?? ''}',
                              ),
                            ),
                            subtitle: Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                '${snapshot.data![index]['iban']}',
                              ),
                            ),
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xffFEEEEE),
                              ),
                              child: Image.asset(
                                'assets/images/j12.png',
                              ),
                            ),
                            onTap: () {
                              print(snapshot.data);
                              selectedBankName =
                                  '${snapshot.data![index]['first_name'] ?? ''} - ${snapshot.data![index]['last_name'] ?? ''}';

                              setState(() {
                                selectedButtonIndex = index;

                                selectedBank = [
                                  {
                                    "id": snapshot.data![index]['id'],
                                    "country": snapshot.data![index]['country'],
                                    "iban": snapshot.data![index]['iban'],
                                    "bic_swift": snapshot.data![index]
                                        ['bic_swift'],
                                    "first_name": snapshot.data![index]
                                        ['first_name'],
                                    "last_name": snapshot.data![index]
                                        ['last_name'],
                                    "email": snapshot.data![index]['email'],
                                    "created_at": snapshot.data![index]
                                        ['created_at'],
                                    "updated_at": snapshot.data![index]
                                        ['updated_at'],
                                    "user_id": snapshot.data![index]['user_id']
                                  }
                                ];
                              });

                              setState(() {});
                            },
                            trailing: InkWell(
                              onTap: () {
                                print(snapshot.data);
                                print(index);
                                //updateIndex(index);
                                setState(() {
                                  selectedBankName =
                                      snapshot.data![index]['first_name'];
                                  selectedButtonIndex = index;
                                  selectedBank = [
                                    {
                                      "id": snapshot.data![index]['id'],
                                      "country": snapshot.data![index]
                                          ['country'],
                                      "iban": snapshot.data![index]['iban'],
                                      "bic_swift": snapshot.data![index]
                                          ['bic_swift'],
                                      "first_name": snapshot.data![index]
                                          ['first_name'],
                                      "last_name": snapshot.data![index]
                                          ['last_name'],
                                      "email": snapshot.data![index]['email'],
                                      "created_at": snapshot.data![index]
                                          ['created_at'],
                                      "updated_at": snapshot.data![index]
                                          ['updated_at'],
                                      "user_id": snapshot.data![index]
                                          ['user_id']
                                    }
                                  ];
                                });
                              },
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2,
                                          color: selectedButtonIndex != index
                                              ? Colors.grey
                                              : Colors.blue)),
                                  child: selectedButtonIndex != index
                                      ? Container()
                                      : Icon(Icons.circle,
                                          size: 10, color: Colors.blue)),
                            ),
                            // trailing: Radio(
                            //   value: index,
                            //   groupValue: selectedButtonIndex,
                            //   onChanged: (value) {
                            //     selectedButtonIndex = value as int;

                            //     setState(() {
                            //       selectedBankName =
                            //           snapshot.data![index]['country'];
                            //     });
                            //     print(selectedBankName);
                            //   },
                            // ),
                            // onTap: () {
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            'Please Wait For Some Time. Error fetching data'));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: ListTile(
                title: const Text('Add New'),
                leading: CircleAvatar(
                  child: Image.asset('assets/images/j12.png'),
                ),
                trailing: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2,
                          color:
                              selectedButton != 0 ? Colors.blue : Colors.grey)),
                  child: selectedButtonIndex != 0
                      ? Container()
                      : const Icon(Icons.circle, size: 10, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AccountDetail();
                  }));
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return AccountDetail();
                  // }));
                },
                child: const Text(
                  'Next',
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
      );

  bottmSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return bottomeSheetMoney(context, setState);
        });
      },
    );
  }

  late String stringResponse;
  late Map mapResponse;
  late Map dataResponse;
  late List listResponse;

  Future<List<dynamic>> getDataWithToken() async {
    final int user_id = StorageManager().userId;
    final url = '${Constants.BASE_URL}/api/bank/list/$user_id';
    final token = StorageManager().accessToken;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final queryParams = {
      'user_id': user_id.toString(),
    };

    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          mapResponse = json.decode(response.body);
          listResponse = mapResponse['data'];
          print(listResponse);
        });
        return listResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch data');
    }
  }
}
