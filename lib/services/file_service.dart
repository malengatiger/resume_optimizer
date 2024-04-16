import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class FileService {

  Future<File?> downloadFile(String url) async {

    return null;
  }
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return null;
    }
  }
  Future<List<File>> getFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    return [];
}
