import 'package:flutter/material.dart';

import '../Constan.dart';
import '../RealtimeDataBaseData.dart';

class UserProfileSettingScreen extends StatelessWidget {
  // Контроллеры для полей ввода
  final TextEditingController constructionController = TextEditingController();
  final TextEditingController rarityController = TextEditingController();
  final TextEditingController classificationController =
      TextEditingController();
  final TextEditingController factionController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController voiceActorController = TextEditingController();
  final TextEditingController illustratorController = TextEditingController();
  final TextEditingController limitBreak1Controller = TextEditingController();
  final TextEditingController limitBreak2Controller = TextEditingController();
  final TextEditingController limitBreak3Controller = TextEditingController();

  final TextEditingController mainImageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки профиля'),
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
                      controller: constructionController,
                      decoration: InputDecoration(labelText: 'Construction'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: rarityController,
                      decoration: InputDecoration(labelText: 'Rarity'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: classificationController,
                      decoration: InputDecoration(labelText: 'Classification'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: factionController,
                      decoration: InputDecoration(labelText: 'Faction'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: classController,
                      decoration: InputDecoration(labelText: 'Class'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: voiceActorController,
                      decoration: InputDecoration(labelText: 'VoiceActor'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: illustratorController,
                      decoration: InputDecoration(labelText: 'Illustrator'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: limitBreak1Controller,
                      decoration: InputDecoration(labelText: 'LimitBreak1'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: limitBreak2Controller,
                      decoration: InputDecoration(labelText: 'LimitBreak2'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: limitBreak3Controller,
                      decoration: InputDecoration(labelText: 'LimitBreak3'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: mainImageController,
                      decoration: InputDecoration(labelText: 'Аватарка'),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        RealtimeDataBaseData.selectedUserId =
                            RealtimeDataBaseData.actualUserId;

                        var user = RealtimeDataBaseData
                            .users[RealtimeDataBaseData.actualUserId];

                        user?.name = nameController.text != ""? nameController.text: user?.name ?? Constant.TEXT_NO_DATA;
                        user?.construction = constructionController.text != "" ? constructionController.text: user?.construction ?? Constant.TEXT_NO_DATA;
                        user?.rarity = rarityController.text != "" ? rarityController.text: user?.rarity ?? Constant.TEXT_NO_DATA;
                        user?.classification = classificationController.text != "" ? classificationController.text: user?.classification ?? Constant.TEXT_NO_DATA;
                        user?.faction = factionController.text != "" ? factionController.text: user?.faction ?? Constant.TEXT_NO_DATA;
                        user?.classField = classController.text != "" ? classController.text: user?.classField ?? Constant.TEXT_NO_DATA;
                        user?.voiceActor = voiceActorController.text != "" ? voiceActorController.text: user?.voiceActor ?? Constant.TEXT_NO_DATA;
                        user?.illustrator = illustratorController.text != "" ? illustratorController.text: user?.illustrator ?? Constant.TEXT_NO_DATA;
                        user?.limitBreak1 = limitBreak1Controller.text != "" ? illustratorController.text: user?.limitBreak1 ?? Constant.TEXT_NO_DATA;
                        user?.limitBreak2 = limitBreak2Controller.text != "" ? limitBreak2Controller.text: user?.limitBreak2 ?? Constant.TEXT_NO_DATA;
                        user?.limitBreak3 = limitBreak3Controller.text != "" ? limitBreak3Controller.text: user?.limitBreak3 ?? Constant.TEXT_NO_DATA;
                        user?.mainImage = mainImageController.text != "" ? mainImageController.text: user?.mainImage ?? Constant.TEXT_NO_DATA;

                        RealtimeDataBaseData.uploadActualUserToFirebase(user!);

                        Navigator.pop(context);
                      },
                      child: Text('Сохранить '),
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
