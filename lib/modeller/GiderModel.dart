class GiderModel {
  final int? giderId;
  final String giderAciklama;
  final int giderTutar;
  final String giderTarih;
  final int giderKategoriId;
  final double giderLa;
  final double giderLo;

  GiderModel(this.giderId, this.giderAciklama, this.giderTutar, this.giderTarih,
      this.giderKategoriId, this.giderLa, this.giderLo);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (giderId != null) {
      map['gider_id'] = giderId;
    }
    map['gider_aciklama'] = giderAciklama;
    map['gider_tutar'] = giderTutar;
    map['gider_tarih'] = giderTarih;
    map['gider_kategori'] = giderKategoriId;
    map['gider_la'] = giderLa;
    map['gider_lo'] = giderLo;

    return map;
  }

  @override
  String toString() {
    return 'gider_id $giderId gider_aciklama $giderAciklama gider_tutar $giderTutar gider_tarih $giderTarih gider_kategori $giderKategoriId gider_la $giderLa gider_lo $giderLo';
  }
}
