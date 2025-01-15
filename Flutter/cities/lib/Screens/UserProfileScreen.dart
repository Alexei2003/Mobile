import 'package:cities/Constan.dart';
import 'package:cities/Screens/Main.dart';
import 'package:cities/Screens/UserProfileSettingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../RealtimeDataBaseData.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RealtimeDataBaseData.readDataFromFirebase();
        return true; // или false
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Профиль города',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.mainImage ==
                              Constant.TEXT_NO_DATA
                          ? Constant.URL_NO_MAIN_IMAGE
                          : RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.mainImage ??
                              Constant.URL_NO_MAIN_IMAGE,
                      width: 100,
                      height: 100,
                    ),
                    Text(RealtimeDataBaseData
                            .users[RealtimeDataBaseData.selectedUserId]?.name ??
                        Constant.TEXT_NO_DATA),
                    if (RealtimeDataBaseData.actualUserId !=
                        RealtimeDataBaseData.selectedUserId)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            var user = RealtimeDataBaseData
                                .users[RealtimeDataBaseData.actualUserId];
                            if (user!.favourite!.containsKey(
                                RealtimeDataBaseData.selectedUserId)) {
                              user.favourite
                                  ?.remove(RealtimeDataBaseData.selectedUserId);
                            } else {
                              user.favourite?[RealtimeDataBaseData
                                  .selectedUserId] = Constant.TEXT_NO_DATA;
                            }
                            RealtimeDataBaseData.uploadActualUserToFirebase(
                                user);
                            RealtimeDataBaseData.readDataFromFirebase();
                          });
                        },
                        child: Image.network(
                          (RealtimeDataBaseData.users[RealtimeDataBaseData.actualUserId]?.favourite)?.containsKey(RealtimeDataBaseData.selectedUserId) ?? false
                              ? Constant.URL_FAVOURITE
                              : Constant.URL_NO_FAVOURITE,
                          width: 100,
                          height: 100,
                        ),
                      )
                    else
                      Spacer()
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: (RealtimeDataBaseData.users[RealtimeDataBaseData.selectedUserId]?.images?.length ?? 0) + 1,
                      itemBuilder: (context, index) {
                        if(index == 0){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(),
                              Text("Region",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.region ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("District",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.district ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("Founded",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.founded ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("Area",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.area ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("Elevation",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.elevation ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("Population",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.population ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("TimeZone",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.timeZone ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("PostalCode",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.postalCode ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("AreaCode",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.areaCode ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text("LicensePlate",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.licensePlate ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                            ],
                          );
                        }else{
                          return Image.network(
                            RealtimeDataBaseData
                                .users[
                            RealtimeDataBaseData.selectedUserId]
                                ?.images?[index-1] ==
                                Constant.TEXT_NO_DATA
                                ? Constant.URL_NO_MAIN_IMAGE
                                : RealtimeDataBaseData
                                .users[
                            RealtimeDataBaseData.selectedUserId]
                                ?.images?[index-1] ??
                                Constant.URL_NO_MAIN_IMAGE,
                            width: 250,
                            height: 250,
                          );
                        }
                      }),
                ),
                if (RealtimeDataBaseData.actualUserId ==
                    RealtimeDataBaseData.selectedUserId)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileSettingScreen()),
                      );
                    },
                    child: Text('Настройка профиля города',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                  ),
                if (RealtimeDataBaseData.actualUserId ==
                    RealtimeDataBaseData.selectedUserId)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Выход',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
