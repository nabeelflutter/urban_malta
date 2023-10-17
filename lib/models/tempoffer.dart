class Offerpackagetemp {
  String packagetitle;
  double packagePrice;
  String packageServicetime;
  int packageservicequantity;

  Offerpackagetemp(
      {required this.packagetitle,
      required this.packagePrice,
      required this.packageServicetime,
      required this.packageservicequantity});
}

List<Offerpackagetemp> packagebought = [
  Offerpackagetemp(
      packagetitle: 'Bathroom Cleaning',
      packagePrice: 33,
      packageServicetime: '2 hr 30 min',
      packageservicequantity: 3),
  Offerpackagetemp(
      packagetitle: 'Bathroom Floor Cleaning',
      packagePrice: 23,
      packageServicetime: '30 min',
      packageservicequantity: 2),
  Offerpackagetemp(
      packagetitle: 'Wash Basin Cleaning',
      packagePrice: 12,
      packageServicetime: '2 hr 30 min',
      packageservicequantity: 1),
];

List<Offerpackagetemp> temppackage = [
  Offerpackagetemp(
      packagetitle: '1 BKH',
      packagePrice: 233,
      packageServicetime: '2 hr 30 min',
      packageservicequantity: 0),
  Offerpackagetemp(
      packagetitle: '2 BKH',
      packagePrice: 455,
      packageServicetime: '4 hr 30 min',
      packageservicequantity: 0),
  Offerpackagetemp(
      packagetitle: '3 BKH',
      packagePrice: 553,
      packageServicetime: '6 hr 30 min',
      packageservicequantity: 0),
  Offerpackagetemp(
      packagetitle: '4 BKH',
      packagePrice: 733,
      packageServicetime: '7 hr 30 min',
      packageservicequantity: 0),
  Offerpackagetemp(
      packagetitle: '5 BKH',
      packagePrice: 633,
      packageServicetime: '8 hr 30 min',
      packageservicequantity: 0),
];
