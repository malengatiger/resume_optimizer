import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:resume_optimizer/services/firestore_service.dart';
import 'package:resume_optimizer/ui/skills/skills_searcher.dart';
import 'package:resume_optimizer/ui/skills/user_skill_widget.dart';
import 'package:resume_optimizer/util/styles.dart';

import '../../models/resume.dart';
import '../../models/user.dart';
import '../../util/dialogs.dart';
import '../../util/functions.dart';
import '../../util/gaps.dart';
import '../../util/prefs.dart';

class SkillsEditor extends StatefulWidget {
  const SkillsEditor({super.key});

  @override
  SkillsEditorState createState() => SkillsEditorState();
}

class SkillsEditorState extends State<SkillsEditor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const mm = '🔵🔵🔵🔵 SkillsEditor  🔵🔵';

  List<Skill> skills = [];
  List<UserSkill> userSkills = [];
  User? user;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  bool _busy = false;
  FirestoreService firestoreService = GetIt.instance<FirestoreService>();
  Prefs prefs = GetIt.instance<Prefs>();

  _getData() async {
    pp('$mm ... getting data ...');
    setState(() {
      _busy = false;
    });
    try {
      user = prefs.getUser();
      skills = await firestoreService.getSkills();
      if (user != null) {
        userSkills =
        await firestoreService.getUserSkills(user!.firebaseUserId!);
      }
    } catch (e) {
      pp(e);
      if (mounted) {
        showErrorDialog(context, '$e');
      }
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

  List<Skill> selectedSkills = [];

  _buildSelectedSkills(List<Skill> skills) {
    for (var sk in skills) {
      userSkills.add(UserSkill(userSkillId: '${DateTime
          .now()
          .millisecondsSinceEpoch}',
          firebaseUserId: user?.firebaseUserId,
          skill: sk,
          yearsExperience: 0,
          skillLevel: 0,
          current: false));
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Skills Editor'),
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
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.5,
                          child: SkillsSearcher(
                              isGrid: false,
                              onSelected: (sk) {
                                setState(() {
                                  selectedSkills = sk;
                                });
                                _buildSelectedSkills(sk);
                              }),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${userSkills.length} ',
                                      style: myTextStyle(context, Theme
                                          .of(context)
                                          .primaryColor,
                                          20, FontWeight.w900)),
                                  gapW16,
                                  const Text('User Skills'),

                                ],
                              ),
                              gapH16,
                              Expanded(
                                child: userSkills.isEmpty
                                    ? Center(
                                    child: Text('No Skills Yet',
                                        style: myTextStyleLarge(context)))
                                    : UserSkillList(
                                    onTapped: (sk) {},
                                    userSkills: userSkills,
                                    isGrid: false),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            )));
  }
}

class UserSkillList extends StatelessWidget {
  const UserSkillList({super.key,
    required this.onTapped,
    required this.userSkills,
    required this.isGrid});

  final Function(UserSkill) onTapped;
  final List<UserSkill> userSkills;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    if (isGrid) {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: userSkills.length,
          itemBuilder: (_, index) {
            var us = userSkills.elementAt(index);
            return Card(
              elevation: 8,
              child: UserSkillWidget(
                userSkill: us,
              ),
            );
          });
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: userSkills.length,
            itemBuilder: (_, index) {
              var us = userSkills.elementAt(index);
              return UserSkillWidget(
                userSkill: us,
              );
            }),
      );
    }
  }
}
