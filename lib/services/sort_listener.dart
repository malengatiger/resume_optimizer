
import 'dart:async';

class SortListener {
  final StreamController<Choices> _choicesController = StreamController.broadcast();
  final StreamController<String> _singleChoiceController = StreamController.broadcast();
  Stream<String> get singleChoice => _singleChoiceController.stream;
  Stream<Choices> get choices => _choicesController.stream;

  void onChoices(Choices choices) {
    _choicesController.sink.add(choices);
  }
  void onSingleChoice(String sortBy) {
    _singleChoiceController.sink.add(sortBy);
  }
  void dispose() {
    _choicesController.close();
    _singleChoiceController.close();
  }
}

class Choices {
  static const sortByDate = 'sortByDate';
  static const sortByName = 'sortByName';
  static const sortByTitle = 'sortByTitle';
  static const sortByCandidateLocation = 'sortByCandidateLocation';
  static const sortByJobType = 'sortByJobType';

}