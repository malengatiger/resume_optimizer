import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resume_optimizer/services/sort_listener.dart';
import 'package:resume_optimizer/util/gaps.dart';
import 'package:resume_optimizer/util/styles.dart';

class ListControlWidget extends StatefulWidget {
  const ListControlWidget({super.key});

  @override
  State<ListControlWidget> createState() => _ListControlWidgetState();
}

class _ListControlWidgetState extends State<ListControlWidget> {
  bool sortByDate = false;
  bool sortByName = false;
  bool sortByTitle = false;
  bool sortByCandidateLocation = false;
  bool sortByJobType = false;

  SortListener sortListener = GetIt.instance<SortListener>();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Text('Sort Control', style: myTextStyle(context,
                 Colors.black, 24, FontWeight.w900)),
            gapH32,
            CheckboxListTile(
              title: const Text('Sort by Date'),
              value: sortByDate,
              onChanged: (bool? value) {
                if (value != null) {
                  sortListener.onSingleChoice(Choices.sortByDate);
                }
                setState(() {
                  sortByDate = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sort by Name'),
              value: sortByName,
              onChanged: (bool? value) {
                if (value != null) {
                  sortListener.onSingleChoice(Choices.sortByName);
                }
                setState(() {
                  sortByName = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sort by Title'),
              value: sortByTitle,
              onChanged: (bool? value) {
                if (value != null) {
                  sortListener.onSingleChoice(Choices.sortByTitle);
                }
                setState(() {
                  sortByTitle = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sort by Candidate Location'),
              value: sortByCandidateLocation,
              onChanged: (bool? value) {
                if (value != null) {
                  sortListener.onSingleChoice(Choices.sortByCandidateLocation);
                }
                setState(() {
                  sortByCandidateLocation = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sort by Job Type'),
              value: sortByJobType,
              onChanged: (bool? value) {
                if (value != null) {
                  sortListener.onSingleChoice(Choices.sortByJobType);
                }
                setState(() {
                  sortByJobType = value!;
                });
              },
            ),
            gapH32,
            ElevatedButton(
              onPressed: () {
                processCheckboxes();
              },
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Refresh Job List'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processCheckboxes() {
    // TODO: Implement checkbox processing logic
  }
}
