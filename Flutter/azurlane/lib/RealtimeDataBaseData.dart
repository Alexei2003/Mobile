import 'dart:collection';
import 'package:azurlane/Constan.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDataBaseData {
  static final RealtimeDataBaseData _instance =
      RealtimeDataBaseData._internal();

  factory RealtimeDataBaseData() {
    return _instance;
  }

  RealtimeDataBaseData._internal();

  static HashMap<String, UserProfile> users = HashMap();

  static String actualUserId = '';
  static String selectedUserId = '';

  static void uploadActualUserToFirebase(UserProfile user) {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference
        .child(Constant.USERS)
        .child(actualUserId)
        .set(user.toJson()); // Преобразуйте объект в Map перед сохранением
  }

  static Future<void> readDataFromFirebase() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    // Get the data once
    DatabaseEvent event = await databaseReference.child(Constant.USERS).once();

    var data = event.snapshot.value as Map<Object?, Object?>;

    users.clear();
    data.forEach((key, value) {
      users[key as String] =
          UserProfile.fromJson(value as Map<Object?, Object?>);
    });
  }
}

class UserProfile {
  String? construction;
  String? rarity;
  String? classification;
  String? faction;
  String? classField;
  String? voiceActor;
  String? illustrator;
  String? limitBreak1;
  String? limitBreak2;
  String? limitBreak3;

  String? name;
  String? mainImage;
  Map<String, String?>? favourite;
  List<String?>? images;

  UserProfile({
    this.construction,
    this.rarity,
    this.classification,
    this.faction,
    this.classField,
    this.voiceActor,
    this.illustrator,
    this.limitBreak1,
    this.limitBreak2,
    this.limitBreak3,
    this.name,
    this.mainImage,
    this.favourite,
    this.images,
  });

  factory UserProfile.fromJson(Map<Object?, Object?> json) {
    return UserProfile(
      construction: json['Construction'] as String?,
      rarity: json['Rarity'] as String?,
      classification: json['Classification'] as String?,
      faction: json['Faction'] as String?,
      classField: json['Class'] as String?,
      voiceActor: json['VoiceActor'] as String?,
      illustrator: json['Illustrator'] as String?,
      limitBreak1: json['LimitBreak1'] as String?,
      limitBreak2: json['LimitBreak2'] as String?,
      limitBreak3: json['LimitBreak3'] as String?,
      name: json['Name'] as String?,
      mainImage: json['MainImage'] as String?,
      favourite: (json['Favourite'] as Map<dynamic, dynamic>?)?.map<String, String?>(
            (key, value) => MapEntry(key.toString(), value?.toString()),
      ),

      images: (json['Images'] as List<dynamic>?)?.whereType<String>().toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Construction': construction,
      'Rarity': rarity,
      'Classification': classification,
      'Faction': faction,
      'Class': classField,
      'VoiceActor': voiceActor,
      'Illustrator': illustrator,
      'LimitBreak1': limitBreak1,
      'LimitBreak2': limitBreak2,
      'LimitBreak3': limitBreak3,
      'Name': name,
      'MainImage': mainImage,
      'Favourite': favourite,
      'Images': images,
    };
  }
}
