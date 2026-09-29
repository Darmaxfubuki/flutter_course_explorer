import 'package:flutter/material.dart';

const String studentName = 'I Ketut Darmawan Wirakusuma';
const String studentId = '2415051021';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data collection topics untuk Tahap 10
    final List<Map<String, dynamic>> topics = [
      {
        'title': 'Git & GitHub',
        'subtitle': 'Version control',
        'done': true,
      },
      {
        'title': 'Dart Fundamentals',
        'subtitle': 'Language basics',
        'done': true,
      },
      {
        'title': 'Flutter UI Fundamentals',
        'subtitle': 'Widgets & layout',
        'done': false,
      },
      {
        'title': '$studentId - $studentName',
        'subtitle': 'Pemilik aplikasi',
        'done': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Fundamentals'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ================= Kartu Profil (Tahap 5 & 7) =================
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/images/profile.jpeg',
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        studentName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        studentId,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Mahasiswa PTI Undiksha',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= Stat Cards (Tahap 6 & 8) =================
              Row(
                children: [
                  buildStatCard(
                    '15',
                    'Widget',
                    Icons.widgets,
                  ),
                  const SizedBox(width: 8),
                  buildStatCard(
                    '8',
                    'Layout',
                    Icons.view_quilt,
                  ),
                  const SizedBox(width: 8),
                  buildStatCard(
                    '3',
                    'State',
                    Icons.sync,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= Ringkasan (Tahap 7) =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Colors.orange,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ringkasan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Saya memiliki minat dalam pemrograman mobile menggunakan Flutter karena mampu membangun aplikasi yang modern, responsif, dan bermanfaat dalam bidang pendidikan.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= Greeting Card / Input State (Tahap 9) =================
              const GreetingCard(),

              const SizedBox(height: 20),

              // ================= Info Cards (Tahap 7) =================
              Card(
                child: const ListTile(
                  leading: Icon(Icons.email, color: Colors.blue),
                  title: Text('Email'),
                  subtitle: Text('darmawan@student.undiksha.ac.id'),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: const ListTile(
                  leading: Icon(Icons.location_on, color: Colors.red),
                  title: Text('Lokasi'),
                  subtitle: Text('Karangasem, Bali'),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: const ListTile(
                  leading: Icon(Icons.school, color: Colors.green),
                  title: Text('Program Studi'),
                  subtitle: Text('Pendidikan Teknik Informatika'),
                ),
              ),

              const SizedBox(height: 20),

              // ================= TAHAP 10: Collection List (ListView.builder) =================
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Identitas tetap tampil di atas daftar
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Daftar Topik Pembelajaran\n$studentId - $studentName',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(),
                      // ListView.builder untuk merender collection topics
                      ListView.builder(
                        shrinkWrap: true, // Membatasi tinggi ListView agar mengikuti isi
                        physics: const NeverScrollableScrollPhysics(), // Menyerahkan scroll ke SingleChildScrollView utama
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          final item = topics[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              item['done'] == true
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: item['done'] == true
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            title: Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(item['subtitle'] as String),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatCard(
    String value,
    String label,
    IconData icon,
  ) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.blue,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  final TextEditingController controller = TextEditingController();

  String message = 'Belum ada pesan';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void tampilkanPesan() {
    setState(() {
      if (controller.text.trim().isEmpty) {
        message = 'Input masih kosong';
      } else {
        message = controller.text.trim();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Greeting Card',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '$studentId - $studentName',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Pesan',
                hintText: 'Contoh: Halo Flutter',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: tampilkanPesan,
              child: const Text('Tampilkan'),
            ),
            const SizedBox(height: 15),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}