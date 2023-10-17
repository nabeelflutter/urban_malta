import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/Transaction/statisic.dart';
import 'package:kappu/models/serializable_model/payments.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _loading = false;
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_loadMoreTransactions);
  }

  Future<void> _fetchData() async {
    setState(() {
      _loading = true;
    });

    final url = '${Constants.BASE_URL}/api/wallet/history?page=$_currentPage';
    // print(url);
    final token = StorageManager().accessToken;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(token);
    print(url);
    final body = {
      'user_id': StorageManager().userId.toString(),
    };
    print(body);
    print(StorageManager().userId);
    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Transaction> transactions =
            List.from(jsonData['history']).map((data) {
          // print(jsonData);
          return Transaction.fromJson(data);
        }).toList();

        setState(() {
          _transactions.addAll(transactions);
          _loading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch data');
    }
  }

  void _loadMoreTransactions() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_loading) {
        setState(() {
          _currentPage++;
          _loading = true;
        });
        _fetchData();
      }
    }
  }

  List<Transaction> _getTodayTransactions() {
    final today = DateTime.now();
    return _transactions
        .where((transaction) =>
            DateTime.parse(transaction.createdAt).day == today.day &&
            DateTime.parse(transaction.createdAt).month == today.month &&
            DateTime.parse(transaction.createdAt).year == today.year)
        .toList();
  }

  List<Transaction> _getYesterdayTransactions() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return _transactions
        .where((transaction) =>
            DateTime.parse(transaction.createdAt).day == yesterday.day &&
            DateTime.parse(transaction.createdAt).month == yesterday.month &&
            DateTime.parse(transaction.createdAt).year == yesterday.year)
        .toList();
  }

  List<Transaction> _getOtherTransactions() {
    final today = DateTime.now();
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return _transactions
        .where((transaction) =>
            DateTime.parse(transaction.createdAt).day != today.day &&
            DateTime.parse(transaction.createdAt).day != yesterday.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Transaction History",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff161D35),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 60,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Color(0xfff8f9ff),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(19),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 29,
                          color: Color(0xff8E98BD),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8E98BD),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Visibility(
                    visible: _transactions.isEmpty && !_loading,
                    child: Center(
                      child: Text(
                        "No transaction history found",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: _transactions.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return SizedBox();
                      } else if (index == 1) {
                        return _buildHeader("Today");
                      } else if (index <= _getTodayTransactions().length + 1) {
                        return _buildTransactionTile(
                            _getTodayTransactions()[index - 2]);
                      } else if (index == _getTodayTransactions().length + 2) {
                        return _buildHeader("Yesterday");
                      } else if (index <=
                          _getTodayTransactions().length +
                              _getYesterdayTransactions().length +
                              2) {
                        final int yesterdayIndex =
                            index - _getTodayTransactions().length - 3;
                        return _buildTransactionTile(
                            _getYesterdayTransactions()[yesterdayIndex]);
                      } else if (index ==
                          _getTodayTransactions().length +
                              _getYesterdayTransactions().length +
                              3) {
                        return _buildHeader("Others");
                      } else if (index <=
                          _getTodayTransactions().length +
                              _getYesterdayTransactions().length +
                              _getOtherTransactions().length +
                              3) {
                        final int otherIndex = index -
                            _getTodayTransactions().length -
                            _getYesterdayTransactions().length -
                            4;
                        return _buildTransactionTile(
                            _getOtherTransactions()[otherIndex]);
                      } else if (_loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  Visibility(
                    visible: _loading, // Show the loader when _loading is true
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    List<Transaction> transactions;
    if (title == "Today") {
      transactions = _getTodayTransactions();
    } else if (title == "Yesterday") {
      transactions = _getYesterdayTransactions();
    } else if (title == "Others") {
      transactions = _getOtherTransactions();
    } else {
      transactions = [];
    }

    if (transactions.isEmpty) {
      return SizedBox(); // If there are no transactions, return an empty SizedBox to hide the header and divider.
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xff161D35),
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 5),
            child: Divider())
      ]);
    }
  }

  Widget _buildTransactionTile(Transaction transaction) {
    String createdAt = transaction.createdAt.toString();
    DateTime dateTime = DateTime.parse(createdAt);
    String formattedDate = DateFormat("dd MMMM yyyy").format(dateTime);

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          leading: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/j4.png"),
              ),
              borderRadius: BorderRadius.circular(50),
              color: Color(0xfffeeeee),
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              transaction.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff161D35),
              ),
            ),
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 185, 186, 187),
              ),
            ),
          ),
          trailing: (transaction.type.toString() == "topup")
              ? RichText(
                  text: TextSpan(
                    text: "+ ",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 33, 247, 65),
                    ),
                    children: [
                      TextSpan(
                        text: '\u0024' + transaction.amount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xff161D35),
                        ),
                      ),
                    ],
                  ),
                )
              : RichText(
                  text: TextSpan(
                    text: "- ",
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: '\u0024' + transaction.amount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xff161D35),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider())
      ],
    );
  }
}
