import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_field.dart';
import '../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();

      if (!AppUser.isRegistered) {
        messenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Аккаунт не найден. Сначала зарегистрируйтесь'),
          ),
        );
        return;
      }
      if (!AppUser.checkCredentials(
        _emailController.text.trim(),
        _passwordController.text,
      )) {
        messenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Неверный email или пароль'),
          ),
        );
        return;
      }

      messenger.showSnackBar(const SnackBar(content: Text('Вход выполнен')));
      Navigator.pushReplacementNamed(context, Routes.home);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Добро пожаловать!\n'
                        'Войдите в свой аккаунт\n'
                        'Или создайте новый',
                        style: TextStyle(fontSize: 22, height: 1.3),
                      ),
                      const SizedBox(height: 48),
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
                        textInputAction: TextInputAction.done,
                        onSubmitted: _submit,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Восстановление пароля пока недоступно',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Забыли пароль?',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: PrimaryButton(text: 'Войти', onPressed: _submit),
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
                  const Text('Нет аккаунта? '),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.register),
                    child: const Text(
                      'Зарегистрируйтесь',
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
