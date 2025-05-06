import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Kunci form untuk validasi
  final TextEditingController _emailController = TextEditingController(); // input email
  final TextEditingController _passwordController = TextEditingController(); // input password

  // Fungsi untuk menjalankan login
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement( // Navigasi menuju ke HomePage setelah login
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // StatelessWidget
      body: Stack( // Menumpuk elemen latar dan konten
        fit: StackFit.expand,
        children: [
          Image.asset( // StatelessWidget
            'images/gunung.jpg',
            fit: BoxFit.cover,
          ),
          Container( // StatelessWidget
            color: Colors.black.withOpacity(0.6),
          ),
          Center( // StatelessWidget
            child: SingleChildScrollView( // StatelessWidget
              padding: const EdgeInsets.all(24.0),
              child: Card( // StatelessWidget
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form( // StatefulWidget bawaan Flutter
                    key: _formKey,
                    child: Column( // StatelessWidget
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon( // StatelessWidget
                          Icons.person,
                          size: 80,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(height: 16),
                        const Text( // StatelessWidget
                          'Selamat Datang!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Input email (StatefulWidget)
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Input password (StatefulWidget)
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Tombol login (StatelessWidget)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
