class DiscountModel{
  String id;
  String title;
  String desc;
  String amount;
  String status;
  String created_at;
  String updated_at;

//<editor-fold desc="Data Methods">

  DiscountModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.amount,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscountModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          desc == other.desc &&
          amount == other.amount &&
          status == other.status &&
          created_at == other.created_at &&
          updated_at == other.updated_at);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      desc.hashCode ^
      amount.hashCode ^
      status.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;

  @override
  String toString() {
    return 'DiscountModel{' +
        ' id: $id,' +
        ' title: $title,' +
        ' desc: $desc,' +
        ' amount: $amount,' +
        ' status: $status,' +
        ' created_at: $created_at,' +
        ' updated_at: $updated_at,' +
        '}';
  }

  DiscountModel copyWith({
    String? id,
    String? title,
    String? desc,
    String? amount,
    String? status,
    String? created_at,
    String? updated_at,
  }) {
    return DiscountModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'desc': this.desc,
      'amount': this.amount,
      'status': this.status,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
    };
  }

  factory DiscountModel.fromMap(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      amount: json['amount'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );
  }

//</editor-fold>
}