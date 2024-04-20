import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/resume.dart';
import '../util/functions.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PdfService {

  static const mm = '🍊🍊🍊 PdfService 🍊';
  /// Build a new PDF file from a Resume object
  Future<File> buildPdf(Resume resume) async {

    var dir = await getApplicationDocumentsDirectory();
    final pdf = pw.Document();

    //create new pdf

    // pdf.addPage(page)
    for (var i=0; i < resume.pages; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text("Hello World"),
            ); // Center
          })); // Page

    }

    final file = File("${dir.path}/${resume.resumeId}.pdf");
    await file.writeAsBytes(pdf.save() as List<int>);
    return file;
  }

  /// Upload resume pdf file to cloud storage
  Future<String> uploadFile(File file) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    try {
      await storage.ref(file.path).putFile(file);
    } on firebase_storage.FirebaseException catch (e) {
      var msg = "$mm cloud storage error: $e";
      pp(msg);
      throw Exception(msg);
    }
    String downloadURL = await storage.ref(file.path).getDownloadURL();
    return downloadURL;
  }
}