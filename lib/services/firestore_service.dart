import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:resume_optimizer/services/storage_service.dart';

import '../models/resume.dart';
import '../models/user.dart';
import '../util/functions.dart';
import '../util/prefs.dart';

class FirestoreService {
  final Prefs prefs;

  static const mm = ' 🥦🥦🥦FirestoreService 🥦 ';
  final FirebaseFirestore firebaseFirestore;

  FirestoreService(this.prefs,
      this.firebaseFirestore,) {
    // init();
  }

  Future<List<Skill>> getSkills() async {
    pp('$mm getSkills .....');
    List<Skill> docs = [];
    var querySnapshot =
    await firebaseFirestore.collection('Skill')
        .orderBy("title").get();
    pp('$mm getSkills ..... querySnapshot found: ${querySnapshot.docs.length}');

    for (var s in querySnapshot.docs) {
      var doc = Skill.fromJson(s.data());
      docs.add(doc);
    }
    if (docs.isEmpty) {
      pp('$mm getSkills: no skills found; will fetch from json string');

      var skills = await fetchSkillsFromFile();
      for (var skill in skills) {
        await addSkill(skill);
        docs.add(skill);
      }
    } else {
      pp('$mm getSkills ..... found: ${docs.length}');
    }
    docs.sort((a,b) => a.title!.compareTo(b.title!));
    pp('$mm getSkills ... 🍎found: ${docs.length} ');
    return docs;
  }

  Future addSkill(Skill skill) async {
    var colRef = firebaseFirestore.collection('Skill');
    var res = await colRef.add(skill.toJson());
    pp('$mm skill added to Firestore: ${res.path}  🖐🏽${skill.toJson()} 🍎');
  }

  Future addUser(User user) async {
    try {
      var colRef =
          firebaseFirestore.collection('User');
      var res = await colRef.add(user.toJson());
      pp('$mm addUser OK!:  🖐🏽${res.path}');

    } catch (e,s) {
      pp('$mm addUser failed: 😡$e 😡$s');
    }
  }

  Future<void> addUserSkill(UserSkill userSkill) async {
    var colRef =
    firebaseFirestore.collection('UserSkill');
    await colRef.doc(userSkill.userSkillId).set({
      'firebaseUserId': userSkill.firebaseUserId,
      'yearsExperience': userSkill.yearsExperience,
      'skillLevel': userSkill.skillLevel,
      'current': userSkill.current,
      'skill': userSkill.skill?.toJson(),
    });
    pp('$mm addUserSkill OK!:  🖐🏽${userSkill.skill?.title}');

  }
  Future deleteUserSkill(UserSkill userSkill) async {
    var colRef = firebaseFirestore.collection('UserSkill');
    var querySnapshot =
    await colRef.where('userSkillId', isEqualTo: userSkill.userSkillId).get();

    // Delete the document if it exists
    if (querySnapshot.docs.isNotEmpty) {
      var docId = querySnapshot.docs.first.id;
      var res = await colRef.doc(docId).delete();
      pp('$mm userSkill deleted from Firestore:🖐🏽${userSkill.toJson()}');
    }
  }
  Future<void> updateUserSkill(UserSkill userSkill) async {
    var colRef = firebaseFirestore.collection('UserSkill');
    var querySnapshot = await colRef
        .where('userSkillId', isEqualTo: userSkill.userSkillId)
        .get();

    var map = {
      'firebaseUserId': userSkill.firebaseUserId,
      'yearsExperience': userSkill.yearsExperience,
      'skillLevel': userSkill.skillLevel,
      'current': userSkill.current,
      'skill': userSkill.skill?.toJson(),
    };
    // Update the document if it exists
    if (querySnapshot.docs.isNotEmpty) {
      var docId = querySnapshot.docs.first.id;
      var res = await colRef.doc(docId).update(map);
      pp('$mm userSkill updated in Firestore: ${userSkill.toJson()}');
    }
  }
  Future<List<UserSkill>> getUserSkills(String firebaseUserId) async {
    pp('$mm getUserSkills .....');
    List<UserSkill> docs = [];
    var querySnapshot =
    await firebaseFirestore.collection('UserSkill')
        .where('firebaseUserId', isEqualTo: firebaseUserId)
        .orderBy("skill.title").get();
    for (var s in querySnapshot.docs) {
      var doc = UserSkill.fromJson(s.data());
      docs.add(doc);
    }

    pp('$mm getUserSkills ... 🍎found: ${docs.length} ');
    return docs;
  }

