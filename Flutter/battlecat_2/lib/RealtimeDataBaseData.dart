import 'dart:collection';
import 'package:battlecat_2/Constan.dart';
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
  String? ability;
  String? attackFrequency;
  String? attackPower;
  String? attackRange;
  String? health;
  String? movementSpeed;
  String? rarety;
  String? trait;

  String? name;
  String? mainImage;
  Map<String, String?>? favourite;
  List<String?>? images;

  UserProfile({
    this.ability,
    this.attackFrequency,
    this.attackPower,
    this.attackRange,
    this.health,
    this.movementSpeed,
    this.rarety,
    this.trait,
    this.name,
    this.mainImage,
    this.favourite,
    this.images,
  });

  factory UserProfile.fromJson(Map<Object?, Object?> json) {
    return UserProfile(
      ability: json['Ability'] as String?,
      attackFrequency: json['Attack frequency'] as String?,
      attackPower: json['Attack power'] as String?,
      attackRange: json['Attack range'] as String?,
      health: json['Health'] as String?,
      movementSpeed: json['Movement speed'] as String?,
      rarety: json['Rarety'] as String?,
      trait: json['Trait'] as String?,
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
      'Ability': ability,
      'Attack frequency': attackFrequency,
      'Attack power': attackPower,
      'Attack range': attackRange,
      'Health': health,
      'Movement speed': movementSpeed,
      'Rarety': rarety,
      'Trait': trait,
      'Name': name,
      'MainImage': mainImage,
      'Favourite': favourite,
      'Images': images,
    };
  }
}
