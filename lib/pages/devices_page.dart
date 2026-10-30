import 'package:flutter/material.dart';

import 'profile_page.dart';

class DeviceItem {
  final String title;
  final String description;
  final IconData icon;

  const DeviceItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  static const List<String> _images = [
    'assets/images/devices.jpg',
    'assets/images/smartphone.jpg',
    'assets/images/laptop.jpeg',
    'assets/images/tablet.jpeg',
    'assets/images/smartwatch.jpg',
  ];

  static const List<DeviceItem> _devices = [
    DeviceItem(
      title: 'Смартфон',
      description: 'Карманное устройство для звонков, интернета и приложений',
      icon: Icons.smartphone,
    ),
    DeviceItem(
      title: 'Ноутбук',
      description: 'Портативный компьютер для работы и учёбы',
      icon: Icons.laptop,
    ),
    DeviceItem(
      title: 'Планшет',
      description: 'Сенсорное устройство для чтения, видео и рисования',
      icon: Icons.tablet_mac,
    ),
    DeviceItem(
      title: 'Умные часы',
      description: 'Носимое устройство с уведомлениями и датчиками здоровья',
      icon: Icons.watch,
    ),
  ];

  void _showDeviceSnackBar(BuildContext context, String title) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Вы выбрали: $title'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Электронные устройства',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Профиль',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Электронные устройства',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Электронные устройства — это приборы, использующие '
                'электронные компоненты (процессоры, память, датчики) '
                'для обработки, хранения и передачи информации. К ним '
                'относятся смартфоны, ноутбуки, планшеты и умные часы.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(_images[index], height: 160),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: ListTile(
                    leading: Icon(device.icon, color: Colors.blueGrey),
                    title: Text(device.title),
                    subtitle: Text(device.description),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () => _showDeviceSnackBar(context, device.title),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Жулёв Егор, ИКБО-63-23'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
