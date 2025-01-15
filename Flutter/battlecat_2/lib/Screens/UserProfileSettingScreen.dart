import 'package:flutter/material.dart';

import '../Constan.dart';
import '../RealtimeDataBaseData.dart';

class UserProfileSettingScreen extends StatelessWidget {
  // Контроллеры для полей ввода
  final TextEditingController abilityController = TextEditingController();
  final TextEditingController attackFrequencyController = TextEditingController();
  final TextEditingController attackPowerController =
      TextEditingController();
  final TextEditingController attackRangeController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController movementSpeedController = TextEditingController();
  final TextEditingController raretyController = TextEditingController();
  final TextEditingController traitController = TextEditingController();

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
                      controller: abilityController,
                      decoration: InputDecoration(labelText: 'Ability'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: attackFrequencyController,
                      decoration: InputDecoration(labelText: 'Attack frequency'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: attackPowerController,
                      decoration: InputDecoration(labelText: 'Attack power'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: attackRangeController,
                      decoration: InputDecoration(labelText: 'Attack range'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: classController,
                      decoration: InputDecoration(labelText: 'Health'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: movementSpeedController,
                      decoration: InputDecoration(labelText: 'Movement Speed'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: raretyController,
                      decoration: InputDecoration(labelText: 'Rarety'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: traitController,
                      decoration: InputDecoration(labelText: 'Trait'),
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
                        user?.ability = abilityController.text != "" ? abilityController.text: user?.ability ?? Constant.TEXT_NO_DATA;
                        user?.attackFrequency = attackFrequencyController.text != "" ? attackFrequencyController.text: user?.attackFrequency ?? Constant.TEXT_NO_DATA;
                        user?.attackPower = attackPowerController.text != "" ? attackPowerController.text: user?.attackPower ?? Constant.TEXT_NO_DATA;
                        user?.attackRange = attackRangeController.text != "" ? attackRangeController.text: user?.attackRange ?? Constant.TEXT_NO_DATA;
                        user?.health = classController.text != "" ? classController.text: user?.health ?? Constant.TEXT_NO_DATA;
                        user?.movementSpeed = movementSpeedController.text != "" ? movementSpeedController.text: user?.movementSpeed ?? Constant.TEXT_NO_DATA;
                        user?.rarety = raretyController.text != "" ? raretyController.text: user?.rarety ?? Constant.TEXT_NO_DATA;
                        user?.trait = traitController.text != "" ? raretyController.text: user?.trait ?? Constant.TEXT_NO_DATA;
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
