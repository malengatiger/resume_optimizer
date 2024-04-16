import '../models/experience.dart';
import '../models/resume.dart';

class ResumeService {
  Future addResume(Resume resume) async {
//add Resume to database
  }

  Future getProfile(Resume resume) async {
//call LLM API to generate resume profile
  }

  Future<List<Resume>> getResumes() async {
    // Call API to fetch resumes from database
    return [];
  }

  Future<List<Experience>> getExperiences(List<Experience> experiences) async {
    List<Experience> mList = [];

    return mList;
  }
}
