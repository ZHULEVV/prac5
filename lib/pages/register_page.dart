import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_field.dart';
import 'devices_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      AppUser.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Регистрация прошла успешно')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DevicesPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Регистрация',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
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
                        onSubmitted: _submit,
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: 'Зарегистрироваться',
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Уже есть аккаунт? '),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Войдите',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
