import 'package:flutter/material.dart';
import '../models/device_item.dart';
import '../widgets/app_nav_bar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final device = ModalRoute.of(context)!.settings.arguments as DeviceItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          device.title,
          style: const TextStyle(fontFamily: 'Pacifico', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      bottomNavigationBar: const AppNavBar(selectedIndex: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(device.image, height: 200),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              device.description,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
