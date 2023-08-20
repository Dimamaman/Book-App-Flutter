import 'dart:io';

import 'package:book_app_flutter/core/api/book_api.dart';
import 'package:book_app_flutter/core/api/book_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:book_app_flutter/pdf/pdf_page.dart';

class DetailScreen extends StatefulWidget {

  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

enum Status { initial, loading, fail, success }



class _DetailScreenState extends State<DetailScreen> {

  final api = BookApi();
  var status = Status.initial;
  late BookModel book;
  var hasPdf = false;
  var path = "";
  var progress = 0;

  @override
  void initState() {
    _loadData().then((value) => checkPdf());
    super.initState();
  }

  Future<void> checkPdf() async {
    final dir = await getApplicationDocumentsDirectory();
    path = "${dir.path}/${book.name}";
    final file = File(path);
    hasPdf = await file.exists();
    setState(() {});
  }

  Future<void> _loadData() async {
    status = Status.loading;
    setState(() {});

    try{
      book = await api.getBookById(widget.id);
      status = Status.success;
    }catch(e) {
      status = Status.fail;
    }
    setState(() {});
  }

  Future<void> onDownload() async {
    if (hasPdf) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PdfPage(path: path)),);
      return;
    }
    await Dio().download(
      book.pdf,
      path,
      onReceiveProgress: (count, total) {
        progress = 100 * count ~/ total;
        setState(() {});
      },
    );
    hasPdf = true;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        if(status == Status.loading) {
          return const Center(
              child: CircularProgressIndicator()
          );
        }

        if (status == Status.fail) {
          return const Center(
            child: Text("Xatolik", style: TextStyle(fontSize: 32)),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width:180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(book.image, fit: BoxFit.cover,),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  book.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.author,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  book.author_desc,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: onDownload,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Builder(builder: (context) {
                      if (hasPdf) {
                        return const Text(
                          "Ochish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                      if (progress != 0) {
                        return CircularProgressIndicator();
                      }
                      return const Text(
                        "Yuklash",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}
