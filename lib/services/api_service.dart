import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coupon.dart';

class ApiService {
  static const String baseUrl = "https://coupon-backend-api.onrender.com";

  static Future<List<Coupon>> fetchCoupons() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/coupons"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Coupon.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load coupons");
    }
  }
}