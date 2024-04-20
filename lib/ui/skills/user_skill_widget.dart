import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resume_optimizer/services/firestore_service.dart';

import '../../models/resume.dart';
import '../../models/user.dart';
import '../../util/functions.dart';
import '../../util/gaps.dart';
import '../../util/prefs.dart';
import '../../util/styles.dart';

class UserSkillWidget extends StatefulWidget {
  const UserSkillWidget({super.key, required this.userSkill});

  final UserSkill userSkill;

  @override
  UserSkillWidgetState createState() => UserSkillWidgetState();
}

class UserSkillWidgetState extends State<UserSkillWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const mm = ' 🔵🔵 🔵🔵UserSkillWidget';

  User? user;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getUser();
  }

  _getUser() async {
    user = prefs.getUser();
  }
  Prefs prefs = GetIt.instance<Prefs>();
  FirestoreService firestoreService = GetIt.instance<FirestoreService>();
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var proficiencyController = TextEditingController();
  var yearsController = TextEditingController();

  List<UserSkill> userSkills = [];
  onSubmit() async {
    pp('$mm onSubmit ....');
    userSkills  = await firestoreService.getUserSkills(user!.firebaseUserId!);
    var found = false;
    for (var usk in userSkills) {
      if (usk.skill?.id! == widget.userSkill.skill?.id) {
        found = true;
        usk.skillLevel = proficiency;
        usk.yearsExperience = yearsExperience;
        await firestoreService.updateUserSkill(usk);
        break;
      }
    }
    if (!found) {
      var usk = UserSkill(
          skill: widget.userSkill.skill,
          skillLevel: proficiency,
          yearsExperience: yearsExperience, 
          firebaseUserId: user!.firebaseUserId,
          userSkillId: '${DateTime.now().millisecondsSinceEpoch}', current: true);
      await firestoreService.addUserSkill(usk);
    }
  }

  int proficiency = 0;
  int yearsExperience = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
                 '${widget.userSkill.skill?.title}',
                style: myTextStyle(context, Colors.black, 20, FontWeight.w900)),
            gapH4,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                  Row(
                    children: [
                      const Text('Proficiency Level'),
                      gapW16,
                      NumberDropDown(
                          numbers: const [1, 2, 3, 4, 5],
                          onSelected: (n) {
                            setState(() {
                              proficiency = n;
                              widget.userSkill.skillLevel = n;
                            });
                          }),
                      gapW16,
                      Text('Level ${widget.userSkill.skillLevel} ', style: myTextStyleMediumLarge(context, 16),)
                    ],
                  ),
                   Text('Skill Level 5 is considered Expert', style: myTextStyleSmall(context)),

                  Row(
                    children: [
                      const Text('Experience in Years'),
                      gapW16,
                      NumberDropDown(
                          numbers: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15],
                          onSelected: (n) {
                            setState(() {
                              yearsExperience = n;
                              widget.userSkill.yearsExperience = n;
                            });
                          }),
                      gapW16,
                      Text('${widget.userSkill.yearsExperience} Years', style: myTextStyleMediumLarge(context, 16),)
                    ],
                  ),
                  gapH32,
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Save User Skill'),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberDropDown extends StatelessWidget {
  const NumberDropDown(
      {super.key, required this.numbers, required this.onSelected});

  final List<int> numbers;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> items = [];
    for (var value in numbers) {
      items.add(DropdownMenuItem(value: value, child: Text('$value')));
    }
    return DropdownButton<int>(
        items: items,
        onChanged: (n) {
          if (n != null) {
            onSelected(n);
          }
        });
  }
}
