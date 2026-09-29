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

              const GreetingCard(),

              const SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: const Text('Email'),
                  subtitle: const Text(
                    'darmawan@student.undiksha.ac.id',
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.red),
                  title: const Text('Lokasi'),
                  subtitle: const Text('Karangasem, Bali'),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.school, color: Colors.green),
                  title: const Text('Program Studi'),
                  subtitle: const Text(
                    'Pendidikan Teknik Informatika',
                  ),
                ),
              ),
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