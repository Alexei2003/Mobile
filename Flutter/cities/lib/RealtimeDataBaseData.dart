import 'dart:collection';
import 'package:cities/Constan.dart';
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
  String? region;
  String? district;
  String? founded;
  String? area;
  String? elevation;
  String? population;
  String? timeZone;
  String? postalCode;
  String? areaCode;
  String? licensePlate;

  String? name;
  String? mainImage;
  Map<String, String?>? favourite;
  List<String?>? images;

  UserProfile({
    this.region,
    this.district,
    this.founded,
    this.area,
    this.elevation,
    this.population,
    this.timeZone,
    this.postalCode,
    this.areaCode,
    this.licensePlate,
    this.name,
    this.mainImage,
    this.favourite,
    this.images,
  });

  factory UserProfile.fromJson(Map<Object?, Object?> json) {
    return UserProfile(
      region: json['Region'] as String?,
      district: json['District'] as String?,
      founded: json['Founded'] as String?,
      area: json['Area'] as String?,
      elevation: json['Elevation'] as String?,
      population: json['Population'] as String?,
      timeZone: json['TimeZone'] as String?,
      postalCode: json['PostalCode'] as String?,
      areaCode: json['AreaCode'] as String?,
      licensePlate: json['LicensePlate'] as String?,
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
      'Region': region,
      'District': district,
      'Founded': founded,
      'Area': area,
      'Elevation': elevation,
      'Population': population,
      'TimeZone': timeZone,
      'PostalCode': postalCode,
      'AreaCode': areaCode,
      'LicensePlate': licensePlate,
      'Name': name,
      'MainImage': mainImage,
      'Favourite': favourite,
      'Images': images,
    };
  }
}
