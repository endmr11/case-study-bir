import 'package:case_study/db/db_yardim.dart';
import 'package:case_study/sayfalar/anasayfa.dart';
import 'package:case_study/sayfalar/genel_harita.dart';
import 'package:case_study/sayfalar/gider_duzenle.dart';
import 'package:case_study/sayfalar/gider_ekle.dart';
import 'package:case_study/sayfalar/kategori_detay.dart';
import 'package:case_study/sayfalar/kategori_ekle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Kategoriler extends StatefulWidget {
  @override
  _KategorilerState createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {
  DbYardim dbYardim = DbYardim();
  int uzunluk = 0;
  List bilgiler = [];

  void _yenile() {
    dbYardim.queryKategori().then((value) {
      uzunluk = value.length;
      bilgiler = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    dbYardim.queryKategori().then((value) {
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
          "Kategoriler",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _yenile,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Tüm Kategoriler",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: uzunluk,
              itemBuilder: (BuildContext contex, index) {
                return uzunluk < 1
                    ? Text(
                        "BOŞ",
                        style: TextStyle(
                          fontSize: 50.0,
                        ),
                      )
                    : Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KategoriDetay(
                                      gelenId: bilgiler[index].kategoriId),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              child: Text(
                                index.toString(),
                              ),
                            ),
                            title: Text(
                              bilgiler[index].kategoriAdi,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Düzenle',
                            color: Colors.blue,
                            icon: Icons.edit,
                            onTap: () {
                              print('Düzenle');
                            },
                          ),
                          IconSlideAction(
                            caption: 'Sil',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              print('Sil');
                              dbYardim
                                  .deleteKategori(bilgiler[index].kategoriId)
                                  .then((value) {
                                _yenile();
                              });
                            },
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('TEST'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Anasayfa'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnaSayfa(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: const Text('Kategoriler'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Kategoriler(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.map_outlined),
              title: const Text('Genel Harita'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenelHarita(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KategoriEkle(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
