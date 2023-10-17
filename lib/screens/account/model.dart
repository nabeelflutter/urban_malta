// // ignore_for_file: non_constant_identifier_names

// class BankAccount {
//   late String country;
//   late String iban;
//   late String bic;
//   late String firstName;
//   late String lastName;
//   late String email;

//   BankAccount({
//     required this.country,
//     required this.iban,
//     required this.bic,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//   });
//  factory BankAccount.fromJson(Map<String, dynamic> json) {
//     return BankAccount(
//       country: json['country'],
//       iban: json['iban'],
//       bic: json['bic'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//     );
//   }
 
//   Map<String, dynamic> tomap() {
//     return {
//       'country': this.country,
//       'iban': this.iban,
//       'bic': this.bic,
//       'firstName': this.firstName,
//       'lastName': this.lastName,
//       'email': this.email,
    
//     };
//   }
// }
 
  
  
  


// // [
// //     {
// //     "country":"india",
// //     "bankName":"SBI",
// //     "iban":"1234567890123456789012345678901234",
// //     "bic":"123456789",
// //     "firstName":"lakshay",
// //     "lastName":"bansal",
// //     "email":"test@gmail.com"
    
// // },
// // {
// //     "country":"india",
// //     "bankName":"PNB",
// //     "iban":"1234567890123456789012345678901234",
// //     "bic":"123456789",
// //     "firstName":"lakshay",
// //     "lastName":"bansal",
// //     "email":"test@gmail.com"
    
// // },
// // ]