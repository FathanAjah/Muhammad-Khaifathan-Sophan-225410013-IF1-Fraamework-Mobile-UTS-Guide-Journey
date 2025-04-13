import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Destinations Guide';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // Gambar utama
              ImageSection(image: 'images/borobudur.jpg'),
              // Judul dan lokasi
              TitleSection(
                name: 'Borobudur Temple',
                location: 'Magelang, Central Java',
              ),
              // Tombol interaktif
              ButtonSection(),
              // Deskripsi tempat
              TextSection(
                description:
                'Candi Borobudur adalah candi Buddha yang terletak di Magelang, '
                    'Jawa Tengah, Indonesia. Dibangun pada abad ke-8 dan ke-9 selama masa '
                    'dinasti Syailendra, candi ini dikenal sebagai salah satu struktur candi '
                    'Budha terbesar dan terpenting di dunia. Borobudur memiliki desain yang unik dengan '
                    'arsitektur bertingkat dan dilengkapi dengan lebih dari 2.600 panel relief serta 504 arca '
                    'Buddha. Candi ini juga dikenal karena stupanya yang ikonik, dan merupakan Situs Warisan Dunia '
                    'UNESCO sejak tahun 1991. Dikelilingi oleh pemandangan pegunungan yang spektakuler, Borobudur menjadi salah satu '
                    'destinasi wisata utama di Indonesia.',
              ),
              // Widget tambahan: Review pengguna
              // Widget tambahan: Review pengguna yang dapat di like dan di command lagi
              ReviewSection(),
            ],
          ),
          ),
      ),
    );
  }
}

// Menampilkan gambar asset
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}

// Menampilkan nama tempat, lokasi, dan favorit
class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text(location, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.yellow[700]),
          const Text('50'),
        ],
      ),
    );
  }
}

// Menampilkan tombol interaktif seperti CALL, ROUTE, SHARE
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ButtonWithIconAndText(
            color: color,
            icon: Icons.call,
            label: 'CALL',
            onPressed: () => print('Call button pressed'),
          ),
          _ButtonWithIconAndText(
            color: color,
            icon: Icons.near_me,
            label: 'ROUTE',
            onPressed: () => print('Route button pressed'),
          ),
          _ButtonWithIconAndText(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
            onPressed: () => print('Share button pressed'),
          ),
        ],
      ),
    );
  }
}

class _ButtonWithIconAndText extends StatelessWidget {
  const _ButtonWithIconAndText({
    required this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: color),
      ),
    );
  }
}

// Widget untuk tombol dengan ikon dan teks
class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        ),
      ],
    );
  }
}

// Menampilkan deskripsi tentang tempat
class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true),
    );
  }
}

// Widget tambahan untuk menampilkan review pengguna
class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1, height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'User Reviews',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.deepPurple),
          ),
        ),
        const SizedBox(height: 16),
        _buildReview('Bambang Sudarsono', 'Tempat yang sangat menakjubkan, tempat ini sangat cantik.', 4.5,
            'https://picsum.photos/200/300/?blur=2'),
        _buildReview('Siti Nurjanah', 'Pemandangan di tempat ini sangat cantik, cocok untuk menjadi tempat rileks', 5.0,
            'https://picsum.photos/id/1084/200/300'),
        _buildReview('Tio Yulistio', 'Tempat ini sangat menakjubkan', 4.0,
            'https://picsum.photos/seed/picsum/200/300'),
      ],
    );
  }

  Widget _buildReview(String name, String review, double rating, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  review,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
