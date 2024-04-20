import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:resume_optimizer/services/auth_service.dart';
import 'package:resume_optimizer/services/firestore_service.dart';
import 'package:resume_optimizer/services/pdf_service.dart';
import 'package:resume_optimizer/services/remotive_service.dart';
import 'package:resume_optimizer/services/resume_service.dart';
import 'package:resume_optimizer/services/scraper.dart';
import 'package:resume_optimizer/services/sort_listener.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/functions.dart';
import '../util/prefs.dart';
import 'dio_util.dart';
import 'groq_service.dart';

Future<void> registerServices(
    {required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth}) async {
  const mm = '🍎🍎🍎🍎🍎🍎RegisterServices';
  pp('$mm registerServices: initialize service singletons with GetIt .... 🍎🍎🍎');

  Dio dio = Dio();
  var dioUtil = DioUtil(dio);
  var pref = await SharedPreferences.getInstance();
  var prefs = Prefs(pref);
  var fss = FirestoreService(prefs, firebaseFirestore);
  var auth = AuthService(firebaseAuth, prefs, fss);

  //
  GetIt.instance.registerLazySingleton<Prefs>(() => prefs);
  GetIt.instance.registerLazySingleton<FirestoreService>(() => fss);
  GetIt.instance.registerLazySingleton<AuthService>(() => auth);

  GetIt.instance.registerLazySingleton<SortListener>(() => SortListener());
  GetIt.instance.registerLazySingleton<Scraper>(() => Scraper());
  GetIt.instance.registerLazySingleton<ResumeService>(() => ResumeService());

  GetIt.instance
      .registerLazySingleton<RemotiveService>(() => RemotiveService(dioUtil));
  GetIt.instance.registerLazySingleton<GroqService>(() => GroqService(dioUtil));
  GetIt.instance.registerLazySingleton<PdfService>(() => PdfService());

  pp('$mm : GetIt has registered 9 services.  🔵🔵 Cool!! 🍎🍎🍎');

  try {
    fss.getSkills();
    // Scraper scraper = GetIt.instance<Scraper>();
    // pp('$mm : Scraper may attempt to log in.  🔵🔵.... ');
    //
    // await DotEnv().load();
    // var email = dotenv.env['REMOTIVE_EMAIL'];
    // var password = dotenv.env['REMOTIVE_PASSWORD'];
    //
    // if (email != null && password != null) {
    //   pp('$mm email: $email password: $password');
    //   scraper.sendLoginRequest(email, password);
    // }
  } catch (e) {
    pp(e);
  }
}

const email0 = 'malenga';
const email1 = 'dev@gmail.com';
const p0 = 'Bju49Aaz';
const p1 = '@!r69UG';
const remotiveAddress = '$email0$email1';
const remotivePass = '$p0$p1';
