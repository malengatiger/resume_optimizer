import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resume_optimizer/services/firestore_service.dart';
import 'package:resume_optimizer/util/styles.dart';

import '../../models/resume.dart';
import '../../util/functions.dart';
import '../../util/gaps.dart';

class SkillsSearcher extends StatefulWidget {
  const SkillsSearcher(
      {super.key, required this.onSelected, required this.isGrid});

  final Function(List<Skill>) onSelected;
  final bool isGrid;

  @override
  SkillsSearcherState createState() => SkillsSearcherState();
}

class SkillsSearcherState extends State<SkillsSearcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Skill> skills = [];
  List<SkillCover> skillsToDisplay = [];
  List<Skill> selectedSkills = [];

  FirestoreService firestoreService = GetIt.instance<FirestoreService>();
  static const mm = ' 🌼🌼🌼SkillsSearcher 🥦 ';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  void _findSkill(String text) {
    skillsToDisplay.clear();
    for (var skill in skills) {
      if (skill.title!.toLowerCase().contains(text.toLowerCase())) {
        skillsToDisplay.add(SkillCover(skill, isSkillAlreadySelected(skill)));
      }
    }
    pp('$mm  searched $text; found: ${skillsToDisplay.length} skillsToDisplay');
    setState(() {});
  }

  bool _busy = false;

  _getData() async {
    setState(() {
      _busy = true;
    });
    try {
      skills = await firestoreService.getSkills();
      for (var sk in skills) {
        skillsToDisplay.add(SkillCover(sk, false));
      }
    } catch (e) {
      pp(e);
    }
    setState(() {
      _busy = false;
    });
  }

  addOrRemoveSkill(Skill skill) {
    var found = isSkillAlreadySelected(skill);
    if (!found) {
      selectedSkills.add(skill);
    } else {
      selectedSkills.remove(skill);
    }
    setState(() {});
  }

  bool isSkillAlreadySelected(Skill skill) {
    var found = false;
    for (var sk in selectedSkills) {
      if (skill.id == sk.id) {
        found = true;
        break;
      }
    }

    return found;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: TextField(
            controller: textController,
            onChanged: (m) {
              _findSkill(textController.text);
            },
            decoration: const InputDecoration(
              labelText: 'Enter skill search',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        gapH16,
        widget.isGrid
            ? Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: skillsToDisplay.length,
                    itemBuilder: (_, index) {
                      return SizedBox(
                        height: 48,
                        child: GestureDetector(
                          onTap: () {
                            pp('$mm tapped ${skillsToDisplay[index].skill.title}');
                            skillsToDisplay[index].selected = !skillsToDisplay[index].selected;
                            addOrRemoveSkill(skillsToDisplay[index].skill);
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: skillsToDisplay[index].selected,
                                  onChanged: (bool? value) {},
                                ),
                                gapW16,
                                Flexible(
                                    child: Text(
                                  '${skillsToDisplay[index].skill.title}',
                                  style: myTextStyleSmall(context),
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: skillsToDisplay.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          pp('$mm tapped ${skillsToDisplay[index].skill.title}');
                          skillsToDisplay[index].selected = !skillsToDisplay[index].selected;
                          addOrRemoveSkill(skillsToDisplay[index].skill);
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Checkbox(
                                value: skillsToDisplay[index].selected,
                                onChanged: (bool? value) {},
                              ),
                              gapW16,
                              Text('${skillsToDisplay[index].skill.title}'),
                            ],
                          ),
                        ),
                      );
                    })),
        gapH16,
        SizedBox(
          width: 300,
          child: ElevatedButton(
              onPressed: () {
                widget.onSelected(selectedSkills);
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Done'),
              )),
        ),
        gapH32,
        gapH32,
      ],
    );
  }
}

class SkillCover {
  late Skill skill;
  late bool selected;

  SkillCover(this.skill, this.selected);
}
