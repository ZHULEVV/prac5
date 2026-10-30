import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;

  final TextEditingController? compareController;

  final TextInputAction textInputAction;

  final VoidCallback? onSubmitted;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.compareController,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  static final RegExp _nameReg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');
  static final RegExp _emailReg = RegExp(r'^[^@\s]+@[^@\s.]+(\.[^@\s.]+)+$');
  static final RegExp _letterReg = RegExp(r'[A-Za-zА-Яа-яЁё]');
  static final RegExp _digitReg = RegExp(r'\d');
  static final RegExp _symbolReg = RegExp(r'[+_\-]');

  bool get _isPassword =>
      widget.inputType == InputFieldType.password ||
      widget.inputType == InputFieldType.confirmPassword;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        if (!_nameReg.hasMatch(value)) {
          return 'Имя должно содержать только буквы и пробелы';
        }
      case InputFieldType.email:
        if (!_emailReg.hasMatch(value.trim())) {
          return 'Введите корректный email';
        }
      case InputFieldType.password:
        if (value.length < 6) {
          return 'Пароль должен быть не менее 6 символов';
        }
        if (!_letterReg.hasMatch(value)) {
          return 'Пароль должен содержать буквы';
        }
        if (!_digitReg.hasMatch(value)) {
          return 'Пароль должен содержать цифры';
        }
        if (!_symbolReg.hasMatch(value)) {
          return 'Пароль должен содержать символ (+, _ или -)';
        }
      case InputFieldType.confirmPassword:
        if (value != widget.compareController?.text) {
          return 'Пароли не совпадают';
        }
    }
    return null;
  }

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isPassword && _hidePassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (_) => widget.onSubmitted?.call(),
      validator: _validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.black54),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        prefixIcon: widget.prefixIcon,
        suffixIcon: _isPassword
            ? ExcludeFocus(
                child: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                ),
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: _border(Colors.black, 1.5),
        focusedBorder: _border(Colors.black, 2.5),
        errorBorder: _border(Colors.red, 1.5),
        focusedErrorBorder: _border(Colors.red, 2.5),
      ),
    );
  }
}
