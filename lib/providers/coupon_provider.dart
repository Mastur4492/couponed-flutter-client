import 'package:flutter/material.dart';

class CouponProvider extends ChangeNotifier {
  final Set<int> _claimedCoupons = {};

  bool isClaimed(int id) {
    return _claimedCoupons.contains(id);
  }

  void claimCoupon(int id) {
    _claimedCoupons.add(id);
    notifyListeners();
  }
}