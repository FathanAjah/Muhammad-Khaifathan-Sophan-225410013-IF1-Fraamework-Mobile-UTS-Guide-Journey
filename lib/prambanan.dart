import 'package:flutter/material.dart';

// Stateful widget Karena menangani interaksi (like/dislike) yang berubah seiring waktu
class PrambananPage extends StatefulWidget {
  const PrambananPage({super.key});

  @override
  State<PrambananPage> createState() => _PrambananPageState();
}

class _PrambananPageState extends State<PrambananPage> {
  // Variabel untuk menyimpan status like/dislike
  int likeCount = 0;
  int dislikeCount = 0;
  bool isLiked = false;
  bool isDisliked = false;

  // Fungsi untuk toggle tombol Like
  void toggleLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        likeCount--;
      } else {
        isLiked = true;
        likeCount++;
        if (isDisliked) {
          isDisliked = false;
          dislikeCount--;
        }
      }
    });
  }

  // Fungsi untuk toggle tombol Dislike
  void toggleDislike() {
    setState(() {
      if (isDisliked) {
        isDisliked = false;
        dislikeCount--;
      } else {
        isDisliked = true;
        dislikeCount++;
        if (isLiked) {
          isLiked = false;
          likeCount--;
        }
      }
    });
  }

  // Widget utama yang ditampilkan ke layar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prambanan Temple',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Gambar bakcground
            Image.asset(
              'images/prambanan.jpg',
              fit: BoxFit.cover,
            ),
            // Overlay hitam transparan
            Container(color: Colors.black.withOpacity(0.7)),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Widget gambar utama
                    const ImageSection(image: 'images/prambanan.jpg'),
                    const SizedBox(height: 16),
                    // Widget kartu informasi (stateless tapi menerima data dari Stateful di atas)
                    InfoCard(
                      likeCount: likeCount,
                      dislikeCount: dislikeCount,
                      isLiked: isLiked,
                      isDisliked: isDisliked,
                      onLikePressed: toggleLike,
                      onDislikePressed: toggleDislike,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless Widget untuk Menampilkan gambar utama
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(image, height: 200, width: double.infinity, fit: BoxFit.cover),
    );
  }
}

// Stateless Widget untuk menampilkan info lokasi, tombol like/dislike, deskripsi, dan review
class InfoCard extends StatelessWidget {
  final int likeCount;
  final int dislikeCount;
  final bool isLiked;
  final bool isDisliked;
  final VoidCallback onLikePressed;
  final VoidCallback onDislikePressed;

  const InfoCard({
    super.key,
    required this.likeCount,
    required this.dislikeCount,
    required this.isLiked,
    required this.isDisliked,
    required this.onLikePressed,
    required this.onDislikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul lokasi
            const TitleSection(
              name: 'Prambanan Temple',
              location: 'Yogyakarta, DIY',
            ),
            const SizedBox(height: 16),
            // Tombol Like & Dislike
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                      color: isLiked ? Colors.blue : Colors.grey,
                    ),
                    onPressed: onLikePressed,
                  ),
                  Text('$likeCount likes'),
                  const SizedBox(width: 24),
                  IconButton(
                    icon: Icon(
                      isDisliked ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                      color: isDisliked ? Colors.red : Colors.grey,
                    ),
                    onPressed: onDislikePressed,
                  ),
                  Text('$dislikeCount dislikes'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Deskripsi tempat wisata
            const TextSection(
              description:
              'Candi Prambanan adalah kompleks candi Hindu terbesar di Indonesia '
                  'yang terletak di Sleman, Daerah Istimewa Yogyakarta. Dibangun '
                  'pada abad ke-9, candi ini dipersembahkan untuk Trimurti, yaitu '
                  'tiga dewa utama dalam agama Hindu: Brahma (pencipta), Wisnu (pemelihara), '
                  'dan Siwa (perusak). Ciri khas Prambanan adalah arsitekturnya yang menjulang tinggi, '
                  'dengan candi utama Siwa setinggi 47 meter. Candi ini dihiasi relief cerita Ramayana dan '
                  'merupakan salah satu Situs Warisan Dunia UNESCO.',
            ),
            const SizedBox(height: 24),
            // Review  user
            const ReviewSection(),
          ],
        ),
      ),
    );
  }
}

// Stateless Widget Menampilkan nama lokasi dan rating
class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 4),
              Text(location, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            ],
          ),
        ),
        const Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: 4),
        const Text('4.5', style: TextStyle(fontSize: 16, color: Colors.black87)),
      ],
    );
  }
}

// Stateless Widget Menampilkan deskripsi wisata
class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
      textAlign: TextAlign.justify,
    );
  }
}

// Stateless Widget Menampilkan daftar review pengguna
class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('User Reviews',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple)),
        const SizedBox(height: 16),
        _buildReview('Dewi Aganta', 'Candi Prambanan sangat megah dan memukau! Arsitekturnya indah dan penuh sejarah. Wajib dikunjungi kalau ke Yogyakarta!', 5.0,
            'https://picsum.photos/200/300/?blur=1'),
        _buildReview('Sinta Amanda', 'Tempat ini luar biasa! Relief ceritanya detail sekali, bikin saya ingin belajar lebih banyak tentang kisah Ramayana.', 4.0,
            'https://picsum.photos/id/237/200/300'),
        _buildReview('Andi Sutanto', 'Pengalaman edukatif dan spiritual. Lokasi terawat baik dan fasilitas wisatawan cukup lengkap.', 5.0,
            'https://picsum.photos/200/300?grayscale'),
      ],
    );
  }

  // Widget kecil untuk membuat review user
  Widget _buildReview(String name, String review, double rating, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(review, style: const TextStyle(fontSize: 14, color: Colors.black87)),
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
