import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:book_app_flutter/pref/book_pref.dart';

class PdfPage extends StatefulWidget {
  final String path;

  const PdfPage({super.key, required this.path});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final pref = BookPRef();
  final controller = PdfViewerController();
  var title = "PDF";
  late final file = File(widget.path);
  var offset = -1.0;

  @override
  void initState() {
    loadPosition();
    controller.addListener(() {
      title =
          "[${controller.pageNumber}/${controller.pageCount}] ${controller.scrollOffset.dy}";
      try {
        setState(() {});
      } catch (_) {}
    });
    super.initState();
  }

  Future<void> loadPosition() async {
    offset = await pref.getPosition(widget.path);
    setState(() {});
    // await Future.delayed(const Duration(milliseconds: 100));
    // controller.jumpTo(yOffset: offset);
  }

  @override
  void dispose() {
    pref.setPosition(widget.path, controller.scrollOffset.dy);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(title),
        //title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              //_pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     print(await pref.getPosition(widget.path));
      //     controller.jumpTo(yOffset: await pref.getPosition(widget.path));
      //   },
      // ),
      body: offset == -1
          ? const Center(child: CircularProgressIndicator())
          : SfPdfViewer.file(
              file,
              initialScrollOffset: Offset(0, offset),
              controller: controller,
            ),
    );
  }
}
