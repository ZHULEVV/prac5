import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home/bloc/devices_bloc.dart';
import 'routes.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Электронные устройства',
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (_) => const LoadingPage(),
        Routes.login: (_) => const LoginPage(),
        Routes.register: (_) => const RegisterPage(),
        Routes.home: (_) => BlocProvider(
          create: (_) => DevicesBloc()..add(const LoadDevicesEvent()),
          child: const HomePage(),
        ),
        Routes.detail: (_) => const DetailPage(),
        Routes.profile: (_) => const ProfilePage(),
      },
    );
  }
}
