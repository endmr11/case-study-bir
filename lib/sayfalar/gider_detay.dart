import 'package:case_study/db/db_yardim.dart';
import 'package:flutter/material.dart';

class GiderDetay extends StatefulWidget {
  int gelenId;

  GiderDetay({required this.gelenId});

  @override
  _GiderDetayState createState() => _GiderDetayState();
}

class _GiderDetayState extends State<GiderDetay> {
  DbYardim dbYardim = DbYardim();
  int uzunluk = 0;
  List bilgiler = [];

  @override
  void initState() {
    super.initState();
    dbYardim.queryDetayGider(widget.gelenId).then((value) {
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
          "Gider Detay",
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
                  "ID: " + bilgiler[0].giderId.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Açıklama: " + bilgiler[0].giderAciklama,
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tutar: " + bilgiler[0].giderTutar.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tarih: " + bilgiler[0].giderTarih,
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kategori: " + bilgiler[0].giderKategoriId.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Konum: " +
                      bilgiler[0].giderLa.toString() +
                      " , " +
                      bilgiler[0].giderLo.toString(),
                  style: TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
