import 'package:case_study/db/db_yardim.dart';
import 'package:case_study/modeller/KategoriModel.dart';
import 'package:flutter/material.dart';

class KategoriEkle extends StatefulWidget {
  const KategoriEkle({Key? key}) : super(key: key);

  @override
  _KategoriEkleState createState() => _KategoriEkleState();
}

class _KategoriEkleState extends State<KategoriEkle> {
  TextEditingController t1 = TextEditingController();

  DbYardim dbYardim = DbYardim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategori Ekle",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Kategori Ekle",
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
                  hintText: "Kategori Adi",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  final kategori = KategoriModel(
                    null,
                    t1.text,
                  );
                  dbYardim.insertKategori(kategori);
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
        const AlertDialog(title: Text('Kategori Eklendi!')),
  );
}
