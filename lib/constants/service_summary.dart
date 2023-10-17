class ServiceSummary {
  String imagepath;
  String servicename;
  String exta;
  int id;
  bool containsubcatagories;
  ServiceSummary(
      {required this.id,
      required this.containsubcatagories,
      required this.imagepath,
      required this.servicename,
      required this.exta});
}

List<ServiceSummary> servicesSummary = [
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/electrician.png',
      servicename: 'Electrician',
      exta: 'Includes Visiting charges',
      id: 10),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/mother.png',
      servicename: 'Baby Sitter',
      exta: 'Includes Visiting charges',
      id: 8),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/bodypump.png',
      servicename: 'Gym Trainer',
      exta: '',
      id: 11),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/doctor.png',
      servicename: 'Doctor',
      exta: '',
      id: 2),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/household.png',
      servicename: 'Home Cleaning',
      exta: 'Includes Visiting charges',
      id: 9),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/application.png',
      servicename: 'More',
      exta: '',
      id: -1),
];

List<ServiceSummary> allservices = [
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/doctor.jpg',
      servicename: 'Doctor',
      exta: 'Includes Visiting charges',
      id: 1),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/plumber.jpg',
      servicename: 'Plumber',
      exta: 'Includes Visiting charges',
      id: 2),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/escotter.jpg',
      servicename: 'Esocotter',
      exta: 'Includes Visiting charges',
      id: 3),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/massagewomen.jpg',
      servicename: 'Massage for Women',
      exta: 'Includes Visiting charges',
      id: 4),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/saloonwomen.jpg',
      servicename: 'Salon for women',
      exta: 'Includes Visiting charges',
      id: 5),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/barber.jpg',
      servicename: 'Salon for men',
      exta: 'Includes Visiting charges',
      id: 6),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/babysitter.jpg',
      servicename: 'Baby Sitter',
      exta: 'Includes Visiting charges',
      id: 7),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/homecleaning.jpg',
      servicename: 'Home Cleaning',
      exta: 'Includes Visiting charges',
      id: 8),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/electrician.jpg',
      servicename: 'Electrician',
      exta: 'Includes Visiting charges',
      id: 9),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/fitness.jpg',
      servicename: 'Gym Trainer',
      exta: 'Includes Visiting charges',
      id: 10),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/vetdoctor.jpg',
      servicename: 'Vet Doctor',
      exta: 'Includes Visiting charges',
      id: 11),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/lock.jpg',
      servicename: 'Lock Smith',
      exta: 'Includes Visiting charges',
      id: 12),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/lawyer.jpg',
      servicename: 'Lawyer',
      exta: 'Includes Visiting charges',
      id: 13),
  ServiceSummary(
      containsubcatagories: false,
      imagepath: 'assets/images/bycyclemechenic.jpg',
      servicename: 'Bicylce Mechenic',
      exta: 'Includes Visiting charges',
      id: 14),
  ServiceSummary(
      containsubcatagories: true,
      imagepath: 'assets/images/homecleaning.jpg',
      servicename: 'Office Cleaning',
      exta: 'Includes Visiting charges',
      id: 15)
];
