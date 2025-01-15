import 'dart:collection';
import 'package:overwatch/Constan.dart';
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
  String? role;
  String? hp;
  String? armor;
  String? difficult;
  String? age;
  String? nationality;
  String? occupation;
  String? operationalBase;
  String? relationships;
  String? affiliation;

  String? name;
  String? mainImage;
  Map<String, String?>? favourite;
  List<String?>? images;

  UserProfile({
    this.role,
    this.hp,
    this.armor,
    this.difficult,
    this.age,
    this.nationality,
    this.occupation,
    this.operationalBase,
    this.relationships,
    this.affiliation,
    this.name,
    this.mainImage,
    this.favourite,
    this.images,
  });

  factory UserProfile.fromJson(Map<Object?, Object?> json) {
    return UserProfile(
      role: json['Role'] as String?,
      hp: json['HP'] as String?,
      armor: json['Armor'] as String?,
      difficult: json['Difficult'] as String?,
      age: json['Age'] as String?,
      nationality: json['Nationality'] as String?,
      occupation: json['Occupation'] as String?,
      operationalBase: json['OperationalBase'] as String?,
      relationships: json['Relationships'] as String?,
      affiliation: json['Affiliation'] as String?,
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
      'Role': role,
      'HP': hp,
      'Armor': armor,
      'Difficult': difficult,
      'Age': age,
      'Nationality': nationality,
      'Occupation': occupation,
      'OperationalBase': operationalBase,
      'Relationships': relationships,
      'Affiliation': affiliation,
      'Name': name,
      'MainImage': mainImage,
      'Favourite': favourite,
      'Images': images,
    };
  }
}
