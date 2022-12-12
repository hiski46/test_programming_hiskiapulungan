import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_programming_hiskiapulungan/comp/cardlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Siswa.dart';

class DataSiswa extends StatefulWidget {
  const DataSiswa({super.key});

  @override
  State<DataSiswa> createState() => _DataSiswaState();
}

class _DataSiswaState extends State<DataSiswa> {
  final String apiurl = 'https://hiringmobile.qtera.co.id/students';

  final List<Siswa> _Siswa = [];

  Future<List<Siswa>> fetchSiswa() async {
    final response = await http.get(Uri.parse(apiurl));
    List<Siswa> temp_siswa = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(jsonDecode(response.body)['data'].runtimeType);
      int n = 0;
      for (var i in jsonDecode(response.body)['data']) {
        temp_siswa.add(Siswa.fromJson(jsonDecode(response.body)['data'][n]));
        n++;
      }
      return temp_siswa;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load siswa');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSiswa().then((value) {
      setState(() {
        _Siswa.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Siswa')),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: _Siswa.length,
            itemBuilder: (context, index) {
              return CardList(
                siswa: _Siswa[index],
              );
            },
          )),
    );
  }
}
