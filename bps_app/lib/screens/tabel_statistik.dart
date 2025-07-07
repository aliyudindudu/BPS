import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'tabel_statistik_detail_page.dart'; // ini nanti kita buat juga

class TabelStatistikPage extends StatelessWidget {
  const TabelStatistikPage({super.key});

  final List<Map<String, String>> _statistikData = const [
  {
    'title': 'Proyeksi Penduduk di Provinsi Jawa Barat menurut Jenis Kelamin Tahun 2025',
    'date': '30 Juni 2025',
    'category': 'Kependudukan dan Migrasi',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Jumlah Angkatan Kerja di Sumedang menurut Pendidikan Tertinggi Tahun 2024',
    'date': '12 Mei 2024',
    'category': 'Ketenagakerjaan',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Distribusi Konsumsi Beras per Kapita di Sumedang Tahun 2023',
    'date': '1 Januari 2024',
    'category': 'Konsumsi dan Pengeluaran',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Pendapatan Domestik Regional Bruto Kabupaten Sumedang Tahun 2023',
    'date': '18 Desember 2023',
    'category': 'Ekonomi',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Jumlah Sekolah dan Guru di Kabupaten Sumedang Tahun 2024',
    'date': '10 Februari 2024',
    'category': 'Pendidikan',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Perkembangan Inflasi Bulanan di Kabupaten Sumedang Tahun 2025',
    'date': '7 Juli 2025',
    'category': 'Harga Konsumen',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Rasio Jenis Kelamin Anak Lahir Hidup di Sumedang Tahun 2023',
    'date': '25 Agustus 2023',
    'category': 'Kependudukan',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Jumlah Rumah Tangga menurut Sumber Air Minum Utama Tahun 2023',
    'date': '4 Oktober 2023',
    'category': 'Lingkungan Hidup',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Jumlah Penduduk Miskin di Sumedang Tahun 2024',
    'date': '15 Maret 2024',
    'category': 'Kemiskinan',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
  {
    'title': 'Jumlah Kunjungan Wisatawan ke Sumedang Tahun 2023',
    'date': '20 November 2023',
    'category': 'Pariwisata',
    'fileAssetPath': 'assets/excel/andda.xlsx',
  },
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Table statistik',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const HomePage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _statistikData.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = _statistikData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabelStatistikDetailPage(
                    title: item['title']!,
                    date: item['date']!,
                    category: item['category']!,
                    fileAssetPath: item['fileAssetPath'] ?? '',
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${item['date']} – ${item['category']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          }
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
}
