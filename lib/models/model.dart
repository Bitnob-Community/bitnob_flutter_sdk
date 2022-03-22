class ModelClass {
  bool? status;
  String? message;
  Data? data;

  ModelClass({status, message, data});

  ModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? reference;
  String? satAmount;
  String? satAmountPaid;
  String? description;
  String? status;
  String? expiresAt;
  String? lightningExpiresAt;
  String? callbackUrl;
  String? successUrl;
  String? lightning;
  String? address;
  Customer? customer;
  String? companyName;
  String? companyLogo;
  String? btcAmount;
  String? amount;
  String? previewLink;

  Data(
      {id,
      createdAt,
      updatedAt,
      reference,
      satAmount,
      satAmountPaid,
      description,
      status,
      expiresAt,
      lightningExpiresAt,
      callbackUrl,
      successUrl,
      lightning,
      address,
      customer,
      companyName,
      companyLogo,
      btcAmount,
      amount,
      previewLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    reference = json['reference'];
    satAmount = json['satAmount'];
    satAmountPaid = json['satAmountPaid'];
    description = json['description'];
    status = json['status'];
    expiresAt = json['expiresAt'];
    lightningExpiresAt = json['lightningExpiresAt'];
    callbackUrl = json['callbackUrl'];
    successUrl = json['successUrl'];
    lightning = json['lightning'];
    address = json['address'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    companyName = json['companyName'];
    companyLogo = json['companyLogo'];
    btcAmount = json['btcAmount'];
    amount = json['amount'];
    previewLink = json['previewLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['reference'] = reference;
    data['satAmount'] = satAmount;
    data['satAmountPaid'] = satAmountPaid;
    data['description'] = description;
    data['status'] = status;
    data['expiresAt'] = expiresAt;
    data['lightningExpiresAt'] = lightningExpiresAt;
    data['callbackUrl'] = callbackUrl;
    data['successUrl'] = successUrl;
    data['lightning'] = lightning;
    data['address'] = address;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['companyName'] = companyName;
    data['companyLogo'] = companyLogo;
    data['btcAmount'] = btcAmount;
    data['amount'] = amount;
    data['previewLink'] = previewLink;
    return data;
  }
}

class Customer {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  bool? blacklist;

  Customer(
      {id,
      createdAt,
      updatedAt,
      firstName,
      lastName,
      email,
      phone,
      countryCode,
      blacklist});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    blacklist = json['blacklist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['countryCode'] = countryCode;
    data['blacklist'] = blacklist;
    return data;
  }
}
