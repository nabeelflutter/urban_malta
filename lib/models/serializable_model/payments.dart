class Transaction {
  int id;
  String title;
  String type;
  String createdAt;
  String amount;

  Transaction({
    required this.id,
    required this.title,
    required this.type,
    required this.createdAt,
    required this.amount,
  });

    factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown title' ,
      type: json['type'] ?? 'Unknown type',
      createdAt: json['created_at'] ?? 'Unknow date',
      amount: json['amount'] ?? '0',
    );
  }
}
