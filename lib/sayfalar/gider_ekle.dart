import 'package:case_study/db/db_yardim.dart';
import 'package:case_study/modeller/GiderModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dropdown_x/flutter_dropdown_x.dart';

class GiderEkle extends StatefulWidget {
  @override
  _GiderEkleState createState() => _GiderEkleState();
}

class _GiderEkleState extends State<GiderEkle> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  DbYardim dbYardim = DbYardim();

  double la = 0;
  double lo = 0;

  var secilenKategori;
  var kategoriListesi = [];

  Future konumSec() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lasPosition = await Geolocator.getLastKnownPosition();
    la = position.latitude;
    lo = position.longitude;
    setState(() {
      print("La: $la Lo: $lo");
    });
  }

  @override
  void initState() {
    super.initState();
    dbYardim.queryKategori().then((value) {
      for (var i = 0; i < value.length; i++) {
        var gecici = value[i].toMap();
        kategoriListesi.add(gecici);
        print(kategoriListesi);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gider Ekle",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Gider Ekle",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: t1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: "Ürün Açıklama",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: t2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: "Ürün Tutar",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: t3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: "Ürün Tarih",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropDownField(
                value: secilenKategori,
                hintText: 'Kategori',
                dataSource: kategoriListesi.toList(),
                onChanged: (v) {
                  print(v);
                  setState(() {
                    secilenKategori = v;
                  });
                },
                valueField: 'kategori_id',
                textField: 'kategori_adi',
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                la == 0 ? "Konum Seçmelisiniz" : "Konum: $la , $lo",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  konumSec();
                },
                child: Text(
                  "KONUM SEÇ",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  final gider = GiderModel(
                    null,
                    t1.text,
                    int.parse(t2.text),
                    t3.text,
                    secilenKategori,
                    la,
                    lo,
                  );
                  dbYardim.insertGider(gider);
                  Navigator.of(context).restorablePush(_dialogBuilder);
                },
                child: Text(
                  "EKLE",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) =>
        const AlertDialog(title: Text('Gider Eklendi!')),
  );
}
