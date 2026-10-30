import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_field.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: AppUser.name);
  final _emailController = TextEditingController(text: AppUser.email);
  final _passwordController = TextEditingController(text: AppUser.password);
  final _confirmController = TextEditingController(text: AppUser.password);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      AppUser.name = _nameController.text.trim();
      AppUser.email = _emailController.text.trim();
      AppUser.password = _passwordController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные профиля сохранены')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.black,
            child: Icon(Icons.chevron_left, color: Colors.white, size: 22),
          ),
        ),
        title: const Text(
          'Профиль',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.person, size: 64, color: Colors.grey),
                  ),
                  const Icon(Icons.photo_camera_outlined,
                      size: 32, color: Colors.black54),
                ],
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                inputType: InputFieldType.name,
                labelText: 'ФИО',
                hintText: 'Введите ваше имя',
                prefixIcon: const Icon(Icons.person_outline),
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.email,
                labelText: 'Email',
                hintText: 'example@mail.com',
                prefixIcon: const Icon(Icons.mail_outline),
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.password,
                labelText: 'Пароль',
                hintText: 'Пароль не менее 6 символов',
                prefixIcon: const Icon(Icons.security),
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.confirmPassword,
                labelText: 'Повторите пароль',
                hintText: 'Повторите пароль',
                prefixIcon: const Icon(Icons.security),
                controller: _confirmController,
                compareController: _passwordController,
                textInputAction: TextInputAction.done,
                onSubmitted: _save,
              ),
              const SizedBox(height: 32),
              PrimaryButton(text: 'Сохранить', onPressed: _save),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Выйти из аккаунта',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
