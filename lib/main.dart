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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // FOTO PROFIL
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                'assets/images/profile.jpeg',
              ),
            ),

            const SizedBox(height: 20),

            // NAMA
            const Text(
              studentName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // NIM
            const Text(
              studentId,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Mahasiswa PTI Undiksha',
              style: TextStyle(
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 25),

            // ==========================
            // STATISTIK
            // ==========================

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '15',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Widget',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '8',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Layout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'State',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // EMAIL
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                title: const Text('Email'),
                subtitle: const Text(
                  'darmawan@student.undiksha.ac.id',
                ),
              ),
            ),

            const SizedBox(height: 10),

            // LOKASI
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                title: const Text('Lokasi'),
                subtitle: const Text(
                  'Karangasem, Bali',
                ),
              ),
            ),

            const SizedBox(height: 10),

            // PROGRAM STUDI
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.school,
                  color: Colors.green,
                ),
                title: const Text('Program Studi'),
                subtitle: const Text(
                  'Pendidikan Teknik Informatika',
                ),
              ),
            ),

            const SizedBox(height: 10),

            // MINAT
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.phone_android,
                  color: Colors.deepPurple,
                ),
                title: const Text('Minat'),
                subtitle: const Text(
                  'Pemrograman Mobile menggunakan Flutter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}