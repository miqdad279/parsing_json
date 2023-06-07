import 'package:flutter/material.dart';
import 'usermodel.dart';
import 'userviewmodel.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  List dataUser = [];
  void getDataUser() {
    UserViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  // menambahkan widget custom
  Widget personDetailCard(UserModel data) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                data.username,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                data.email,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  // ini
  showDetailDialog(UserModel data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Detail Person'),
            children: [
              Text("Name : ${data.name}"),
              Text("Email : ${data.email}"),
              Text("Username : ${data.username}"),
              Text("Website : ${data.website}"),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Utama'),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                showDetailDialog(dataUser[i]);
              },
              child: personDetailCard(dataUser[i]),
            );
          },
          itemCount: dataUser == null ? 0 : dataUser.length,
        ),
      ),
    );
  }
}
