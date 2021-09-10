import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Firebase CRUD",
    home: FireBaseCrud(),
  ));
}

class FireBaseCrud extends StatefulWidget {
  @override
  _FireBaseCrudState createState() => _FireBaseCrudState();
}

class _FireBaseCrudState extends State<FireBaseCrud> {
  //tutucular
  String id;
  String category;
  String booksPage;
  String name;

  idAl(idTutucu) {
    this.id = idTutucu;
  }

  sayfaSayiAl(sayfaSayiTutucu) {
    this.booksPage = sayfaSayiTutucu;
  }

  adAl(adTutucu) {
    this.name = adTutucu;
  }

  kategoriTutucu(acategory) {
    this.category = acategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent ,
        centerTitle: true,
        title: Text("Kitap Ekle"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepOrangeAccent, Colors.white])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (String idTutucu) {
                    idAl(idTutucu);
                  },
                  decoration: InputDecoration(
                      labelText: "Kitap Id",
                      hintText: "14",
                      focusColor: Colors.deepOrange,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.blueGrey))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (String adTutucu) {
                    adAl(adTutucu);
                  },
                  decoration: InputDecoration(
                      labelText: "Kitap Adı",
                      hintText: "Nutuk",
                      focusColor: Colors.deepOrange,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.blueGrey))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (String sayfaSayiTutucu) {
                    sayfaSayiAl(sayfaSayiTutucu);
                  },
                  decoration: InputDecoration(
                      labelText: "Sayfa Sayısı",
                      hintText: "200",
                      focusColor: Colors.deepOrange,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.blueGrey))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (String acategory) {
                    kategoriTutucu(acategory);
                  },
                  decoration: InputDecoration(
                      labelText: "Kategori",
                      hintText: "Roman",
                      focusColor: Colors.deepOrange,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.blueGrey))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        addBook();
                      },
                      child: Text("Ekle"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent, shadowColor: Colors.red)),
                  ElevatedButton(
                      onPressed: () {
                        deleteBook();
                      },
                      child: Text("Sil"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green, shadowColor: Colors.red)),
                  ElevatedButton(
                      onPressed: () {
                        updateBook();
                      },
                      child: Text("Güncelle"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey, shadowColor: Colors.red)),
                  ElevatedButton(
                    onPressed: () {
                      kitapGetir();
                    },
                    child: Text("Bul", style: TextStyle()),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange, shadowColor: Colors.red),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 20),
                child: Row(
                  children: [
                    Expanded(
                        child:
                            Text("ID", style: GoogleFonts.rubik(fontSize: 20))),
                    Expanded(
                        child: Text("Kitap Adı",
                            style: GoogleFonts.rubik(fontSize: 20))),
                    Expanded(
                        child: Text("Sayfa Sayısı",
                            style: GoogleFonts.rubik(fontSize: 20))),
                    Expanded(
                        child: Text("Kategori",
                            style: GoogleFonts.rubik(fontSize: 20))),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Kitaplik").orderBy('bookPage',descending: true)
                      .snapshots(),
                  builder: (context, alinanVeri) {
                    if (alinanVeri.hasError) {
                      return Text("uyari");
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: alinanVeri.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot satirVerisi =
                              alinanVeri.data.docs[index];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(satirVerisi["id"],
                                            style: GoogleFonts.rubik(
                                                fontSize: 12))),
                                    Expanded(
                                        child: Text(
                                      satirVerisi["name"],
                                      style: GoogleFonts.rubik(fontSize: 12),
                                    )),
                                    Expanded(
                                        child: Text(satirVerisi["bookPage"],
                                            style: GoogleFonts.rubik(
                                                fontSize: 12))),
                                    Expanded(
                                        child: Text(satirVerisi["category"],
                                            style: GoogleFonts.rubik(
                                                fontSize: 12))),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void addBook() {
    //veri yolu ekleme
    DocumentReference veriYolu =
        FirebaseFirestore.instance.collection("Kitaplik").doc(id);

    Map<String, dynamic> kitaplar = {
      "id": id,
      "name": name,
      "category": category,
      "bookPage": booksPage
    };

    //veriyi veri tabanına ekle
    veriYolu.set(kitaplar).whenComplete(() {
      Fluttertoast.showToast(msg: id + " ID'li kitap yüklendi");
    });
  }

  void kitapGetir() {
    DocumentReference veriOkumaYolu =
        FirebaseFirestore.instance.collection("Kitaplik").doc(id);
    veriOkumaYolu.get().then((alinanDeger) {
      //çoklu değerleri mape dönüştür

      Map<String, dynamic> alinanVeri = alinanDeger.data();

      String idTutucu = alinanVeri["id"];
      String adTutucu = alinanVeri["name"];
      String sayfaSayisiTutucu = alinanVeri["bookPage"];
      String kategoriTutucu = alinanVeri["category"];

      Fluttertoast.showToast(
          msg: "ID:" +
              idTutucu +
              " ad : " +
              adTutucu +
              "Sayfa Sayısı : " +
              sayfaSayisiTutucu +
              "Kategori : " +
              kategoriTutucu);
    });
  }

  void deleteBook() {
    DocumentReference veriSilmeYolu =
        FirebaseFirestore.instance.collection("Kitaplik").doc(id);

    veriSilmeYolu.delete().whenComplete(() {
      Fluttertoast.showToast(msg: id + "li  kitap silindi");
    });
  }

  void updateBook() {
    DocumentReference veriguncellemeYolu =
        FirebaseFirestore.instance.collection("Kitaplik").doc(id);
    Map<String, dynamic> guncellenecekVeri = {
      "id": id,
      "name": name,
      "category": category,
      "bookPage": booksPage
    };
    veriguncellemeYolu.update(guncellenecekVeri).whenComplete(() {
      Fluttertoast.showToast(msg: "Güncellendi");
    });
  }
}