  Future<User?> getUser(String firebaseUserId) async {
    pp('$mm ... getUser from Firestore ... firebaseUserId: $firebaseUserId');
    List<User> list = [];
    var qs = await firebaseFirestore
        .collection('User')
        .where('firebaseUserId', isEqualTo: firebaseUserId)
        .get();
    for (var snap in qs.docs) {
      list.add(User.fromJson(snap.data()));
    }
    pp('$mm ... users found: ${list.length}');

    if (list.isNotEmpty) {
      prefs.saveUser(list.first);
      return list.first;
    }
    return null;
  }


  Future<List<Skill>> fetchSkillsFromFile() async {
    List<dynamic> jsonSkills = jsonDecode(skillsJson);
    List<Skill> skills =
    jsonSkills.map((jsonSkill) => Skill.fromJson(jsonSkill)).toList();

    pp(' 🖐🏽 skills before filter:  ${skills.length}');
    HashMap<String, Skill> map = HashMap();
    for (var value in skills) {
      map['${value.title}'] = value;
    }
    List<Skill> outSkills = [];
    int index = 0;
    for (var value1 in map.values.toList()) {
      outSkills.add(Skill(index + 1, value1.title));
      index++;
    }
    pp(' 🖐🏽 skills after filter:  ${outSkills.length}');
    return outSkills;
  }
}

