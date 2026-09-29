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
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 15),

                  const Text(
                    'Deskripsi Singkat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Saya memiliki ketertarikan pada pemrograman mobile karena aplikasi mobile telah menjadi bagian penting dalam kehidupan sehari-hari. Saya ingin mempelajari Flutter agar mampu mengembangkan aplikasi Android yang modern, responsif, mudah digunakan, serta bermanfaat dalam dunia pendidikan dan kehidupan masyarakat.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 15),

                  const Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'darmawan@student.undiksha.ac.id',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Karangasem, Bali',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Program Studi Pendidikan Teknik Informatika',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}