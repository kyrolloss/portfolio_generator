import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../PDF View/PDF View.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  static HomeCubit get(context)=> BlocProvider.of(context);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController projectController = TextEditingController();
  final TextEditingController skillController = TextEditingController();


  List<Map<String, String>> experiences = [];
  List<String> skills = [];
  Color selectedColor = Colors.blue;
File? file;
Uint8List? bytes;


  Future<void> generatePDF(BuildContext context) async {
    addSkill();
    final pdf = pw.Document();

    final arabicFont =
    pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
    final englishFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
    final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Bold.ttf"));

    pdf.addPage(

      pw.MultiPage(

        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Column(
              children: [
                pw.Row(
                    children: [
                      pw.Text(
                        nameController.text,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 20,
                          font: englishFont,
                        ),
                      ),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.Text(
                        jobTitleController.text,
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 17,
                          font: englishFont,
                        ),
                      ),
                    ]
                ),
                pw.Divider(),

                pw.SizedBox(height: 10),
                pw.Text(
                  emailController.text,
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 15,
                    font: englishFont,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  phoneController.text,
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 15,
                    font: englishFont,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  linkedInController.text,
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 15,
                    font: englishFont,
                  ),
                ),
              ]
            )
          ),
          pw.SizedBox(height: 10),

          pw.Container(
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'نبزة عني: ${profileController.text}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    font: arabicFont,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),

              ],
            ),
          ),
          pw.SizedBox(height: 10),

          if (experiences.isNotEmpty) ...[
            pw.Header(level: 1, text: 'Work Experience'),
            ...experiences.map((exp) => pw.Bullet(text: "${exp['role']} (${exp['duration']})")),
          ],
          pw.SizedBox(height: 10),

          if (skills.isNotEmpty) ...[
            pw.Header(level: 1, text: 'Skills'),
            ...skills.map((skill) => pw.Bullet(text: skill)),
          ],
        ],
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(
              font: englishFont,
              fontSize: 12,
              color: PdfColors.grey,
            ),
          ),
        ),
      ),

    );

    final output = await getTemporaryDirectory();
     file = File("${output.path}/portfolio.pdf");
    await file?.writeAsBytes(await pdf.save());
    bytes = await file?.readAsBytes();
    emit(GeneratePDF());


  }
  void sharePDF(BuildContext context) async {
    await Printing.sharePdf(bytes: bytes!, filename: 'portfolio.pdf');
    emit(SharePDF());

  }
  Future<void> savePDFToDevice(BuildContext context, File file) async {
    final downloadsDirectory = await getExternalStorageDirectory();
    final savedPath = "${downloadsDirectory!.path}/portfolio.pdf";
    await file.copy(savedPath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF saved to $savedPath'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
          },
        ),
      ),
    );
    emit(DownloadPDF());
  }
  void addExperience(BuildContext context) {
    TextEditingController roleController = TextEditingController();
    String duration = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Work Experience'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    duration = "${date.year}-${date.month}-${date.day}";
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                );
              },
              child: const Text('Select Date'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
                experiences.add({'role': roleController.text, 'duration': duration});
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void addSkill() {
    if (skillController.text.isNotEmpty) {
        skills.add(skillController.text);
     }
  }


  void changeName(String name){
    name = nameController.text;
    emit(ChangeName());
  }

  Future<void> openPDFViewer(BuildContext context, File file) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(filePath: file.path),
      ),
    );
  }
}
