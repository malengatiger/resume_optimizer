import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../models/resume.dart';
import '../models/user.dart';
import 'functions.dart';

class Prefs {
  final SharedPreferences sharedPreferences;
  static const mm = '💜💜💜💜💜Prefs 💜💜';

  Prefs(this.sharedPreferences);

  Future saveUser(User user) async {
    pp('$mm ... User to be cached: ${user.toJson()}');

    Map mJson = user.toJson();
    var jx = json.encode(mJson);
    sharedPreferences.setString('user', jx);
    pp('$mm ... User saved OK');
  }

  User? getUser() {
    var string = sharedPreferences.getString('user');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var user = User.fromJson(jx);
    pp('$mm ... User found OK: ${user.name}');
    return user;
  }
  void saveMode(int mode) {
    sharedPreferences.setInt('mode', mode);
  }

  int getMode() {
    var mode = sharedPreferences.getInt('mode');
    if (mode == null) {
      pp('$mm ... mode not found, returning -1');
      return -1;
    }
    return mode;
  }

  void saveColorIndex(int index) async {
    sharedPreferences.setInt('color', index);
    pp('$mm ... color index cached: $index');
    return null;
  }

  int getColorIndex() {
    var color = sharedPreferences.getInt('color');
    if (color == null) {
      pp('$mm ... return default color index 0');
      return 0;
    }
    return color;
  }


  //
  void saveCurrentModel(String model) async {
    sharedPreferences.setString('aiModel', model);

    pp('$mm ... current model cached: $model');
    return null;
  }

  String getCurrentModel() {
    var model = sharedPreferences.getString('aiModel');
    if (model == null) {
      return modelGeminiAI;
    }
    pp('$mm ... model: $model');
    return model;
  }

  saveSkills(List<Skill> skills) {
    List<Map<String, dynamic>>skillStrings =
        skills.map((pm) => pm.toJson()).toList();
    List<String>skillJsonStrings =
       skillStrings.map((pm) =>
           json.encode(pm)).toList();
    sharedPreferences.setStringList('skills',skillJsonStrings);
    pp('$mm ... skills saved OK: ${skills.length}');
  }

  List<Skill> getSkills() {
    List<String>? paymentMethodJsonStrings =
        sharedPreferences.getStringList('skills');
    if (paymentMethodJsonStrings != null) {
      List<Skill> skills = paymentMethodJsonStrings
          .map((pmJson) =>
          Skill.fromJson(json.decode(pmJson)))
          .toList();
      pp('$mm ... skills retrieved: ${skills.length}');

      return skills;
    } else {
      return [];
    }
  }
}
const modelClaude = 'Claude';
const modelGeminiAI = 'Gemini';
const modelOpenAI = 'OpenAI';
const modelMistral = 'Mistral';
const modelPerplexityAI = 'PerplexityA';
const modelLlama2 = 'llama2-70b-4096';
const modelMixtral = 'mixtral-8x7b-32768';
const modelGemma = 'gemma-7b-it';
