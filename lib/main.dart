import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Doğrulama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kullanıcı Bilgileri Formu'),
        ),
        body: UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  // Form anahtarı tanımlanır
  final _formKey = GlobalKey<FormState>();

  // TextFormField için kontrolcüler
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // E-posta doğrulaması için RegExp deseni
  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  // Formu gönderme işlemi
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Tüm alanlar doğrulanırsa, form gönderimi yapılabilir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form başarıyla gönderildi!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // İsim Alanı
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'İsim'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen isminizi girin';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            // E-posta Alanı
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen e-posta adresinizi girin';
                } else if (!emailRegex.hasMatch(value)) {
                  return 'Geçerli bir e-posta adresi girin';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            // Şifre Alanı
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen şifrenizi girin';
                } else if (value.length < 6) {
                  return 'Şifre en az 6 karakter olmalı';
                }
                return null;
              },
            ),
            SizedBox(height: 32.0),
            // Formu Gönder Butonu
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Gönder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
