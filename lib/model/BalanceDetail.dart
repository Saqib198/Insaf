
import 'package:flutter/material.dart';
import '/model/customer.dart';
import '/model/supplier.dart';

class BillDetail {
  final String description;
  final double amount;

  const BillDetail({
    required this.description,
    required this.amount,
  });

}
