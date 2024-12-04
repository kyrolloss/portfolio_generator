import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final String filePath;
  const PDFViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: filePath,
    );
  }
}
