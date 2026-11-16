import 'package:flutter/material.dart';

import '../utils/validators.dart';

/// Form sederhana untuk mencoba validator input.
class ValidationTestScreen extends StatefulWidget {
  const ValidationTestScreen({super.key});

  @override
  State<ValidationTestScreen> createState() => _ValidationTestScreenState();
}

class _ValidationTestScreenState extends State<ValidationTestScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Uji Validasi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor telepon',
                hintText: '10-13 digit',
                border: OutlineInputBorder(),
              ),
              validator: Validators.validatePhone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'URL',
                hintText: 'https://example.com',
                border: OutlineInputBorder(),
              ),
              validator: Validators.validateUrl,
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Min. 8 karakter, huruf besar, angka, simbol',
                border: OutlineInputBorder(),
              ),
              validator: Validators.validatePassword,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semua input valid.')),
                  );
                }
              },
              child: const Text('Periksa Input'),
            ),
          ],
        ),
      ),
    );
  }
}
