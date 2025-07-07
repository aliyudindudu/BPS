import 'package:flutter/material.dart';
import 'search_page.dart'; // Pastikan untuk mengimpor SearchPage
import 'infografis_detail_page.dart'; // Pastikan untuk mengimpor halaman detail infografis
import 'infografis_page.dart'; // Pastikan untuk mengimpor InfografisPage
import 'peta_tematik.dart';
import 'tabel_statistik.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC), // Background utama
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 32, left: 20, right: 20, bottom: 0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF6EC6FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 44,
                          height: 44,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Badan Pusat Statistika',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Kabupaten Sumedang',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white, size: 28),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchPage()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                        margin: const EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.08),
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildMenuIcon(Icons.image, 'Infografis'),
                            _buildMenuIcon(Icons.show_chart, 'Indikator statistik'),
                            _buildMenuIcon(Icons.table_chart, 'Tabel Statistik'),
                            _buildMenuIcon(Icons.map, 'Peta Tematik'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Infografis Section
              _buildSectionHeader('Infografis', () {}),
              SizedBox(
                height: 260, // Perkecil poster 9:16
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final List<String> infografisImages = [
                      'assets/images/infografis.jfif',
                      'assets/images/infografis1.png',
                      'assets/images/infografis2.jfif',
                      'assets/images/infografis3.jfif',
                      'assets/images/infografis4.jfif',
                    ];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfografisDetailPage(
                              imagePath: infografisImages[index % infografisImages.length],
                              allImages: infografisImages,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 140, // Perkecil lebar poster
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: Image.asset(
                              infografisImages[index % infografisImages.length],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Publikasi Section
              _buildSectionHeader('Publikasi', () {}),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final months = ['Februari', 'Agustus', 'Januari', 'Desember'];
                  final descriptions = [
                    'Rata-rata upah buruh di Indonesia pada Februari 2025 sebesar Rp3,09 juta per bulan, dengan nilai tertinggi di sektor pertambangan dan penggalian, serta semakin tinggi pendidikan dan jenis kelamin laki-laki cenderung.',
                    'Rata-rata upah buruh di Indonesia pada Agustus 2024 sebesar Rp3,27 juta per bulan, dengan upah tertinggi di sektor pertambangan dan penggalian, serta semakin tinggi pendidikan dan buruh laki-laki cenderung memperoleh upah lebih tinggi.',
                    'Rata-rata upah buruh di Indonesia pada Agustus 2024 sebesar Rp3,27 juta per bulan, dengan upah tertinggi di sektor pertambangan dan penggalian, serta semakin tinggi pendidikan dan buruh laki-laki cenderung memperoleh upah lebih tinggi.',
                    'Rata-rata upah buruh di Indonesia pada Agustus 2024 sebesar Rp3,27 juta per bulan, dengan upah tertinggi di sektor pertambangan dan penggalian, serta semakin tinggi pendidikan dan buruh laki-laki cenderung memperoleh upah lebih tinggi.',
                  ];
                  final images = [
                    'assets/images/cover.jfif',
                    'assets/images/infografis.jfif',
                    'assets/images/infografis1.png',
                    'assets/images/infografis2.jfif',
                  ];
                  return Stack(
                    children: [
                      // Background shape
                      Positioned(
                        left: 20,
                        right: 0,
                        top: 16,
                        bottom: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: AspectRatio(
                                  aspectRatio: 3 / 4,
                                  child: Image.asset(
                                    images[index % images.length],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    months[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    descriptions[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Lainnya',
          ),
        ],
      ),
    );
  }

Widget _buildMenuIcon(IconData icon, String label) {
  return GestureDetector(
    onTap: () {
      if (icon == Icons.image) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfografisPage()),
        );
      } else if (icon == Icons.map) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PetaTematikPage()),
        );
      } else if (icon == Icons.table_chart) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const TabelStatistikPage(),
            transitionsBuilder: (_, animation, __, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 28, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}


  Widget _buildSectionHeader(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (title.toLowerCase().contains('infografis')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfografisPage()),
                );
              } else {
                onPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}