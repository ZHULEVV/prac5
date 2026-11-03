import 'package:flutter/material.dart';

import '../models/device_item.dart';

const List<DeviceItem> devices = [
  DeviceItem(
    title: 'Смартфон',
    description: 'Карманное устройство для звонков, интернета и приложений',
    image: 'assets/images/smartphone.jpg',
    icon: Icons.smartphone,
  ),
  DeviceItem(
    title: 'Ноутбук',
    description: 'Портативный компьютер для работы и учёбы',
    image: 'assets/images/laptop.jpeg',
    icon: Icons.laptop,
  ),
  DeviceItem(
    title: 'Планшет',
    description: 'Сенсорное устройство для чтения, видео и рисования',
    image: 'assets/images/tablet.jpeg',
    icon: Icons.tablet_mac,
  ),
  DeviceItem(
    title: 'Умные часы',
    description: 'Носимое устройство с уведомлениями и датчиками здоровья',
    image: 'assets/images/smartwatch.jpg',
    icon: Icons.watch,
  ),
];
