import 'package:kappu/models/serializable_model/offer_package.dart';

class Offer {
  String offerid;
  String offertitle;
  String offerDescription;
  List<Offerpackage> packages;

  Offer({
    required this.packages,
    required this.offerid,
    required this.offertitle,
    required this.offerDescription,
  });
}

List<Offer> tempoffer = [
  Offer(
    packages: temppackage,
    offerid: '',
    offertitle: 'Your cleaner on his way',
    offerDescription:
        'Huzaifa is an unbelievable coder! His work ethic is superb and the standard of work he delivers is the best I have ever encountered on Fiverr. Communication is brilliant as well. 5 stars is not enough to award him. He deserves 20! I would highly recommend him and I will definately be back!',
  ),
  Offer(
    packages: temppackage,
    offerid: '',
    offertitle: 'Your cleaner on his way',
    offerDescription:
        'Huzaifa is an unbelievable coder! His work ethic is superb and the standard of work he delivers is the best I have ever encountered on Fiverr. Communication is brilliant as well. 5 stars is not enough to award him. He deserves 20! I would highly recommend him and I will definately be back!',
  ),
  Offer(
    packages: temppackage,
    offerid: '',
    offertitle: 'Your cleaner on his way',
    offerDescription:
        'Huzaifa is an unbelievable coder! His work ethic is superb and the standard of work he delivers is the best I have ever encountered on Fiverr. Communication is brilliant as well. 5 stars is not enough to award him. He deserves 20! I would highly recommend him and I will definately be back!',
  ),
  Offer(
    packages: temppackage,
    offerid: '',
    offertitle: 'Your cleaner on his way',
    offerDescription:
        'Huzaifa is an unbelievable coder! His work ethic is superb and the standard of work he delivers is the best I have ever encountered on Fiverr. Communication is brilliant as well. 5 stars is not enough to award him. He deserves 20! I would highly recommend him and I will definately be back!',
  )
];

List<Offerpackage> temppackage = [
  Offerpackage(
      packageid: 0,
      packagetitle: '1 BKH',
      packagePrice: 233,
      packageServicetime: '2 hr 30 min',
      packagelocation: ''),
  Offerpackage(
      packageid: 0,
      packagetitle: '2 BKH',
      packagePrice: 455,
      packageServicetime: '4 hr 30 min',
      packagelocation: ''),
  Offerpackage(
    packageid: 0,
    packagelocation: '',
    packagetitle: '3 BKH',
    packagePrice: 553,
    packageServicetime: '6 hr 30 min',
  ),
  Offerpackage(
      packageid: 0,
      packagetitle: '4 BKH',
      packagePrice: 733,
      packageServicetime: '7 hr 30 min',
      packagelocation: ''),
  Offerpackage(
      packageid: 0,
      packagetitle: '5 BKH',
      packagePrice: 633,
      packageServicetime: '8 hr 30 min',
      packagelocation: ''),
];
