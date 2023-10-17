class PromoApiModel{
  String id;
  String title;
  String desc;
  String image;
  String cat_id;
  String status;
  String created_at;
  String updated_at;

//<editor-fold desc="Data Methods">

  PromoApiModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.image,
    required this.cat_id,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromoApiModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          desc == other.desc &&
          image == other.image &&
          cat_id == other.cat_id &&
          status == other.status &&
          created_at == other.created_at &&
          updated_at == other.updated_at);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      desc.hashCode ^
      image.hashCode ^
      cat_id.hashCode ^
      status.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;

  @override
  String toString() {
    return 'PromoApiModel{' +
        ' id: $id,' +
        ' title: $title,' +
        ' desc: $desc,' +
        ' image: $image,' +
        ' cat_id: $cat_id,' +
        ' status: $status,' +
        ' created_at: $created_at,' +
        ' updated_at: $updated_at,' +
        '}';
  }

  PromoApiModel copyWith({
    String? id,
    String? title,
    String? desc,
    String? image,
    String? cat_id,
    String? status,
    String? created_at,
    String? updated_at,
  }) {
    return PromoApiModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      image: image ?? this.image,
      cat_id: cat_id ?? this.cat_id,
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
      'image': this.image,
      'cat_id': this.cat_id,
      'status': this.status,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
    };
  }

  factory PromoApiModel.fromJson(Map<String, dynamic> json) {
    return PromoApiModel(
      id: json['id'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      image: json['image'] as String,
      cat_id: json['cat_id'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );
  }

//</editor-fold>
}