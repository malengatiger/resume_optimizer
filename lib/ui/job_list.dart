import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:resume_optimizer/services/remotive_service.dart';
import 'package:resume_optimizer/services/sort_listener.dart';
import 'package:resume_optimizer/ui/list_control_widget.dart';
import 'package:resume_optimizer/ui/skills/skills_editor.dart';
import 'package:resume_optimizer/util/gaps.dart';
import 'package:resume_optimizer/util/navigation_util.dart';
import 'package:resume_optimizer/util/styles.dart';

import '../remotive/remotive_job.dart';
import '../util/dialogs.dart';
import '../util/functions.dart';
import '../util/utilities.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  JobListState createState() => JobListState();
}

class JobListState extends State<JobList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const mm = '🔵🔵🔵🔵 JobList  🔵🔵';
  List<RemotiveJob> jobs = [];
  List<RemotiveJob> jobsToDisplay = [];

  RemotiveService remotiveService = GetIt.instance<RemotiveService>();
  SortListener sortListener = GetIt.instance<SortListener>();
  late StreamSubscription<String> subscription;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
    _listen();
  }

  String sortBy = Choices.sortByDate;

  _listen() async {
    subscription = sortListener.singleChoice.listen((sortBy) {
      pp('$mm .... received from stream: sortBy: $sortBy');
      switch (sortBy) {
        case Choices.sortByDate:
          jobsToDisplay
              .sort((a, b) => b.publicationDate!.compareTo(a.publicationDate!));
          break;
        case Choices.sortByTitle:
          jobsToDisplay.sort((a, b) => a.title!.compareTo(b.title!));
          break;
        case Choices.sortByJobType:
          jobsToDisplay.sort((a, b) => a.jobType!.compareTo(b.jobType!));
          break;
        case Choices.sortByName:
          jobsToDisplay.sort((a, b) => a.company!.compareTo(b.company!));
          break;
        case Choices.sortByCandidateLocation:
          jobsToDisplay.sort((a, b) => a.candidateRequiredLocation!
              .compareTo(b.candidateRequiredLocation!));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  bool _busy = false;
  List<String> locations = [];
  List<String> skills = [];

  _getData() async {
    pp('$mm ... getting data ...');
    setState(() {
      _busy = false;
    });
    try {
      jobs = await remotiveService.fetchJobs(
        category: 'software-dev',
        locations: locations,
        skills: skills,
      );
      pp('$mm jobs found: ${jobs.length}');
      jobsToDisplay = jobs;
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

  _navigateToSkillsEditor() {
    NavigationUtils.navigateToPage(
        context: context, widget: const SkillsEditor());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Remotive Job List',
                  style:
                      myTextStyle(context, Colors.black, 28, FontWeight.w900)),
              actions: [
                IconButton(
                    onPressed: () {
                      _navigateToSkillsEditor();
                    },
                    icon: const Icon(Icons.pan_tool))
              ],
            ),
            body: ScreenTypeLayout.builder(
              mobile: (_) {
                return MyList(jobs: jobsToDisplay);
              },
              tablet: (_) {
                return MyList(jobs: jobsToDisplay);
              },
              desktop: (_) {
                return Column(
                  children: [
                    // JobSearch(
                    //   jobs: jobs,
                    //   onSearched: (found) {
                    //     setState(() {
                    //       jobsToDisplay = found;
                    //     });
                    //   },
                    // ),
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(
                              width: 400,
                              height: 500,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ListControlWidget(),
                              )),
                          SizedBox(
                              width: 600,
                              height: height,
                              child: MyList(jobs: jobsToDisplay)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )));
  }
}

class MyList extends StatelessWidget {
  const MyList({
    super.key,
    required this.jobs,
  });

  final List<RemotiveJob> jobs;

  @override
  Widget build(BuildContext context) {
    return ListWidget(remotiveJobs: jobs);
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.remotiveJobs});

  final List<RemotiveJob> remotiveJobs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: remotiveJobs.length,
      itemBuilder: (context, index) {
        return JobWidget(remotiveJob: remotiveJobs.elementAt(index));
      },
    );
  }
}

class JobWidget extends StatelessWidget {
  const JobWidget({super.key, required this.remotiveJob});

  final RemotiveJob remotiveJob;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    remotiveJob.title!,
                    style:
                        myTextStyle(context, Colors.black, 18, FontWeight.w900),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(remotiveJob.company!,
                      style: myTextStyle(context,
                          Theme.of(context).primaryColor, 16, FontWeight.w600)),
                ),
                gapW32,
                const Text('Candidate Location'),
                gapW8,
                Text(remotiveJob.candidateRequiredLocation!,
                    style: myTextStyle(context, Theme.of(context).primaryColor,
                        14, FontWeight.w900)),
              ],
            ),
            Row(
              children: [
                const Text('Publication Date'),
                gapW8,
                Text(Utilities.calcDaysHours(remotiveJob.publicationDate!),
                    style:
                        myTextStyle(context, Colors.blue, 12, FontWeight.w900)),
              ],
            )
            // Text(remotiveJob.description!),
          ],
        ),
      ),
    );
  }
}

class JobSearch extends StatelessWidget {
  const JobSearch({
    super.key,
    required this.jobs,
    required this.onSearched,
  });

  final List<RemotiveJob> jobs;
  final Function(List<RemotiveJob>) onSearched;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<RemotiveJob>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          onSearched(jobs);
        }
        var mJobs = jobs.where((RemotiveJob job) => job.title!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
        List<RemotiveJob> rJobs = [];
        for (var job in mJobs) {
          rJobs.add(job);
        }
        onSearched(rJobs);
        return rJobs;
      },
      onSelected: (RemotiveJob selection) {
        // do something with the selected job
      },
    );
  }
}
