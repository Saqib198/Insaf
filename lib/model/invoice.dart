
import 'package:flutter/material.dart';
import '/model/customer.dart';
import '/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;
  final Image image;
  final double Received;
  final double Discount;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
    required this.image,
    required this.Received,
    required this.Discount,


  });
}

class InvoiceInfo {
  final String number;
  final DateTime date;

  const InvoiceInfo({
    required this.number,
    required this.date,
  });
}

class InvoiceItem {
  final String description;

  final double unitPrice;

  const InvoiceItem({
    required this.description,

    required this.unitPrice,
  });
}
