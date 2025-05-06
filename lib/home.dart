import 'package:flutter/material.dart';
import 'borobudur.dart';
import 'prambanan.dart';
import 'parangtritis.dart';
import 'login.dart';

//Stateless Widget
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi untuk navigasi ke halaman destinasi wisata
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // StatelessWidget
      body: Stack( // StatelessWidget - menumpuk gambar, overlay, dan konten
        fit: StackFit.expand,
        children: [
          Image.asset( // StatelessWidget - menampilkan gambar background
            'images/gunung.jpg',
            fit: BoxFit.cover,
          ),
          Container( // StatelessWidget - overlay hitam di atas gambar
            color: Colors.black.withOpacity(0.6),
          ),
          Center( // StatelessWidget - memusatkan konten
            child: SingleChildScrollView( // StatelessWidget - scroll
              padding: const EdgeInsets.all(24.0),
              child: Column( // StatelessWidget - menyusun elemen secara vertikal
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text( // StatelessWidget - judul
                    "Welcome to Destination Guide",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32), // Jarak antar elemen

                  // Kartu destinasi Borobudur
                  _buildDestinationCard(
                    context,
                    imagePath: 'images/borobudur.jpg',
                    title: 'Borobudur Temple',
                    onTap: () => _navigateTo(context, const BorobudurPage()),
                  ),

                  const SizedBox(height: 16), // Jarak antar kartu

                  // Kartu destinasi Prambanan
                  _buildDestinationCard(
                    context,
                    imagePath: 'images/prambanan.jpg',
                    title: 'Prambanan Temple',
                    onTap: () => _navigateTo(context, const PrambananPage()),
                  ),

                  const SizedBox(height: 16),

                  // Kartu destinasi Parangtritis
                  _buildDestinationCard(
                    context,
                    imagePath: 'images/parangtritis.jpg',
                    title: 'Parangtritis Beach',
                    onTap: () => _navigateTo(context, const ParangtritisPage()),
                  ),

                  const SizedBox(height: 16),

                  // Kartu destinasi Coming Soon
                  _buildDestinationCard(
                    context,
                    imagePath: 'images/gunung.jpg',
                    title: 'Comingsoon',
                    onTap: () {
                      // Menampilkan notifikasi snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Halaman Mendut belum tersedia"),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Tombol Logout
                  ElevatedButton( // StatelessWidget
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Navigasi ke LoginPage dan menghapus semua halaman sebelumnya
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat kartu wisata
  Widget _buildDestinationCard(
      BuildContext context, {
        required String imagePath,
        required String title,
        required VoidCallback onTap,
      }) {
    return Card( // StatelessWidget - Kartu destinasi
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell( // StatelessWidget - Efek sentuh
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row( // Menyusun gambar dan teks secara horizontal
          children: [
            ClipRRect( // StatelessWidget - gambar dengan sudut bulat
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text( // Judul destinasi
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
