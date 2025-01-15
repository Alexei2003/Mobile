import 'package:overwatch/Constan.dart';
import 'package:overwatch/Screens/Main.dart';
import 'package:overwatch/Screens/UserProfileSettingScreen.dart';
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
          title: Text('Профиль пользователя',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
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
                        Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR, fontSize: 16)),
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
                    scrollDirection: Axis.horizontal,
                    itemCount: (RealtimeDataBaseData.users[RealtimeDataBaseData.selectedUserId]?.images?.length ?? 0),
                    itemBuilder: (context,index){
                      return Image.network(
                        RealtimeDataBaseData
                            .users[
                        RealtimeDataBaseData.selectedUserId]
                            ?.images?[index] ==
                            Constant.TEXT_NO_DATA
                            ? Constant.URL_NO_MAIN_IMAGE
                            : RealtimeDataBaseData
                            .users[
                        RealtimeDataBaseData.selectedUserId]
                            ?.images?[index] ??
                            Constant.URL_NO_MAIN_IMAGE,
                        width: 250,
                        height: 250,
                      );
                    },
                  )
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:  1,
                      itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(),
                              Text(""),
                              Text("Role",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.role ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("HP",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.hp ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Armor",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.armor ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Difficult",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.difficult ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Age",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.age ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Nationality",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.nationality ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Occupation",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.occupation ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("OperationalBase",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.operationalBase ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Relationships",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.relationships ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                              Text("Affiliation",style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.affiliation ??
                                  Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              Text(""),
                            ],
                          );
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
                    child: Text('Настройка профиля пользователя',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
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
