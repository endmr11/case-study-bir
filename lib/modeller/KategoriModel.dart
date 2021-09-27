class KategoriModel {
  final int? kategoriId;
  final String kategoriAdi;

  KategoriModel(this.kategoriId, this.kategoriAdi);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (kategoriId != null) {
      map['kategori_id'] = kategoriId;
    }
    map['kategori_adi'] = kategoriAdi;

    return map;
  }

  @override
  String toString() {
    return 'kategori_id $kategoriId kategori_adi $kategoriAdi ';
  }
}
