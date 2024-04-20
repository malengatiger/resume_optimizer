// import 'dart:io';

import 'dart:collection';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

import '../models/resume.dart';
import '../util/functions.dart';

class StorageService {
  static const mm = 'StorageService 🍊';

  Future<String> uploadFile(File file, String directory) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    try {
      await storage.ref('$directory/${file.path}').putFile(file);
    } on firebase_storage.FirebaseException catch (e) {
      // e.code == 'canceled'
    }
    String downloadURL =
        await storage.ref('$directory/${file.path}').getDownloadURL();
    return downloadURL;
  }
}

