import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:resume_optimizer/services/firestore_service.dart';
import 'package:resume_optimizer/util/gaps.dart';
import 'package:resume_optimizer/util/styles.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../util/dialogs.dart';
import '../../util/functions.dart';
import '../../util/prefs.dart';

class MyAuth extends StatefulWidget {
  const MyAuth({super.key});

  @override
  MyAuthState createState() => MyAuthState();
}

class MyAuthState extends State<MyAuth> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Prefs prefs = GetIt.instance<Prefs>();
  static const mm = '🔵🔵🔵🔵 MyAuth  🔵🔵';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  bool _busy = false;

  _getData() async {
    pp('$mm ... getting data ...');
    setState(() {
      _busy = false;
    });
    try {} catch (e) {
      pp(e);
      showErrorDialog(context, '$e');
    }
    setState(() {
      _busy = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  FirestoreService firestoreService = GetIt.instance<FirestoreService>();
  AuthService authService = GetIt.instance<AuthService>();
  var formKey = GlobalKey<FormState>();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final emailController = TextEditingController();

  bool registrationMode = true;

  onSubmit() async {
    pp('$mm ... onSubmit ... registrationMode: $registrationMode');
    try {
      if (registrationMode) {
            var user = User(
              name: 'TBD',
              email: emailController.text,
              password: passwordController1.text,
              firebaseUserId: '',
              date: DateTime.now().toUtc().toIso8601String(),
              skills: [],
            );
            await authService.registerUser(user);
          } else {
            await authService.signInUser(
                emailController.text, passwordController1.text);
          }
    } catch (e,s) {
      pp('$mm Auth Error: $e');
      if (mounted) {
        showErrorDialog(context, '${registrationMode? 'Registration failed': 'Sign In failed'}\n\n$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('ResumeOptimizer App'),
            ),
            body: ScreenTypeLayout.builder(
              mobile: (_) {
                return const Stack();
              },
              tablet: (_) {
                return const Stack();
              },
              desktop: (_) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Card(
                                  elevation: 8,
                                  child: Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              registrationMode
                                                  ? 'Register'
                                                  : 'Sign in',
                                              style: myTextStyle(
                                                  context,
                                                  Colors.black,
                                                  28,
                                                  FontWeight.w900)),
                                          gapH32,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              registrationMode
                                                  ? const Text(
                                                      'Already have an account?')
                                                  : const Text(
                                                      'Do you want to Register?'),
                                              gapW16,
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      registrationMode =
                                                          !registrationMode;
                                                    });
                                                  },
                                                  child: Text(registrationMode
                                                      ? 'Sign In'
                                                      : 'Register')),
                                            ],
                                          ),
                                          gapH32,
                                          SizedBox(
                                            width: 400,
                                            child: TextFormField(
                                              controller: emailController,
                                              decoration: const InputDecoration(
                                                  label: Text('Email Address'),
                                                  hintText:
                                                      'Enter Email Address'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 400,
                                            child: TextFormField(
                                              controller: passwordController1,
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                  label: Text('Password'),
                                                  hintText: 'Enter Password'),
                                            ),
                                          ),
                                          registrationMode
                                              ? SizedBox(
                                                  width: 400,
                                                  child: TextFormField(
                                                    controller:
                                                        passwordController2,
                                                    obscureText: true,
                                                    decoration: const InputDecoration(
                                                        label: Text(
                                                            'Enter Password Again'),
                                                        hintText:
                                                            'Enter Password'),
                                                  ),
                                                )
                                              : gapW32,
                                          gapH32,
                                          gapH32,
                                          SizedBox(
                                            width: 300,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  onSubmit();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(registrationMode
                                                      ? 'Register'
                                                      : 'Sign In'),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            )));
  }

  Future<void> _handleUser(SignedIn state) async {
    pp('$mm _handleUser: ${state.user}');

    if (state.user != null) {
      var user = await firestoreService.getUser(state.user!.uid);
      if (user == null) {
        var mUser = User(
            firebaseUserId: state.user!.uid,
            name: 'TBD',
            email: state.user!.email,
            date: DateTime.now().toUtc().toIso8601String(),
            skills: []);
        await firestoreService.addUser(mUser);
        prefs.saveUser(mUser);
        pp('$mm user added to Firestore: 🍎${mUser.email} 🍎');
      } else {
        pp('$mm user already exists ... cool! 🍎${user.email} 🍎');
        prefs.saveUser(user);
      }
    }
  }
}
