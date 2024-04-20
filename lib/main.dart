import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:resume_optimizer/services/register_services.dart';
import 'package:resume_optimizer/ui/auth/my_auth.dart';
import 'package:resume_optimizer/ui/job_list.dart';
import 'package:resume_optimizer/util/functions.dart';
import 'package:resume_optimizer/util/navigation_util.dart';
import 'package:resume_optimizer/util/prefs.dart';

import 'firebase_options.dart';
import 'models/user.dart';

const mx = '🦠🦠🦠Resume Optimizer Chatbot 🦠🦠🦠';

User? user;

void main() async {
  pp('$mx Resume Optimizer Chatbot starting .... $mx');
  WidgetsFlutterBinding.ensureInitialized();

  try {
    pp('$mx setting up DotEnv .....');
    await dotenv.load(fileName: ".env");
    var email = dotenv.env['REMOTIVE_EMAIL'];
    pp('$mx ........ env loaded ??? REMOTIVE_EMAIL:'
        ' $email');
  } catch (e, s) {
    pp('$mx DotEnv Error: 🍎${e.toString()} 🍎$s');
  }
  //
  await _performSetup();
  runApp(const MyApp());
}

Future _performSetup() async {
  try {
    var app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    pp('$mx ... Firebase has been initialized! name: ${app.name}');
    pp('$mx ${app.options.asMap}');
    var fbf = FirebaseFirestore.instanceFor(app: app);
    var auth = fa.FirebaseAuth.instanceFor(app: app);
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    await registerServices(firebaseFirestore: fbf, firebaseAuth: auth);
    Prefs prefs = GetIt.instance<Prefs>();
    user = prefs.getUser();
    if (user == null) {
      pp('$mx 😡😡😡 User needs to authenticate 😡😡😡');
    } else {
      pp('$mx User is authenticated:  🌸 🌸 ${user?.toJson()}  🌸....');
    }

    //
  } catch (e, s) {
    pp('$mx $e \n$s');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Resume Optimizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: user == null
          ? const MyAuth()
          : const JobList(),
    );
  }
}

class ResumeOptimizerApp extends StatelessWidget {
  const ResumeOptimizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return MaterialApp(
      initialRoute: fa.FirebaseAuth.instance.currentUser == null
          ? '/sign-in'
          : '/profile',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
            ],
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            providers: providers,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
      },
    );
  }
}
