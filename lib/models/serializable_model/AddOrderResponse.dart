// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) => AddOrderResponse.fromJson(json.decode(str));

String addOrderResponseToJson(AddOrderResponse data) => json.encode(data.toJson());

class AddOrderResponse {
    AddOrderResponse({
        required this.status,
        this.orderData,
        this.message,
        this.stripeintent,
    });

    bool status;
    OrderData? orderData;
    String? message;
    Stripeintent? stripeintent;

    factory AddOrderResponse.fromJson(Map<String, dynamic> json) => AddOrderResponse(
        status: json["status"],
        orderData: json["order_data"] == null ? null : OrderData.fromJson(json["order_data"]),
        message: json["message"],
        stripeintent: json["stripeintent"] == null ? null : Stripeintent.fromJson(json["stripeintent"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "order_data": orderData?.toJson(),
        "message": message,
        "stripeintent": stripeintent?.toJson(),
    };
}

class OrderData {
    OrderData({
        this.location,
        this.totalPrice,
        this.providerId,
        this.lattitude,
        this.longitude,
        this.apartment_number,
        this.phone_number,
        this.serviceId,
        this.userId,
        this.address,
        this.currency,
        this.serviceFee,
        this.time,
        this.rating,
        this.updatedAt,
        this.createdAt,
        this.date,
        this.id,
        this.type,
    });

    String? location;
    String? totalPrice;
    String? providerId;
    String? serviceId;
    String? userId;
    String? address;
    String? currency;
    String? serviceFee;
    DateTime? time;
    double? rating;
    DateTime? updatedAt;
    DateTime? createdAt;
    String? apartment_number;
    String? phone_number;
    String? lattitude;
    String? longitude;
    String?  date;
    String? type;

    int? id;

    factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        location: json["location"],
        totalPrice: json["total_price"],
        providerId: json["provider_id"],
        serviceId: json["service_id"],
        userId: json["user_id"],
        date: json["date"],
        address: json["address"],
        apartment_number : json['apartment_number'],
        phone_number : json['phone_number'],
        lattitude : json['lattitude'],
        longitude : json['longitude'],
        currency: json["currency"],
        serviceFee: json["service_fee"],
        time: json["time"].runtimeType==String ? DateTime.parse(json["time"]) : json["time"],
        rating: json["rating"]?.toDouble(),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        type: json['type'],
        
    );

    Map<String, dynamic> toJson() => {
        "location": location,
        "lattitude" : lattitude,
        "longitude" : longitude,
        "phone_number" : phone_number,
        "apartment_number" : apartment_number,
        "total_price": totalPrice,
        "provider_id": providerId,
        "service_id": serviceId,
        "date" :date,
        "user_id": userId,
        "address": address,
        "currency": currency,
        "service_fee": serviceFee,
        "time": time?.toIso8601String(),
        "rating": rating,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "type": type,
    };
}

class Stripeintent {
    Stripeintent({
        this.id,
        this.object,
        this.allowedSourceTypes,
        this.amount,
        this.amountCapturable,
        this.amountDetails,
        this.amountReceived,
        this.application,
        this.applicationFeeAmount,
        this.automaticPaymentMethods,
        this.canceledAt,
        this.cancellationReason,
        this.captureMethod,
        this.charges,
        this.clientSecret,
        this.confirmationMethod,
        this.created,
        this.currency,
        this.customer,
        this.description,
        this.invoice,
        this.lastPaymentError,
        this.latestCharge,
        this.livemode,
        this.metadata,
        this.nextAction,
        this.nextSourceAction,
        this.onBehalfOf,
        this.paymentMethod,
        this.paymentMethodOptions,
        this.paymentMethodTypes,
        this.processing,
        this.receiptEmail,
        this.review,
        this.setupFutureUsage,
        this.shipping,
        this.source,
        this.statementDescriptor,
        this.statementDescriptorSuffix,
        this.status,
        this.transferData,
        this.transferGroup,
    });

    String? id;
    String? object;
    List<String>? allowedSourceTypes;
    int? amount;
    int? amountCapturable;
    AmountDetails? amountDetails;
    int? amountReceived;
    dynamic application;
    dynamic applicationFeeAmount;
    AutomaticPaymentMethods? automaticPaymentMethods;
    dynamic canceledAt;
    dynamic cancellationReason;
    String? captureMethod;
    Charges? charges;
    String? clientSecret;
    String? confirmationMethod;
    int? created;
    String? currency;
    String? customer;
    dynamic description;
    dynamic invoice;
    dynamic lastPaymentError;
    dynamic latestCharge;
    bool? livemode;
    List<dynamic>? metadata;
    dynamic nextAction;
    dynamic nextSourceAction;
    dynamic onBehalfOf;
    dynamic paymentMethod;
    PaymentMethodOptions? paymentMethodOptions;
    List<String>? paymentMethodTypes;
    dynamic processing;
    dynamic receiptEmail;
    dynamic review;
    dynamic setupFutureUsage;
    dynamic shipping;
    dynamic source;
    dynamic statementDescriptor;
    dynamic statementDescriptorSuffix;
    String? status;
    dynamic transferData;
    dynamic transferGroup;

