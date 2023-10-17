import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(18),
                  top: ScreenUtil().setHeight(35)),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.app_color,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(55),
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(22)),
                  ),
                ],
              )),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            child: Text(
              'PRIVACY POLICY',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              'UrbanMalta.com ("us", "we", or "our") operates the http://www.urbanmalta.com website (the "Service"). This page informs you of our policies regarding the collection, use and disclosure of Personal Information when you use our Service. We will not use or share your information with anyone except as described in this Privacy Policy.We use your Personal Information for providing and improving the Service. By using the Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, accessible at http://www.urbanmalta.com',
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              'Information Collection And Use',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              'While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you. Personally identifiable information may include, but is not limited to, your name, phone number, postal address, other information ("Personal Information").',
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              'Log Data',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "We collect information that your browser sends whenever you visit our Service (Log Data). This Log Data may include information such as your computer's Internet Protocol (IP) address, browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages and other statistics.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              'Cookies',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "Cookies are files with a small amount of data, which may include an anonymous unique identifier. Cookies are sent to your browser from a web site and stored on your computer's hard drive. We use cookies to collect information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              'Service Providers',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "We may employ third party companies and individuals to facilitate our Service, to provide the Service on our behalf, to perform Service-related services or to assist us in analysing how our Service is used. These third parties have access to your Personal Information only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              'Security',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "The security of your Personal Information is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Information, we cannot guarantee its absolute security.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              'Links To Other Sites',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "Our Service may contain links to other sites that are not operated by us. If you click on a third party link, you will be directed to that third party's site. We strongly advise you to review the Privacy Policy of every site you visit. We have no control over, and assume no responsibility for the content, privacy policies or practices of any third party sites or services.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              "Children's Privacy",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "Our Service does not address anyone under the age of 13 (Children). We do not knowingly collect personally identifiable information from children under 13. If you are a parent or guardian and you are aware that your Children have provided us with Personal Information, please contact us. If we discover that a Children under 13 has provided us with Personal Information, we will delete such information from our servers immediately.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              "User's Location and Background Location Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "When you use the Platform, we may collect general location information (such as IP address). If you install our mobile app, we may ask you to grant us access to your mobile device's geolocation data. If you grant such permission, we may collect information about your precise geolocation, and we may use that information to improve the Platform, including providing you with location-based features (e.g. for identification of Pro Services available near you). UrbanMalta may use the user's background location data to match the nearest service provider with each reservation when customers request services through UrbanMalta. UrbanMalta may use and store user's background location data to track service provider's location and navigate Service Provider to the customer's location where service is requested. User's background location data is not being used for promotional activities.If you access the Platform through a mobile device and you do not want your device to provide us with location-tracking information, you can disable the GPS or other location-tracking functions on your device, provided your device allows you to do this. See your device manufacturer's instructions for further details. If you disable certain functions, you may be unable to use certain parts of the Platform.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              "Changes To This Privacy Policy",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10)),
            child: Text(
              "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), top: 10.h),
            child: Text(
              "Contact Us",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.grey.shade800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(10),
                bottom: 50.h),
            child: Text(
              "If you have any questions about this Privacy Policy, please contact us.",
              // textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey),
            ),
          )
        ]),
      ),
    );
  }
}
