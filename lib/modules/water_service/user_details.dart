
import 'package:flutter/material.dart';


class UserDetails {
  int? id;
  int? localId;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  var nameCtrl = TextEditingController();
  var fatherNameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var streetCtrl = TextEditingController();
  var zipCodeCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();

  UserDetails(
      {this.id,
        this.localId,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localId = json['localId'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['localId'] = this.localId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  String? street;
  String? zipcode;

  Address({this.street, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['zipcode'] = this.zipcode;
    return data;
  }
}

