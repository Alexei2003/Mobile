import 'package:battlecat_2/Constan.dart';
import 'package:battlecat_2/Screens/Main.dart';
import 'package:battlecat_2/Screens/UserProfileSettingScreen.dart';
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
          title: Text('Профиль пользователя'),
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
                            if(user!.favourite==null){
                              user!.favourite = new Map<String, String?>();
                              user.favourite?[RealtimeDataBaseData.selectedUserId] =
                                  Constant.TEXT_NO_DATA;
                            }
                            else{
                              if (user!.favourite!.containsKey(RealtimeDataBaseData.selectedUserId)) {
                                user.favourite?.remove(RealtimeDataBaseData.selectedUserId);
                              } else {
                                user.favourite?[RealtimeDataBaseData.selectedUserId] =
                                    Constant.TEXT_NO_DATA;
                              }
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
                              Text("Ability"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.ability ??
                                  Constant.TEXT_NO_DATA),
                              Text("Attack frequency"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.attackFrequency ??
                                  Constant.TEXT_NO_DATA),
                              Text("Attack power"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.attackPower ??
                                  Constant.TEXT_NO_DATA),
                              Text("Attack range"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.attackRange ??
                                  Constant.TEXT_NO_DATA),
                              Text("Health"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.health ??
                                  Constant.TEXT_NO_DATA),
                              Text("Movement Speed"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.movementSpeed ??
                                  Constant.TEXT_NO_DATA),
                              Text("Rarety"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.rarety ??
                                  Constant.TEXT_NO_DATA),
                              Text("Trait"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.trait ??
                                  Constant.TEXT_NO_DATA),                         
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
                    child: Text('Настройка профиля пользователя'),
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
                    child: Text('Выход'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
