import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';

import '../../components/AppColors.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  final token = StorageManager().accessToken;

  Future<Map<String, dynamic>> fetchData() async {
    final url = '${Constants.BASE_URL}/api/wallet/statistic';
    print(url);
    print(StorageManager().userId);
    print(token);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({'user_id': StorageManager().userId}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  late String StastringResponse;
  late Map StamapResponse;
  late Map StadataResponse;
  late List StalistResponse;

  Future<List<dynamic>> StaticPostData() async {
    final url = '${Constants.BASE_URL}/api/wallet/statistic';

    final token = StorageManager().accessToken;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': StorageManager().userId,
    };

    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        print('API request successful');

        setState(() {
          StamapResponse = json.decode(response.body);
          print(StamapResponse);
          StalistResponse = StamapResponse['data'];
          print('ajay${StalistResponse}');
        });
        return StalistResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Statistic",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
           leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))

        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
              // top: 15,
              // left: 25,
              // right: 25,
              right: 20,
              left: 20),
          child: FutureBuilder<Map<String, dynamic>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                final data = snapshot.data!;
                print(data);

                return Column(
                  children: [
                    // const Text(
                    //   "Statistic",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w800,
                    //     color: Color(0xff161D35),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Balance",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8E98BD),
                          ),
                        ),
                        Spacer(),
                        const Icon(
                          Icons.calendar_month,
                          size: 21,
                          color: Color(0xff8E98BD),
                        ),
                        Text(
                          " ${DateFormat("MMMM yyyy").format(DateTime.now())}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff8E98BD),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // "€${data['balance'].toString()}",
                        data['balance'].toString(),
                        style: const TextStyle(
                          // fontSize: maxWidth > 600 ? 32 :
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff161D35),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff4995EB),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Total Income",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff161D35),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff16251F),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Total Jobs",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff161D35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff161D35),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff4995EB),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffd1e4fa),
                                  ),
                                  child: Icon(Icons.arrow_downward),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Total Income",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  data['total_income'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    // maxWidth > 600 ? 24 : 20,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff16251F),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffd1e4fa),
                                  ),
                                  child: Icon(Icons.arrow_upward),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Total Number Job",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  data['number_of_jobs'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
        //   },
        // ),
        );
  }
}
