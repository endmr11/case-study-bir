import 'package:case_study/db/db_yardim.dart';
import 'package:case_study/sayfalar/genel_harita.dart';
import 'package:case_study/sayfalar/gider_detay.dart';
import 'package:case_study/sayfalar/gider_duzenle.dart';
import 'package:case_study/sayfalar/gider_ekle.dart';
import 'package:case_study/sayfalar/kategoriler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  DbYardim dbYardim = DbYardim();
  int uzunluk = 0;
  List bilgiler = [];

  void _yenile() {
    dbYardim.queryGider().then((value) {
      uzunluk = value.length;
      bilgiler = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    dbYardim.createDb();
    dbYardim.queryGider().then((value) {
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
          "Anasayfa",
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
            "Tüm Giderler",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: uzunluk,
              itemBuilder: (BuildContext contex, index) {
                return uzunluk == 0
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
                                  builder: (context) => GiderDetay(
                                      gelenId: bilgiler[index].giderId),
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
                              bilgiler[index].giderAciklama,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            subtitle: Text(
                              "Konum : ${bilgiler[index].giderLa.toString()} , ${bilgiler[index].giderLo.toString()}",
                            ),
                            trailing: Text(
                              "${bilgiler[index].giderTutar.toString()} ₺",
                              style: TextStyle(
                                fontSize: 18.0,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GiderDuzenle(
                                      gelenId: bilgiler[index].giderId),
                                ),
                              );
                            },
                          ),
                          IconSlideAction(
                            caption: 'Sil',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              print('Sil');
                              dbYardim
                                  .deleteGider(bilgiler[index].giderId)
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
              builder: (context) => GiderEkle(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