const skillsJson = '''
[
  {
    "id": 1,
    "title": "AI"
  },
  {
    "id": 2,
    "title": "Agile Development"
  },
  {
    "id": 3,
    "title": "Algorithm Design"
  },
  {
    "id": 4,
    "title": "Android Development"
  },
  {
    "id": 5,
    "title": "AngularJS"
  },
  {
    "id": 6,
    "title": "AWS"
  },
  {
    "id": 7,
    "title": "AWS Lambda"
  },
  {
    "id": 8,
    "title": "Backend Engineering"
  },
  {
    "id": 9,
    "title": "C#"
  },
  {
    "id": 10,
    "title": "C++"
  },
  {
    "id": 11,
    "title": "Chatbot Engineering"
  },
  {
    "id": 12,
    "title": "Cloud Computing"
  },
  {
    "id": 13,
    "title": "CSS"
  },
  {
    "id": 14,
    "title": "Data Analysis"
  },
  {
    "id": 15,
    "title": "Data Engineering"
  },
  {
    "id": 16,
    "title": "Data Science"
  },
  {
    "id": 17,
    "title": "Django"
  },
  {
    "id": 18,
    "title": "Frontend Development"
  },
  {
    "id": 19,
    "title": "GCP"
  },
  {
    "id": 20,
    "title": "GCP BigQuery"
  },
  {
    "id": 21,
    "title": "GCP Compute Engine"
  },
  {
    "id": 22,
    "title": "GCP Dataflow"
  },
  {
    "id": 23,
    "title": "GCP Firestore"
  },
  {
    "id": 24,
    "title": "GCP Kubernetes"
  },
  {
    "id": 25,
    "title": "GCP Pub/Sub"
  },
  {
    "id": 26,
    "title": "HTML"
  },
  {
    "id": 27,
    "title": "iOS Development"
  },
  {
    "id": 28,
    "title": "Java"
  },
  {
    "id": 29,
    "title": "JavaScript"
  },
  {
    "id": 30,
    "title": "MongoDB"
  },
  {
    "id": 31,
    "title": "Node.js"
  },
  {
    "id": 32,
    "title": "NoSQL"
  },
  {
    "id": 33,
    "title": "PHP"
  },
  {
    "id": 34,
    "title": "Python"
  },
  {
    "id": 35,
    "title": "React"
  },
  {
    "id": 36,
    "title": "Ruby on Rails"
  },
  {
    "id": 37,
    "title": "Scrum"
  },
  {
    "id": 38,
    "title": "Software Architecture"
  },
  {
    "id": 39,
    "title": "Software Development Life Cycle (SDLC)"
  },
  {
    "id": 40,
    "title": "SQL"
  },
  {
    "id": 41,
    "title": "Swift"
  },
  {
    "id": 42,
    "title": "Test-Driven Development (TDD)"
  },
  {
    "id": 43,
    "title": "Typescript"
  },
  {
    "id": 44,
    "title": "UI/UX Design"
  },
  {
    "id": 45,
    "title": "Version Control (e.g., Git)"
  },
  {
    "id": 46,
    "title": "Web Development"
  },
  {
    "id": 47,
    "title": "XML"
  },
  {
    "id": 48,
    "title": "DynamoDB"
  },

    {"id": 11, "title": "AWS API Gateway"},
    {"id": 42, "title": "AWS API Gateway"},
    {"id": 20, "title": "AWS Aurora"},
    {"id": 30, "title": "AWS Aurora Serverless"},
    {"id": 12, "title": "AWS CloudFormation"},
    {"id": 24, "title": "AWS CodeCommit"},
    {"id": 22, "title": "AWS CodeDeploy"},
    {"id": 23, "title": "AWS CodePipeline"},
    {"id": 34, "title": "AWS Certificate Manager"},
    {"id": 36, "title": "AWS CloudFront"},
    {"id": 41, "title": "AWS CloudFront"},
    {"id": 32, "title": "AWS CloudTrail"},
    {"id": 28, "title": "AWS EKS"},
    {"id": 9, "title": "AWS ECS"},
    {"id": 29, "title": "AWS ECS Fargate"},
    {"id": 2, "title": "AWS Lambda"},
    {"id": 43, "title": "AWS Lambda"},
    {"id": 3, "title": "AWS EC2"},
    {"id": 35, "title": "AWS EMR"},
    {"id": 17, "title": "AWS EMR"},
    {"id": 6, "title": "AWS DynamoDB"},
    {"id": 16, "title": "AWS Glue"},
    {"id": 18, "title": "AWS IAM"},
    {"id": 7, "title": "AWS IAM"},
    {"id": 13, "title": "AWS Kinesis"},
    {"id": 14, "title": "AWS Redshift"},
    {"id": 15, "title": "AWS RDS"},
    {"id": 5, "title": "AWS RDS"},
    {"id": 37, "title": "AWS Route 53"},
    {"id": 38, "title": "AWS Secrets Manager"},
    {"id": 39, "title": "AWS Step Functions"},
    {"id": 25, "title": "AWS Step Functions"},
    {"id": 26, "title": "AWS Transit Gateway"},
    {"id": 40, "title": "AWS VPC"},
    {"id": 8, "title": "AWS CloudWatch"},
    {"id": 10, "title": "AWS Elastic Beanstalk"},
    {"id": 31, "title": "AWS CDK"},
    {"id": 33, "title": "AWS Cognito"},
    {"id": 21, "title": "AWS Direct Connect"},
    {"id": 19, "title": "AWS Organizations"},
    {"id": 27, "title": "AWS VPN"},
    {"id": 1, "title": "AWS"},
    {"id": 9, "title": "GCP AI Platform"},
    {"id": 10, "title": "GCP BigQuery"},
    {"id": 11, "title": "GCP Cloud Datastore"},
    {"id": 12, "title": "GCP Cloud Functions"},
    {"id": 13, "title": "GCP Cloud Pub/Sub"},
    {"id": 14, "title": "GCP Compute Engine"},
    {"id": 15, "title": "GCP Dataflow"},
    {"id": 16, "title": "GCP Dataproc"},
    {"id": 17, "title": "GCP Firestore"},
    {"id": 18, "title": "GCP Cloud Storage"},
    {"id": 19, "title": "GCP Cloud SQL"},
    {"id": 20, "title": "GCP Kubernetes Engine"},
    {"id": 21, "title": "GCP Memorystore"},
    {"id": 22, "title": "GCP Pub/Sub"},
    {"id": 23, "title": "GCP Spanner"},
    {"id": 24, "title": "GCP VM Instances"},
    {"id": 25, "title": "GCP Cloud Composer"},
    {"id": 26, "title": "GCP Cloud Run"},
    {"id": 27, "title": "GCP Cloud Tasks"},
    {"id": 28, "title": "GCP Cloud Build"},
    {"id": 29, "title": "GCP Cloud Deployment Manager"},
    {"id": 30, "title": "GCP Cloud Monitoring"},
    {"id": 31, "title": "GCP Cloud Logging"},
    {"id": 32, "title": "GCP Cloud IAM"},
    {"id": 33, "title": "GCP Cloud Identity"},
    {"id": 34, "title": "GCP Cloud Security Command Center"},
    {"id": 35, "title": "GCP Cloud Billing"},
    {"id": 36, "title": "GCP Cloud Resource Manager"},
    {"id": 37, "title": "GCP Cloud Functions"},
    {"id": 38, "title": "GCP Anthos"},
    {"id": 39, "title": "GCP Apigee"},
    {"id": 40, "title": "GCP Apigee hybrid"},
    {"id": 41, "title": "GCP Cloud Endpoints"},
    {"id": 42, "title": "GCP Cloud DNS"},
    {"id": 43, "title": "GCP Cloud VPN"},
    {"id": 44, "title": "GCP VPC"},
    {"id": 45, "title": "GCP CDN"},
    {"id": 46, "title": "GCP Cloud Armor"},
    {"id": 47, "title": "GCP Identity-Aware Proxy (IAP)"},
    {"id": 48, "title": "GCP SSL Certificates"},

    {"id": 1, "title": "Azure Active Directory"},
    {"id": 2, "title": "Azure App Service"},
    {"id": 3, "title": "Azure Blob Storage"},
    {"id": 4, "title": "Azure Cosmos DB"},
    {"id": 5, "title": "Azure Data Factory"},
    {"id": 6, "title": "Azure DevOps"},
    {"id": 7, "title": "Azure Functions"},
    {"id": 8, "title": "Azure Kubernetes Service (AKS)"},
    {"id": 9, "title": "Azure Logic Apps"},
    {"id": 10, "title": "Azure Machine Learning"},
    {"id": 11, "title": "Azure Monitor"},
    {"id": 12, "title": "Azure SQL Database"},
    {"id": 13, "title": "Azure Virtual Machines"},
    {"id": 14, "title": "Azure Virtual Network"},
    {"id": 15, "title": "Azure Web Apps"},
    {"id": 16, "title": "Azure Functions"},
    {"id": 17, "title": "Azure Key Vault"},
    {"id": 18, "title": "Azure DevTest Labs"},
    {"id": 19, "title": "Azure Traffic Manager"},
    {"id": 20, "title": "Azure Backup"},
    {"id": 21, "title": "Azure Site Recovery"},
    {"id": 22, "title": "Azure CDN"},
    {"id": 23, "title": "Azure Storage Account"},
    {"id": 24, "title": "Azure HDInsight"},
    {"id": 25, "title": "Azure Data Lake Storage"},
    {"id": 26, "title": "Azure Event Grid"},
    {"id": 27, "title": "Azure Event Hubs"},
    {"id": 28, "title": "Azure File Storage"},
    {"id": 29, "title": "Azure Sphere"},
    {"id": 30, "title": "Azure Stream Analytics"},
    {"id": 31, "title": "Azure Batch"},
    {"id": 32, "title": "Azure Search"},
    {"id": 33, "title": "Azure Redis Cache"},
    {"id": 34, "title": "Azure API Management"},
    {"id": 35, "title": "Azure CDN"},

    {"id": 1, "title": "Java"},
    {"id": 2, "title": "Java Spring Framework"},
    {"id": 3, "title": "Java Spring Boot"},
    {"id": 4, "title": "Java Hibernate"},
    {"id": 5, "title": "Java JDBC"},
    {"id": 6, "title": "Java Servlets"},
    {"id": 7, "title": "Java JSP"},
    {"id": 8, "title": "Java JPA"},
    {"id": 9, "title": "Java RESTful Web Services"},
    {"id": 10, "title": "Java SOAP Web Services"},
    {"id": 11, "title": "Java Swing"},
    {"id": 12, "title": "JavaFX"},
    {"id": 13, "title": "Java Multithreading"},
    {"id": 14, "title": "Java Collections Framework"},
    {"id": 15, "title": "Java Generics"},
    {"id": 16, "title": "Java Stream API"},
    {"id": 17, "title": "Java Design Patterns"},
    {"id": 18, "title": "Java Unit Testing (JUnit)"},
    {"id": 19, "title": "Java Build Tools (Maven, Gradle)"},
    {"id": 20, "title": "Java Logging (Log4j, SLF4J)"},
    {"id": 21, "title": "Java Security"},
    {"id": 22, "title": "Java Concurrency"},
    {"id": 23, "title": "Java Performance Optimization"},
    {"id": 24, "title": "Java GUI Development"},
    {"id": 25, "title": "Java Web Development"},
    {"id": 26, "title": "Java Microservices"},
    {"id": 27, "title": "Java Enterprise Edition (Java EE)"},
    {"id": 28, "title": "Java Server Faces (JSF)"},
    {"id": 29, "title": "Java Message Service (JMS)"},
    {"id": 30, "title": "Java Persistence API (JPA)"},
    {"id": 31, "title": "Java Batch Processing"},
    {"id": 32, "title": "Java Reflection API"},
    {"id": 33, "title": "Java XML Processing (DOM, SAX, JAXB)"},
    {"id": 34, "title": "Java JSON Processing (Jackson, Gson)"},
    {"id": 35, "title": "Java Enterprise Integration"},
    {"id": 36, "title": "Java Functional Programming"},
    {"id": 37, "title": "Java Networking (Socket Programming)"},
    {"id": 38, "title": "Java Internationalization (i18n)"},
    {"id": 39, "title": "Java Native Interface (JNI)"},
  {"id": 25, "title": "TypeScript Frameworks (Angular, React)"},
  {"id": 26, "title": "TypeScript Node.js Development"},
  {"id": 27, "title": "TypeScript Express.js Development"},
  {"id": 28, "title": "TypeScript Vue.js Development"},
  {"id": 29, "title": "TypeScript GraphQL Development"},
  {"id": 1, "title": "Backend Engineering"},
  {"id": 2, "title": "API Development"},
  {"id": 3, "title": "Authentication"},
  {"id": 4, "title": "Authorization"},
  {"id": 5, "title": "Caching Strategies"},
  {"id": 6, "title": "Concurrency Control"},
  {"id": 7, "title": "Database Management"},
  {"id": 8, "title": "Distributed Systems"},
  {"id": 9, "title": "Error Handling"},
  {"id": 10, "title": "Event-Driven Architecture"},
  {"id": 11, "title": "GraphQL"},
  {"id": 12, "title": "Load Balancing"},
  {"id": 13, "title": "Message Queues"},
  {"id": 14, "title": "Microservices Architecture"},
  {"id": 15, "title": "ORM (Object-Relational Mapping)"},
  {"id": 16, "title": "RESTful APIs"},
  {"id": 17, "title": "Server-Side Rendering (SSR)"},
  {"id": 18, "title": "Session Management"},
  {"id": 19, "title": "Socket Programming"},
  {"id": 20, "title": "SQL Optimization"},
  {"id": 21, "title": "Versioning (API)"},
  {"id": 22, "title": "Web Security"},
  {"id": 23, "title": "WebSockets"},
  {"id": 24, "title": "Workflow Automation"},

    {"id": 1, "title": "Cross-Platform Mobile Development"},
    {"id": 2, "title": "Flutter"},
    {"id": 3, "title": "React Native"},
    {"id": 4, "title": "Xamarin"},
    {"id": 5, "title": "Ionic Framework"},
    {"id": 6, "title": "PhoneGap / Apache Cordova"},
    {"id": 7, "title": "Electron (Cross-Platform Desktop Apps)"},
    {"id": 8, "title": "NW.js (Node-WebKit)"},
    {"id": 9, "title": "NativeScript"},
    {"id": 10, "title": "Qt (Cross-Platform Desktop Apps)"},
    {"id": 11, "title": "JavaFX (Cross-Platform Desktop Apps)"},
    {"id": 12, "title": "Kivy (Python Framework)"},
    {"id": 13, "title": "React Native Web"},
    {"id": 14, "title": "Flutter Web"},
    {"id": 15, "title": "Electron (Cross-Platform Web Apps)"},
    {"id": 16, "title": "React Native Windows"},
    {"id": 17, "title": "React Native macOS"},
    {"id": 18, "title": "React Native Desktop"},
    {"id": 19, "title": "Apache Cordova Plugins"},
    {"id": 20, "title": "Capacitor (Cross-Platform Native Runtime)"},
    {"id": 21, "title": "Cocos2d-x (Cross-Platform Game Development)"},
    {"id": 22, "title": "Unity (Cross-Platform Game Development)"},
    {"id": 23, "title": "Godot Engine (Cross-Platform Game Development)"},
    {"id": 24, "title": "Phaser (Cross-Platform Game Development)"},
    {"id": 25, "title": "Marmalade SDK (Cross-Platform Game Development)"},
    {"id": 26, "title": "Appcelerator Titanium"},
    {"id": 27, "title": "Adobe PhoneGap Build"},
    {"id": 28, "title": "Corona SDK"},
    {"id": 29, "title": "GameMaker Studio"},
    {"id": 30, "title": "Mendix (Low-Code Platform)"},
    {"id": 31, "title": "OutSystems (Low-Code Platform)"},
    {"id": 32, "title": "PowerApps (Low-Code Platform)"},
    {"id": 33, "title": "Kotlin Multiplatform"},
    {"id": 34, "title": "Haxe"},
    {"id": 35, "title": "Flutter Desktop"},
    {"id": 36, "title": "React Native Linux"},
    {"id": 37, "title": "React Native Ubuntu"},
    {"id": 38, "title": "Electron (Cross-Platform Desktop Apps)"},
    {"id": 39, "title": "Electron (Cross-Platform Web Apps)"},
    {"id": 40, "title": "React Native macOS"},
    {"id": 41, "title": "React Native Windows"}
  ]
''';