    factory Stripeintent.fromJson(Map<String, dynamic> json) => Stripeintent(
        id: json["id"],
        object: json["object"],
        allowedSourceTypes: json["allowed_source_types"] == null ? [] : List<String>.from(json["allowed_source_types"]!.map((x) => x)),
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountDetails: json["amount_details"] == null ? null : AmountDetails.fromJson(json["amount_details"]),
        amountReceived: json["amount_received"],
        application: json["application"],
        applicationFeeAmount: json["application_fee_amount"],
        automaticPaymentMethods: json["automatic_payment_methods"] == null ? null : AutomaticPaymentMethods.fromJson(json["automatic_payment_methods"]),
        canceledAt: json["canceled_at"],
        cancellationReason: json["cancellation_reason"],
        captureMethod: json["capture_method"],
        charges: json["charges"] == null ? null : Charges.fromJson(json["charges"]),
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        invoice: json["invoice"],
        lastPaymentError: json["last_payment_error"],
        latestCharge: json["latest_charge"],
        livemode: json["livemode"],
        metadata: json["metadata"] == null ? [] : List<dynamic>.from(json["metadata"]!.map((x) => x)),
        nextAction: json["next_action"],
        nextSourceAction: json["next_source_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodOptions: json["payment_method_options"] == null ? null : PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes: json["payment_method_types"] == null ? [] : List<String>.from(json["payment_method_types"]!.map((x) => x)),
        processing: json["processing"],
        receiptEmail: json["receipt_email"],
        review: json["review"],
        setupFutureUsage: json["setup_future_usage"],
        shipping: json["shipping"],
        source: json["source"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "allowed_source_types": allowedSourceTypes == null ? [] : List<dynamic>.from(allowedSourceTypes!.map((x) => x)),
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_details": amountDetails?.toJson(),
        "amount_received": amountReceived,
        "application": application,
        "application_fee_amount": applicationFeeAmount,
        "automatic_payment_methods": automaticPaymentMethods?.toJson(),
        "canceled_at": canceledAt,
        "cancellation_reason": cancellationReason,
        "capture_method": captureMethod,
        "charges": charges?.toJson(),
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "invoice": invoice,
        "last_payment_error": lastPaymentError,
        "latest_charge": latestCharge,
        "livemode": livemode,
        "metadata": metadata == null ? [] : List<dynamic>.from(metadata!.map((x) => x)),
        "next_action": nextAction,
        "next_source_action": nextSourceAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_options": paymentMethodOptions?.toJson(),
        "payment_method_types": paymentMethodTypes == null ? [] : List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
        "processing": processing,
        "receipt_email": receiptEmail,
        "review": review,
        "setup_future_usage": setupFutureUsage,
        "shipping": shipping,
        "source": source,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
    };
}

class AmountDetails {
    AmountDetails({
        this.tip,
    });

    List<dynamic>? tip;

    factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        tip: json["tip"] == null ? [] : List<dynamic>.from(json["tip"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "tip": tip == null ? [] : List<dynamic>.from(tip!.map((x) => x)),
    };
}

class AutomaticPaymentMethods {
    AutomaticPaymentMethods({
        this.enabled,
    });

    bool? enabled;

    factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) => AutomaticPaymentMethods(
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "enabled": enabled,
    };
}

class Charges {
    Charges({
        this.object,
        this.data,
        this.hasMore,
        this.totalCount,
        this.url,
    });

    String? object;
    List<dynamic>? data;
    bool? hasMore;
    int? totalCount;
    String? url;

    factory Charges.fromJson(Map<String, dynamic> json) => Charges(
        object: json["object"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
    };
}

class PaymentMethodOptions {
    PaymentMethodOptions({
        this.bancontact,
        this.card,
        this.ideal,
    });

    Bancontact? bancontact;
    Card? card;
    List<dynamic>? ideal;

    factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
        bancontact: json["bancontact"] == null ? null : Bancontact.fromJson(json["bancontact"]),
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
        ideal: json["ideal"] == null ? [] : List<dynamic>.from(json["ideal"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "bancontact": bancontact?.toJson(),
        "card": card?.toJson(),
        "ideal": ideal == null ? [] : List<dynamic>.from(ideal!.map((x) => x)),
    };
}

class Bancontact {
    Bancontact({
        this.preferredLanguage,
    });

    String? preferredLanguage;

    factory Bancontact.fromJson(Map<String, dynamic> json) => Bancontact(
        preferredLanguage: json["preferred_language"],
    );

    Map<String, dynamic> toJson() => {
        "preferred_language": preferredLanguage,
    };
}

class Card {
    Card({
        this.installments,
        this.mandateOptions,
        this.network,
        this.requestThreeDSecure,
    });

    dynamic installments;
    dynamic mandateOptions;
    dynamic network;
    String? requestThreeDSecure;

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        installments: json["installments"],
        mandateOptions: json["mandate_options"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
    );

    Map<String, dynamic> toJson() => {
        "installments": installments,
        "mandate_options": mandateOptions,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
    };
}
