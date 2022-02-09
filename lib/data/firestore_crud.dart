import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_islemleri2_crud/model/kitap_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirestoreCrud {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void veriEkle(Kitap kitap) async {
    DocumentReference _documentRef =
        _firestore.collection('kitaplik').doc('${kitap.id}');
    Map<String, dynamic> kitaplar = {
      'id': kitap.id,
      'isim': kitap.ad,
      'kategori': kitap.kategori,
      'sayfa_sayisi': kitap.sayfaSayisi,
    };
    await _documentRef.set(kitaplar).whenComplete(() {
      Fluttertoast.showToast(msg: ' ${kitap.id} Id numaralı Kitap Eklendi');
    });
  }

  veriOku(int id) async {
    DocumentReference _documentRef =
        _firestore.collection('kitaplik').doc('$id');
    await _documentRef.get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      return Fluttertoast.showToast(
          msg:
              'Kitap adı : ${data['isim']}, Kategorisi: ${data['kategori']}, id: ${data['id']}, sayfa: ${data['sayfa_sayisi']}');
    });
  }

  void veriSil(int id) async {
    DocumentReference _documentRef =
        _firestore.collection('kitaplik').doc('$id');
    await _documentRef.delete();
  }

  void veriGuncelle(Kitap kitap) async {
    DocumentReference _documentRef =
        _firestore.collection('kitaplik').doc('${kitap.id}');

    await _documentRef.set({
      'id': kitap.id,
      'isim': kitap.ad,
      'kategori': kitap.kategori,
      'sayfa_sayisi': kitap.sayfaSayisi,
    }).whenComplete(() {
      Fluttertoast.showToast(msg: 'Veri Guncellendi');
    });
  }
}
