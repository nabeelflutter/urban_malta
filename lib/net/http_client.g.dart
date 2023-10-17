// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _HttpClient implements HttpClient {
  _HttpClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://urbanmalta.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserSignUpModel?> signup(params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(params);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<UserSignUpModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'signup/',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
    _result.data == null ? null : UserSignUpModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>?> providersignup(params, gigImage) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'multipart/form-data',
    };

    List<Future> list = [];
    for (var i = 0; i < gigImage.length; i++) {
      list.add(
        MultipartFile.fromFile(gigImage[i].path,
            filename: gigImage[i].path.split('/').last),
      );
    }

    var formData = FormData.fromMap({
      'first_name': params['first_name'],
      'last_name': params['last_name'],
      'username': params['username'],
      'email': params['email'],
      'category': params['category'],
      'phone_number': params['phone_number'],
      'password': params['password'],
      'is_provider': params['is_provider'],
      "Age": params['Age'],
      "nationality": params['nationality'],
      "language": params['language'],
      "service_title": params['service_title'],
      "Perhour": params['Perhour'],
      "description": params["description"],
      "Extra_for_urgent_need": params['Extra_for_urgent_need'],
      "fcm_token": params['fcm_token'],
      "os": params['os'],
      "login_src": params['login_src'],
      "social_login_id": params['social_login_id'],
      // "profileFileUpload" :  await MultipartFile.fromFile(gigImage.path, filename: gigImage.path.split('/').last),
      // 'additionaldocuments[]': [
      //   await MultipartFile.fromFile(doc.path, filename: doc.path.split('/').last),
      //   await MultipartFile.fromFile(licence.path, filename: licence.path.split('/').last),
      // ],
      'fileUploadGIG[]': [
        if (gigImage.isNotEmpty)
          await MultipartFile.fromFile(gigImage[0].path,
              filename: gigImage[0].path.split('/').last),
        if (gigImage.length > 1)
          await MultipartFile.fromFile(gigImage[1].path,
              filename: gigImage[1].path.split('/').last),
        if (gigImage.length > 2)
          await MultipartFile.fromFile(gigImage[2].path,
              filename: gigImage[2].path.split('/').last),
        // await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      ]
    });

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'auth/poviderregister',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>?> addGig(params, gigImage) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer " + StorageManager().accessToken
    };

    List<Future> list = [];
    for (var i = 0; i < gigImage.length; i++) {
      list.add(
        MultipartFile.fromFile(gigImage[i].path,
            filename: gigImage[i].path.split('/').last),
      );
    }

    var formData = FormData.fromMap({
      'user_id': StorageManager().userId,
      'title': params['service_title'],
      'description': params['description'],
      'category': params['category'],
      'perhour': params['Perhour'],
      'fileUploadGIG[]': [
        if (gigImage.isNotEmpty)
          await MultipartFile.fromFile(gigImage[0].path,
              filename: gigImage[0].path.split('/').last),
        if (gigImage.length > 1)
          await MultipartFile.fromFile(gigImage[1].path,
              filename: gigImage[1].path.split('/').last),
        if (gigImage.length > 2)
          await MultipartFile.fromFile(gigImage[2].path,
              filename: gigImage[2].path.split('/').last),
        // await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      ]
    });

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'gig/add',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>?> editGig(params, gigImage, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer " + StorageManager().accessToken
    };

    var formData = FormData.fromMap({
      'user_id': StorageManager().userId,
      'title': params['service_title'],
      'description': params['description'],
      'category': params['category'],
      'perhour': params['Perhour'],
      'id': id,
      'fileUploadGIG[]': [
        if (gigImage.isNotEmpty)
          await MultipartFile.fromFile(gigImage[0].path,
              filename: gigImage[0].path.split('/').last),
        if (gigImage.length > 1)
          await MultipartFile.fromFile(gigImage[1].path,
              filename: gigImage[1].path.split('/').last),
        if (gigImage.length > 2)
          await MultipartFile.fromFile(gigImage[2].path,
              filename: gigImage[2].path.split('/').last),
        // await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      ]
    });

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'gig/edit',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>?> userSignup(params, profilePic) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'multipart/form-data',
    };

    var formData = FormData.fromMap({
      'first_name': params['first_name'],
      'last_name': params['last_name'],
      'username': params['username'],
      'email': params['email'],
      'phone_number': params['phone_number'],
      'password': params['password'],
      "nationality": params['nationality'],
      "language": params['language'],
      'lat': params['lat'],
      'lng': params['lng'],
      'location': params['location'],
      "os": params['os'],
      "fcm_token": params['fcm_token'],
      "login_src": params['login_src'],
      "social_login_id": params['social_login_id'],
    });

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'auth/customerregister',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>?> changePassword(String password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer " + StorageManager().accessToken
    };

    var formData =
    FormData.fromMap({'password': password, 'id': StorageManager().userId});

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/changepassword',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> signin(params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(params);
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'auth/login',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> signinSocial(params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(params);
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'auth/login/social',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> deleteAccount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Authorization': 'Bearer ' + StorageManager().accessToken
    };

    var formData = FormData.fromMap({
      'user_id': StorageManager().userId,
    });

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/deleteaccount',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> sendotpemail(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'provider/send-otp-email/${id}/',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> sendotpphno(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'provider/send-otp-sms/${id}/',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> varifyotp(id, param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'provider/verify-email/${id}/',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<ForgetPasswordResponse> varifyemail(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgetPasswordResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'provider/forgot-password/',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgetPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> variftyemailOrPhoneOTP(params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(params);
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'provider/check-otp/',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> resetpassword(id, params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(params);
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'PATCH', headers: _headers, extra: _extra)
            .compose(_dio.options, 'provider/forgot-password/${id}/',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<ServiceResponse> getservicecatagory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ServiceResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'getservices',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return ServiceResponse.fromJson(_result.data!);
  }

  @override
  Future<CategoryResponse> getCatagory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'allcat',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return CategoryResponse.fromJson(_result.data!);
  }

  @override
  Future<List<FaqModel>> getFaqs() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<FaqModel>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'faqs',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return faqModelFromJson(_result.data!);
  }

  @override
  Future<List<HelpCenterResponse>> getHelpCenter() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<HelpCenterResponse>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'helpcenter',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return helpCenterResponseFromJson(_result.data!);
  }

  @override
  Future<PrivacyPolicyResponse> getPrivayPolicy() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(
        _setStreamType<PrivacyPolicyResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'privacypolicy',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return privacyPolicyResponseFromJson(_result.data!);
  }

  @override
  Future<List<PopularServiceListResponse>> getPopularServices(
      lat,
      lng,
      ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lng': lng,
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PopularServiceListResponse>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          'getpopuplerservices',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
        PopularServiceListResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<TrendingServicesResponse>> getTrendingCatagory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(
        _setStreamType<TrendingServicesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'trending/profile',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return trendingResponseFromJson(_result.data!);
  }

  @override
  Future<List<RecommendedServiceProvidersResponse>>
  getRecommendedServiceProviders(id,lat,lng) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    var formData = FormData.fromMap({
      'id': id,
      'lat': lat,
      'lng': lng,
    });

    final _result = await _dio.fetch<String>(
        _setStreamType<RecommendedServiceProvidersResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'services/byid',
                queryParameters: queryParameters, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return recommendedServiceProvidersResponseFromJson(_result.data!);
  }

  @override
  Future<List<RecommendedServiceProvidersResponse>> searchServiceProviders(
      String text) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    var formData = FormData.fromMap({
      'text': text,
    });

    final _result = await _dio.fetch<String>(
        _setStreamType<RecommendedServiceProvidersResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'servicesprovider/desc',
                queryParameters: queryParameters, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return recommendedServiceProvidersResponseFromJson(_result.data!);
  }

  @override
  Future<List<ProviderDetailModel>> getServiceProviderDetail(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    var formData = FormData.fromMap({
      'id': id,
    });
    final _result = await _dio.fetch<String>(
        _setStreamType<ProviderDetailModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'services/details',
                queryParameters: queryParameters, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return providerDetailModelFromJson(_result.data!);
  }

  @override
  Future<List<RecommendedServiceProvidersResponse>> getRelatedProviders(
      catId, userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    var formData = FormData.fromMap({
      'category_id': catId,
      'user_id': userId,
    });
    final _result = await _dio.fetch<String>(
        _setStreamType<RecommendedServiceProvidersResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'services/recommended',
                queryParameters: queryParameters, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return recommendedServiceProvidersResponseFromJson(_result.data!);
  }

  @override
  Future<List<Rating>> getUserReviews(String userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Authorization': 'Bearer ' + StorageManager().accessToken
    };

    var formData = FormData.fromMap({
      'user_id': userId,
    });
    final _result = await _dio.fetch<String>(_setStreamType<Rating>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/provider/rattings',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return ratingFromJson(_result.data!) ;
  }

  @override
  Future<List<GigListResponse>> getGigList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Authorization': 'Bearer ' + StorageManager().accessToken
    };

    var formData = FormData.fromMap({
      'user_id': StorageManager().userId,
    });
    final _result = await _dio.fetch<String>(_setStreamType<GigListResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'gig/list',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return gigListResponseFromJson(_result.data!);
  }

  @override
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
      String type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};

    var formData = FormData.fromMap({
      'location': location,
      'total_price': totalPrice,
      'provider_id': providerId,
      'service_id': serviceId,
      'user_id': userId,
      'address': address,
      'currency': currency,
      'service_fee': serviceFee,
      'customer_stripe_id': StorageManager().stripeId,
      'lattitude': lattitude,
      'longitude': longitude,
      'apartment_number': apartmentNumber,
      'phoneNumber': phoneNumber,
      'date': date,
      'time': time,
      'type': type
    });
    print(formData);
    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'order/add',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    print("***************** ${_result}");
    print(_result);
    final responseData = _result.data; // Extract the data from the Response
    print("***************** ${responseData}");
    print(responseData);

    return addOrderResponseFromJson(responseData!);
  }

  @override
  Future<AddOrderResponse> updateName(String name) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Authorization': 'Bearer ' + StorageManager().accessToken
    };

    var formData = FormData.fromMap(
        {'id': StorageManager().userId, 'first_name': name, 'last_name': ""});

    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/changename',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return addOrderResponseFromJson(_result.data!);
  }

  @override
  Future<HttpResponse?> UpdateUserProfilePic(File file) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + StorageManager().accessToken
    };
    var formData = FormData.fromMap({
      'id': StorageManager().userId,
      'profileFileUpload': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    });

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/profileimage',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse?> checkEmail(String email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Content-Type': 'multipart/form-data',
    };
    var formData = FormData.fromMap({'email': email});

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'user/checkemail',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<AddOrderResponse> orderPayment(String orderId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'Authorization': 'Bearer ' + StorageManager().accessToken
    };

    var formData = FormData.fromMap({'order_id': orderId});

    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'order/payment',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return addOrderResponseFromJson(_result.data!);
  }

  @override
  Future<AddOrderResponse> acceptOrder(String bookingId, String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};

    var formData = FormData.fromMap({
      'booking_id': bookingId,
    });

    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/provider/requests/accept',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return addOrderResponseFromJson(_result.data!);
  }

  @override
  Future<AddOrderResponse> cancelOrder(String bookingId, String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};

    var formData = FormData.fromMap({
      'booking_id': bookingId,
    });

    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/provider/requests/cancel',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return addOrderResponseFromJson(_result.data!);
  }

  @override
  Future<AddOrderResponse> deleteGig(String id, String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};

    var formData = FormData.fromMap({
      'id': id,
    });

    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'gig/delete',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return addOrderResponseFromJson(_result.data!);
  }

  @override
  Future<AddOrderResponse> completeOrder(String bookingId, String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};

    var formData = FormData.fromMap({
      'booking_id': bookingId,
    });

    final _result = await _dio.fetch<String>(_setStreamType<AddOrderResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/provider/requests/completed',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return addOrderResponseFromJson(_result.data!);
  }

  @override
  Future<List<NotificationModel>> getNotifications(id, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    var formData = FormData.fromMap({
      'user_id': id,
    });
    final _result = await _dio.fetch<String>(
        _setStreamType<RecommendedServiceProvidersResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/notifications',
                queryParameters: queryParameters, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return notificationModelFromJson(_result.data!);
  }

  @override
  Future<List<OrderListResponse>> getcompletedbooking(
      providerId, token, String by) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    var formData = FormData.fromMap({
      'user_id': providerId,
      'by': by,
    });
    final _result = await _dio.fetch<String>(_setStreamType<OrderListResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/completed',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    return orderListResponseFromJson(_result.data!);
  }

  @override
  Future<List<OrderListResponse>> getCancelledbooking(
      String providerId, String token, String by) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    var formData = FormData.fromMap({
      'user_id': providerId,
      'by': by,
    });
    final _result = await _dio.fetch<String>(_setStreamType<OrderListResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/cancelled',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    return orderListResponseFromJson(_result.data!);
  }

  @override
  Future<List<OrderListResponse>> getrequestedbookings(
      String providerId, String token, String by) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    var formData = FormData.fromMap({
      'user_id': providerId,
      'by': by,
    });
    final _result = await _dio.fetch<String>(_setStreamType<OrderListResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/requests',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    return orderListResponseFromJson(_result.data!);
  }

  @override
  Future<List<OrderListResponse>> getActivebookings(
      String providerId, String token, String by) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    var formData = FormData.fromMap({
      'user_id': providerId,
      'by': by,
    });
    final _result = await _dio.fetch<String>(_setStreamType<OrderListResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/accpeted',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    return orderListResponseFromJson(_result.data!);
  }

  @override
  Future<List<OrderListResponse>> getrequestsbooking(providerId, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{'Authorization': token};
    var formData = FormData.fromMap({
      'provider_id': providerId,
    });
    final _result = await _dio.fetch<String>(_setStreamType<OrderListResponse>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'orders/provider/cancelled',
            queryParameters: queryParameters, data: formData)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    return orderListResponseFromJson(_result.data!);
  }

  @override
  Future<HttpResponse<dynamic>> addreview(params, String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}',
    };
    final _headers = <String, dynamic>{'Authorization': token};
    final _data = <String, dynamic>{};
    _data.addAll(params);
    print(
        'base url printing ${baseUrl} and from options ${_dio.options.baseUrl} and extras ${_extra} adn qu ${_headers} hea ${_dio.options.headers}order/post/review');

    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'POST', headers: headers, extra: _extra)
            .compose(_dio.options, 'order/post/review',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    print('printing result value ${value}');

    final httpResponse = HttpResponse(value, _result);
    print(' result value ${httpResponse.data.toString()}');

    return httpResponse;
  }

  @override
  Future<ProviderProfile> getproviderprofile(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProviderProfile>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'provider-details/',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProviderProfile.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Rating>> getproviderReviews(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Rating>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/provider/rattings',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Rating.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Chat>> getchatwithauser(threadid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Chat>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/loadmessages/${threadid}/',
            queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Chat.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<AllChats>> getallchats(userid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<AllChats>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/conversation/${userid}/',
                queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => AllChats.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}