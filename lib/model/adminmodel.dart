// To parse this JSON data, do
//
//     final adminProfile = adminProfileFromJson(jsonString);

import 'dart:convert';

List<AdminProfile> adminProfileFromJson(String str) => List<AdminProfile>.from(json.decode(str).map((x) => AdminProfile.fromJson(x)));

String adminProfileToJson(List<AdminProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminProfile {
  AdminProfile({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.image,
    this.billingAddress,
  });

  int ?id;
  String? name;
  String ?email;
  String ?contact;
  String ?image;
  BillingAddress ?billingAddress;

  factory AdminProfile.fromJson(Map<String, dynamic> json) => AdminProfile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    image: json["image"],
    billingAddress: BillingAddress.fromJson(json["billing_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "contact": contact,
    "image": image,
    "billing_address": billingAddress!.toJson(),
  };
}

class BillingAddress {
  BillingAddress({
    this.contact,
    this.area,
    this.appartment,
    this.house,
    this.road,
    this.city,
    this.district,
    this.zipCode,
  });

  String ?contact;
  String ?area;
  String ?appartment;
  String ?house;
  String ?road;
  String ?city;
  String ?district;
  String ?zipCode;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    contact: json["contact"],
    area: json["area"],
    appartment: json["appartment"],
    house: json["house"],
    road: json["road"],
    city: json["city"],
    district: json["district"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact,
    "area": area,
    "appartment": appartment,
    "house": house,
    "road": road,
    "city": city,
    "district": district,
    "zip_code": zipCode,
  };
}
