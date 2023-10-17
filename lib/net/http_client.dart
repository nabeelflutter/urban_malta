import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/FaqModel.dart';
import 'package:kappu/models/serializable_model/GigListResponse.dart';
import 'package:kappu/models/serializable_model/NotificationModel.dart';
import 'package:kappu/models/serializable_model/RecommendedServiceProvidersResponse.dart';
import 'package:kappu/models/serializable_model/TrendingServicesResponse.dart';
import 'package:kappu/models/serializable_model/signup.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../models/serializable_model/AddOrderResponse.dart';
import '../models/serializable_model/CategoryResponse.dart';
import '../models/serializable_model/HelpCenterResponse.dart';
import '../models/serializable_model/OrderListResponse.dart';
import '../models/serializable_model/PopularServiceListResponse.dart';
import '../models/serializable_model/PrivacyPolicyResponse.dart';
import '../models/serializable_model/ServiceResponse.dart';
import '../models/serializable_model/allchats.dart';
import '../models/serializable_model/chat.dart';
import '../models/serializable_model/forget_password_response.dart';
import '../models/serializable_model/provider_detail_model.dart';
import '../models/serializable_model/provider_profile.dart';
import '../models/serializable_model/review.dart';
import 'base_dio.dart';

part 'http_client.g.dart';

@RestApi(baseUrl: "https://urbanmalta.com/api/")
abstract class HttpClient {
  factory HttpClient([Dio? dio, String? baseUrl]) {
    dio = BaseDio.getInstance().getDio();
    return _HttpClient(dio, baseUrl: baseUrl);
  }

  @POST('signup/')
  Future<UserSignUpModel?> signup(@Body() Map<String, dynamic> params);

  @POST('auth/poviderregister/')
  Future<HttpResponse?> providersignup(
      @Body() Map<String, dynamic> params, List<File> gigpath);

  @POST('gig/add')
  Future<HttpResponse?> addGig(
      @Body() Map<String, dynamic> params, List<File> gigpath);

  @POST('gig/edit')
  Future<HttpResponse?> editGig(
      @Body() Map<String, dynamic> params, List<File> gigpath, int id);

  @POST('auth/customerregister')
  Future<HttpResponse?> userSignup(
      @Body() Map<String, dynamic> params, File file);

  @POST('user/profileimage')
  Future<HttpResponse?> UpdateUserProfilePic(File file);

  @POST('user/checkemail')
  Future<HttpResponse?> checkEmail(String email);

  @POST('user/changepassword')
  Future<HttpResponse?> changePassword(String password);

  @POST('auth/login')
  Future<HttpResponse> signin(@Body() Map<String, dynamic> params);

  @POST('auth/login/social')
  Future<HttpResponse> signinSocial(@Body() Map<String, dynamic> params);

  @PATCH('provider/send-otp-email/{id}/')
  Future<HttpResponse> sendotpemail(@Path('id') String id);

  @PATCH('provider/send-otp-sms/{id}/')
  Future<HttpResponse> sendotpphno(@Path('id') String id);

  @PATCH('provider/verify-email/{id}/')
  Future<HttpResponse> varifyotp(
      @Path('id') String id, @Body() Map<String, dynamic> param);

  @POST('provider/forgot-password/')
  Future<ForgetPasswordResponse> varifyemail(
      @Body() Map<String, dynamic> param);

  @POST('provider/check-otp/')
  Future<HttpResponse> variftyemailOrPhoneOTP(
      @Body() Map<String, dynamic> params);

  @PATCH('provider/forgot-password/{id}/')
  Future<HttpResponse> resetpassword(
      @Path('id') String id, @Body() Map<String, dynamic> params);

  @GET('getservices')
  Future<ServiceResponse> getservicecatagory();

  @GET('allcat')
  Future<CategoryResponse> getCatagory();

  @GET('faqs')
  Future<List<FaqModel>> getFaqs();

  @GET('helpcenter')
  Future<List<HelpCenterResponse>> getHelpCenter();

  @GET('privacypolicy')
  Future<PrivacyPolicyResponse> getPrivayPolicy();

  @GET('getpopuplerservices')
  Future<List<PopularServiceListResponse>> getPopularServices(
      @Query("lat") String lat,
      @Query("lng") String lng,
      );

  @GET('gig/list')
  Future<List<GigListResponse>> getGigList();

  @GET('trending/profile')
  Future<List<TrendingServicesResponse>> getTrendingCatagory();

  @POST('services/getservices')
  Future<List<RecommendedServiceProvidersResponse>>
      getRecommendedServiceProviders(categoryid,double lat,double lng);

  @POST('servicesprovider/desc')
  Future<List<RecommendedServiceProvidersResponse>> searchServiceProviders(
      String text);

  @POST('services/details')
  Future<List<ProviderDetailModel>> getServiceProviderDetail(serviceProviderId);

  @POST('services/recommended')
  Future<List<RecommendedServiceProvidersResponse>> getRelatedProviders(
      catId, serviceProviderId);

  @POST('user/notifications')
  Future<List<NotificationModel>> getNotifications(userId, token);

  @POST('user/deleteaccount')
  Future<HttpResponse?> deleteAccount();

  @POST('orders/completed')
  Future<List<OrderListResponse>> getcompletedbooking(
      String providerId, String token, String by);

  @POST('orders/cancelled')
  Future<List<OrderListResponse>> getCancelledbooking(
      String providerId, String token, String by);

  @POST('orders/requests')
  Future<List<OrderListResponse>> getrequestedbookings(
      String providerId, String token, String by);

  @POST('orders/accpeted')
  Future<List<OrderListResponse>> getActivebookings(
      String providerId, String token, String by);

  @POST('order/add')
  Future<AddOrderResponse> addOrder(
      String location,
      String token,
      String totalPrice,
      String providerId,
      String serviceId,
      String userId,
      String address,
      String currency,
      String serviceFee,
      String lattitude,
      String longitude,
      String apartmentNumber,
      String phoneNumber,
      String date,
      DateTime time,
      String type);

  @POST('order/payment')
  Future<AddOrderResponse> orderPayment(String orderId);

  @POST('orders/provider/requests/accept')
  Future<AddOrderResponse> acceptOrder(String bookingId, String token);

  @POST('orders/provider/requests/cancel')
  Future<AddOrderResponse> cancelOrder(String bookingId, String token);

  @POST('delete')
  Future<AddOrderResponse> deleteGig(String id, String token);

  @POST('orders/provider/requests/completed')
  Future<AddOrderResponse> completeOrder(String bookingId, String token);

  @POST('order/post/review/')
  Future<HttpResponse> addreview(Map<String, dynamic> params, String token) {
    // TODO: implement addreview
    throw UnimplementedError();
  }

  @GET('provider-details/')
  Future<ProviderProfile> getproviderprofile(@Query('id') int id);

  @GET('order/post/review/')
  Future<List<Rating>> getproviderReviews(@Query('provider') int id);

  @GET('user/provider/rattings')
  Future<List<Rating>> getUserReviews(String userId);

  @GET('user/changename')
  Future<AddOrderResponse> updateName(String name);

  @GET('/loadmessages/{threadid}/')
  Future<List<Chat>> getchatwithauser(@Path('threadid') String threadid);

  @GET('/conversation/{userid}/')
  Future<List<AllChats>> getallchats(@Path('userid') String userid);

}
