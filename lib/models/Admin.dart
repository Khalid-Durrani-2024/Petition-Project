import 'package:flutter/material.dart';

class Admin {
 final String id, name, email, password, role;

  Admin(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.role});
  factory Admin.fromMap(Map<String, dynamic> json) {
    return Admin(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role']);
  }
  static List<Admin> fromMapList(List<dynamic> mapList) {
    return mapList.map((e) => Admin.fromMap(e)).toList();
  }
}
