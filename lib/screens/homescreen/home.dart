import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kappu/constants/constants.dart';

import 'package:kappu/screens/account/accountD.dart';
import '../../constants/storage_manager.dart';
import '../Transaction/topup.dart';
import '../Transaction/transaction.dart';
import '../account/withdrow.dart';
import '../notification/notification_screen.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/screens/homescreen/home.dart';
import 'package:kappu/screens/account/Review.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final List<dynamic> alistResponse;
  // String datalist;
  List<dynamic>? listBanks;
  Future<List<dynamic>> getDataWithToken() async {
    final int userId = StorageManager().userId;
    final url = '${Constants.BASE_URL}/api/bank/list/$userId';
    final token = StorageManager().accessToken;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final queryParams = {
      'user_id': userId.toString(),
    };

    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          mapResponse = json.decode(response.body);
          listResponse = mapResponse['data'];
        });
        setState(() {
          listBanks = listResponse;
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

  @override
  void initState() {
    getDataWithToken();
    super.initState();
  }

  String? balance;
  String? hold;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 25, top: 65),
            child: Stack(
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(fontSize: 15, color: Color(0xff6B769B)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StorageManager().name,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Color(0xff161D35),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const NotificationScreen();
                                  },
                                ));
                              },
                              icon: const Icon(
                                Icons.notifications_none,
                                size: 32,
                              )))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined,
                          size: 21, color: Color(0xff8E98BD)),
                      Text(
                        " ${DateFormat("dd MMMM, yyyy").format(DateTime.now())}",
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xff8E98BD)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.92,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/j1.png"),
                fit: BoxFit.cover,
              ),
              color: const Color(0xffAEB4FC),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(230, 225, 240, 239),
                  spreadRadius:
                      20, // Increase the spread radius for a larger shadow area
                  blurRadius:
                      20, // Increase the blur radius for a more diffuse shadow
                  offset: Offset(-2, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Your Balance",
                          style: TextStyle(color: Color(0xffFFFFFF)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '${ balance != null ? "€ $balance" : "€ 0.00" }',
                          style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StorageManager().isProvider == true
                          ? Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.82,
                              decoration: BoxDecoration(
                                  color: const Color(0xff7cb3f1),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xfffcd063),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Payment on hold",
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xffffffff)),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    hold ?? "€0.00",
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xffffffff)),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StorageManager().isProvider != true
              ? Row(
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const TopUp();
                        }));
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(230, 225, 240, 239),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(-2, 3))
                                ]),
                            height: 60,
                            width: 60,
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Color(0xFF4995EB),
                                size: 30,
                              ),
                              // child: Image.asset(
                              //   'assets/images/j3.png',
                              //   fit: BoxFit.contain,
                              //   height: 45,
                              //   width: 50,
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Top Up",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff6B769B)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (listBanks!.isEmpty) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AccountDetail();
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const WithDraw();
                          }));
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(230, 225, 240, 239),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(-2, 3))
                                ]),
                            // child: Card(
                            // elevation: 50,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(15),
                            // ),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/j4.png',
                                  height: 35,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "WithDraw",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff6B769B)),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (listBanks!.isEmpty) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AccountDetail();
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const WithDraw();
                          }));
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(230, 225, 240, 239),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(-2, 3))
                                ]),
                            // child: Card(
                            // elevation: 50,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(15),
                            // ),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/j4.png',
                                  height: 35,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "WithDraw",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff6B769B)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
          const SizedBox(
            height: 35,
          ),
          if(listResponse.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Activity",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff161D35)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TransactionHistoryScreen();
                    }));
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB5BCD8)),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 25, right: 25),
          //   child: Divider(
          //     thickness: 3,
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            //height: MediaQuery.of(context).size.height * .18,
            width: double.infinity,
            child: FutureBuilder(
              future: postDataWithToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (listResponse.isEmpty) {
                    return const Center(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'No recent transactions found',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.grey),
                            )));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listResponse.length,
                    itemBuilder: (BuildContext context, int index) {
                      String createdAt =
                          listResponse[index]['created_at'].toString();
                      DateTime dateTime = DateTime.parse(createdAt);
                      String formattedDate =
                          DateFormat("dd MMMM yyyy").format(dateTime);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            thickness: 0.6,
                          ),
                          ListTile(
                            // contentPadding: EdgeInsets.symmetric(
                            //     horizontal: 0, vertical: 0),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/j4.png"),
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xfffeeeee),
                              ),
                            ),
                            title: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(listResponse[index]['title'] ?? ""),
                            ),
                            subtitle: Container(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Text(
                                formattedDate,
                                style:
                                    const TextStyle(color: Color(0xffB5BCD8)),
                              ),
                              // color: Color(0xffB5BCD8),
                            ),
                            trailing: (listResponse[index]['type'].toString() ==
                                    "topup")
                                ? RichText(
                                    text: TextSpan(
                                      text: "+ ",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.green),
                                      children: [
                                        TextSpan(
                                          text:
                                              '€${listResponse[index]['amount']}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff161D35),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : RichText(
                                    text: TextSpan(
                                      text: "- ",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.red),
                                      children: [
                                        TextSpan(
                                          text:
                                              '€${listResponse[index]['amount']}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff161D35),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                builder: (context) {
                                  return buildBottomSheet(
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      listResponse: listResponse,
                                      index: index);
                                },
                              );
                            },
                          ),
                          // const Divider(
                          //   thickness: 3,
                          // ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const Center(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No recent transactions found',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.grey),
                          )));
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  late String stringResponse;
  late Map mapResponse;
  late Map dataResponse;
  List listResponse=[];
  Future<List<dynamic>> postDataWithToken() async {
    const url = '${Constants.BASE_URL}/api/wallet/recent/activity';
    final token = StorageManager().accessToken;
    final int userID = StorageManager().userId;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': userID.toString(),
    };

    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        // print('API request successful');

        setState(() {
          mapResponse = json.decode(response.body);
          listResponse = mapResponse['recentactivity'];
          balance = mapResponse['balance'];
          hold = mapResponse['pending_payments'];
          // print(balance);
          // print(listResponse);
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

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMMM yyyy').format(dateTime);
}

Widget buildBottomSheet(
    {required double screenHeight,
    required double screenWidth,
    required List<dynamic> listResponse,
    required int index}) {
  return Container(
    height: screenHeight * 0.85,
    width: screenWidth,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 246, 248, 255),
      borderRadius: BorderRadius.circular(40),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    listResponse[index]['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: 250,
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/img/confirm.png',
                      height: 83,
                      width: 89,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Booking",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            listResponse[index]['desc'] == ''
                                ? '- - - -'
                                : listResponse[index]['desc'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            "You added a sum",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6B769B),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "€ ${listResponse[index]['amount']}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff161D35),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            formatDateString(listResponse[index]['created_at']),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6B769B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  height: 290,
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Summary",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 244, 244, 244),
                        thickness: 0.6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "€ ${listResponse[index]['amount']}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 244, 244, 244),
                        thickness: 0.6,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Fee",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "€ ${listResponse[index]['amount']}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
// run toh kr isse ok