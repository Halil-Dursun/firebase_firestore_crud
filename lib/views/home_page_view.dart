import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_islemleri2_crud/data/firestore_crud.dart';
import 'package:firebase_islemleri2_crud/model/kitap_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  Kitap _kitap = Kitap(ad: '', kategori: '', id: 0, sayfaSayisi: 0);
  final Stream<QuerySnapshot> _kitapStream =
      FirebaseFirestore.instance.collection('kitaplik').snapshots();
  FirestoreCrud _firestoreCrud = FirestoreCrud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (idDegeri) {
                  _kitap.id = int.parse(idDegeri);
                },
                decoration: const InputDecoration(
                  labelText: 'Kitap ID',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (isiDegeri) {
                  _kitap.ad = isiDegeri;
                },
                decoration: const InputDecoration(
                  labelText: 'Kitap adı',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (kategoriDegeri) {
                  _kitap.kategori = kategoriDegeri;
                },
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (sayfaSayisiDegeri) {
                  _kitap.sayfaSayisi = int.parse(sayfaSayisiDegeri);
                },
                decoration: const InputDecoration(
                  labelText: 'Sayfa sayısı',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:(){
                      _firestoreCrud.veriEkle(_kitap);
                    },
                    child: Text('Ekle'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _firestoreCrud.veriSil(_kitap.id);
                    },
                    child: Text('Sil'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _firestoreCrud.veriOku(_kitap.id);

                    },
                    child: Text('Oku'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _firestoreCrud.veriGuncelle(_kitap);
                    },
                    child: Text('Güncelle'),
                    style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: _kitapStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          return Card(
                            child: ListTile(
                              title: Text('${data['isim']}'),
                              subtitle: Text('${data['kategori']}'),
                            ),
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
