import 'package:flutter/material.dart';

class DeviceItem {
  final String title;
  final String description;
  final String image;
  final IconData icon;

  const DeviceItem({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
}
