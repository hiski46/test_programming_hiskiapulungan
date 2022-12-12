import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:test_programming_hiskiapulungan/model/Provinsi.dart';

import '../model/Kota.dart';
import '../model/Siswa.dart';

class CardList extends StatefulWidget {
  Siswa? siswa;
  CardList({super.key, this.siswa});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final DateFormat formater = DateFormat('dd MMMM yyyy');

  Map<String, Kota> _kota = new Map();
  Map<String, Provinsi> _provinsi = new Map();

  Future<Map<String, Kota>> fetchKota() async {
    final response =
        await http.get(Uri.parse('https://hiringmobile.qtera.co.id/city'));
    Map<String, Kota> temp_Kota = new Map();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(jsonDecode(response.body)['data'].runtimeType);
      int n = 0;
      for (var i in jsonDecode(response.body)['data']) {
        var data = Kota.fromJson(jsonDecode(response.body)['data'][n]);
        temp_Kota[data.id] = data;
        n++;
      }
      return temp_Kota;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load siswa');
    }
  }

  Future<Map<String, Provinsi>> fetchProvinsi() async {
    final response =
        await http.get(Uri.parse('https://hiringmobile.qtera.co.id/city'));
    Map<String, Provinsi> temp_Provinsi = new Map();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(jsonDecode(response.body)['data'].runtimeType);
      int n = 0;
      for (var i in jsonDecode(response.body)['data']) {
        var data = Provinsi.fromJson(jsonDecode(response.body)['data'][n]);
        temp_Provinsi[data.id] = data;
        n++;
      }
      return temp_Provinsi;
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
    fetchKota().then((value) {
      setState(() {
        _kota.addAll(value);
      });
    });
    fetchProvinsi().then((value) {
      setState(() {
        _provinsi.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    this.widget.siswa!.name,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 80,
                      child: ClipRRect(
                        child: Image.network(
                          alignment: Alignment.centerLeft,
                          'https://picsum.photos/200',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.only(left: 5, top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Jenis Kelamin',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: this.widget.siswa!.gender == 'male'
                                    ? Text(': Pria')
                                    : Text(': Wanita'),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Tanggal Lahir',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(':' +
                                    formater.format(DateTime.parse(this
                                        .widget
                                        .siswa!
                                        .birthDate
                                        .substring(0, 10)))),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Provinsi',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(this.widget.siswa!.province),
                                //   child: _provinsi[this.widget.siswa!.province]!
                                //               .name !=
                                //           null
                                //       ? Text(': ' +
                                //           _provinsi[this.widget.siswa!.province]!
                                //               .name)
                                //       : Text(': ' + this.widget.siswa!.province),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Kota/Kabupaten',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(this.widget.siswa!.province),
                                // child:
                                //     _kota[this.widget.siswa!.city]!.name != null
                                //         ? Text(': ' +
                                //             _kota[this.widget.siswa!.city]!
                                //                 .name
                                //                 .toString())
                                //         : Text(': ' + this.widget.siswa!.city),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
