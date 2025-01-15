import 'package:flutter/material.dart';

import '../Constan.dart';
import '../RealtimeDataBaseData.dart';

class UserProfileSettingScreen extends StatelessWidget {
  // Контроллеры для полей ввода
  final TextEditingController roleController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController armorController =
      TextEditingController();
  final TextEditingController difficultController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController operationalBaseController = TextEditingController();
  final TextEditingController relationshipsController = TextEditingController();
  final TextEditingController affiliationController = TextEditingController();

  final TextEditingController mainImageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки профиля',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Имя'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: roleController,
                      decoration: InputDecoration(labelText: 'Role'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: hpController,
                      decoration: InputDecoration(labelText: 'HP'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: armorController,
                      decoration: InputDecoration(labelText: 'Armor'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: difficultController,
                      decoration: InputDecoration(labelText: 'Difficult'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: ageController,
                      decoration: InputDecoration(labelText: 'Age'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: nationalityController,
                      decoration: InputDecoration(labelText: 'Nationality'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: occupationController,
                      decoration: InputDecoration(labelText: 'Occupation'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: operationalBaseController,
                      decoration: InputDecoration(labelText: 'OperationalBase'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: relationshipsController,
                      decoration: InputDecoration(labelText: 'Relationships'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: affiliationController,
                      decoration: InputDecoration(labelText: 'Affiliation'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: mainImageController,
                      decoration: InputDecoration(labelText: 'Аватарка'),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
                      onPressed: () {
                        RealtimeDataBaseData.selectedUserId =
                            RealtimeDataBaseData.actualUserId;

                        var user = RealtimeDataBaseData
                            .users[RealtimeDataBaseData.actualUserId];

                        user?.name = nameController.text != ""? nameController.text: user?.name ?? Constant.TEXT_NO_DATA;
                        user?.role = roleController.text != "" ? roleController.text: user?.role ?? Constant.TEXT_NO_DATA;
                        user?.hp = hpController.text != "" ? hpController.text: user?.hp ?? Constant.TEXT_NO_DATA;
                        user?.armor = armorController.text != "" ? armorController.text: user?.armor ?? Constant.TEXT_NO_DATA;
                        user?.difficult = difficultController.text != "" ? difficultController.text: user?.difficult ?? Constant.TEXT_NO_DATA;
                        user?.age = ageController.text != "" ? ageController.text: user?.age ?? Constant.TEXT_NO_DATA;
                        user?.nationality = nationalityController.text != "" ? nationalityController.text: user?.nationality ?? Constant.TEXT_NO_DATA;
                        user?.occupation = occupationController.text != "" ? occupationController.text: user?.occupation ?? Constant.TEXT_NO_DATA;
                        user?.operationalBase = operationalBaseController.text != "" ? occupationController.text: user?.operationalBase ?? Constant.TEXT_NO_DATA;
                        user?.relationships = relationshipsController.text != "" ? relationshipsController.text: user?.relationships ?? Constant.TEXT_NO_DATA;
                        user?.affiliation = affiliationController.text != "" ? affiliationController.text: user?.affiliation ?? Constant.TEXT_NO_DATA;
                        user?.mainImage = mainImageController.text != "" ? mainImageController.text: user?.mainImage ?? Constant.TEXT_NO_DATA;

                        RealtimeDataBaseData.uploadActualUserToFirebase(user!);

                        Navigator.pop(context);
                      },
                      child: Text('Сохранить',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
