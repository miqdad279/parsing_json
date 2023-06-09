import 'package:flutter/material.dart';
import 'user_model.dart';
import 'user_view_model.dart';

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

  Widget personDetailCard(UserModel data) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                data.username,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                data.email,
                style: const TextStyle(color: Colors.black, fontSize: 18),
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

  showDetailDialog(UserModel data) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Center(child: Text('Detail Person')),
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name : ${data.name}"),
                    Text("Email : ${data.email}"),
                    Text("Username : ${data.username}"),
                    Text("Website : ${data.website}"),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F9FF),
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
