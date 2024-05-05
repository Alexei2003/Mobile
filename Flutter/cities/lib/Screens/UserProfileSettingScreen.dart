import 'package:flutter/material.dart';

import '../Constan.dart';
import '../RealtimeDataBaseData.dart';

class UserProfileSettingScreen extends StatelessWidget {
  // Контроллеры для полей ввода
  final TextEditingController regionController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController foundedController =
      TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController elevationController = TextEditingController();
  final TextEditingController populationController = TextEditingController();
  final TextEditingController timeZoneController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController areaCodeController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();

  final TextEditingController mainImageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки города',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
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
                      controller: regionController,
                      decoration: InputDecoration(labelText: 'Region'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: districtController,
                      decoration: InputDecoration(labelText: 'District'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: foundedController,
                      decoration: InputDecoration(labelText: 'Founded'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: areaController,
                      decoration: InputDecoration(labelText: 'Area'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: elevationController,
                      decoration: InputDecoration(labelText: 'Elevation'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: populationController,
                      decoration: InputDecoration(labelText: 'Population'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: timeZoneController,
                      decoration: InputDecoration(labelText: 'TimeZone'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: postalCodeController,
                      decoration: InputDecoration(labelText: 'PostalCode'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: areaCodeController,
                      decoration: InputDecoration(labelText: 'AreaCode'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: licensePlateController,
                      decoration: InputDecoration(labelText: 'LicensePlate'),
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
                        user?.region = regionController.text != "" ? regionController.text: user?.region ?? Constant.TEXT_NO_DATA;
                        user?.district = districtController.text != "" ? districtController.text: user?.district ?? Constant.TEXT_NO_DATA;
                        user?.founded = foundedController.text != "" ? foundedController.text: user?.founded ?? Constant.TEXT_NO_DATA;
                        user?.area = areaController.text != "" ? areaController.text: user?.area ?? Constant.TEXT_NO_DATA;
                        user?.elevation = elevationController.text != "" ? elevationController.text: user?.elevation ?? Constant.TEXT_NO_DATA;
                        user?.population = populationController.text != "" ? populationController.text: user?.population ?? Constant.TEXT_NO_DATA;
                        user?.timeZone = timeZoneController.text != "" ? timeZoneController.text: user?.timeZone ?? Constant.TEXT_NO_DATA;
                        user?.postalCode = postalCodeController.text != "" ? timeZoneController.text: user?.postalCode ?? Constant.TEXT_NO_DATA;
                        user?.areaCode = areaCodeController.text != "" ? areaCodeController.text: user?.areaCode ?? Constant.TEXT_NO_DATA;
                        user?.licensePlate = licensePlateController.text != "" ? licensePlateController.text: user?.licensePlate ?? Constant.TEXT_NO_DATA;
                        user?.mainImage = mainImageController.text != "" ? mainImageController.text: user?.mainImage ?? Constant.TEXT_NO_DATA;

                        RealtimeDataBaseData.uploadActualUserToFirebase(user!);

                        Navigator.pop(context);
                      },
                      child: Text('Сохранить ',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
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
