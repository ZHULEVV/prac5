import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/devices_bloc.dart';
import '../../models/device_item.dart';
import '../../routes.dart';
import '../../widgets/app_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<String> _images = [
    'assets/images/devices.jpg',
    'assets/images/smartphone.jpg',
    'assets/images/laptop.jpeg',
    'assets/images/tablet.jpeg',
    'assets/images/smartwatch.jpg',
  ];

  Widget _buildCard(BuildContext context, DeviceItem device) {
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
        onTap: () =>
            Navigator.pushNamed(context, Routes.detail, arguments: device),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final double platformPadding =
        (kIsWeb ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux)
        ? 50
        : 20;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Электронные устройства',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      bottomNavigationBar: const AppNavBar(selectedIndex: 0),
      body: BlocBuilder<DevicesBloc, DevicesState>(
        builder: (context, state) {
          switch (state) {
            case DevicesInitial():
              return const Center(child: Text('Данные еще не загружены'));
            case DevicesLoading():
              return const Center(child: CircularProgressIndicator());
            case DevicesError(:final message):
              return Center(child: Text(message));
            case DevicesLoaded(:final devices):
              if (devices.isEmpty) {
                return const Center(child: Text('Список пуст'));
              }
              return SingleChildScrollView(
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: platformPadding),
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
                    SizedBox(height: platformPadding),
                    SizedBox(
                      height: 160,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(_images[index], height: 160),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: platformPadding),
                    if (width > 600)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: devices.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 96,
                            ),
                        itemBuilder: (context, index) =>
                            _buildCard(context, devices[index]),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: devices.length,
                        itemBuilder: (context, index) =>
                            _buildCard(context, devices[index]),
                      ),
                    SizedBox(height: platformPadding),
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
              );
          }
        },
      ),
    );
  }
}
