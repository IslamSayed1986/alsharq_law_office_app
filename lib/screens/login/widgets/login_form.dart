import 'package:alsharq_law_office_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:alsharq_law_office_app/screens/login/widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    if (!value.contains('@')) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement login logic
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Remember Me: $_rememberMe');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'الدخول إلى حسابك',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          CustomTextField(
            label: 'البريد الإلكتروني*',
            hint: 'أدخل بريدك الإلكتروني',
            controller: _emailController,
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'كلمة المرور*',
            hint: 'أدخل كلمة المرور',
            isPassword: true,
            controller: _passwordController,
            validator: _validatePassword,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                },
              ),
              const Text('تذكرني'),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
