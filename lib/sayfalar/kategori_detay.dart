import 'package:case_study/db/db_yardim.dart';
import 'package:flutter/material.dart';

class KategoriDetay extends StatefulWidget {
  int gelenId;

  KategoriDetay({required this.gelenId});
  @override
  _KategoriDetayState createState() => _KategoriDetayState();
}

class _KategoriDetayState extends State<KategoriDetay> {
  DbYardim dbYardim = DbYardim();
  int uzunluk = 0;
  List bilgiler = [];

  @override
  void initState() {
    super.initState();
    dbYardim.queryDetayKategori(widget.gelenId).then((value) {
      uzunluk = value.length;
      bilgiler = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategori Detay",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "ID: " + bilgiler[0].kategoriId.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Açıklama: " + bilgiler[0].kategoriAdi,
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
