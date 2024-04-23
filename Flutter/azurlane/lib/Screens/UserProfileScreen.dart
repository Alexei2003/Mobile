import 'package:azurlane/Constan.dart';
import 'package:azurlane/Screens/Main.dart';
import 'package:azurlane/Screens/UserProfileSettingScreen.dart';
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
                              Text("Construction"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.construction ??
                                  Constant.TEXT_NO_DATA),
                              Text("Rarity"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.rarity ??
                                  Constant.TEXT_NO_DATA),
                              Text("Classification"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.classification ??
                                  Constant.TEXT_NO_DATA),
                              Text("Faction"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.faction ??
                                  Constant.TEXT_NO_DATA),
                              Text("Class"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.classField ??
                                  Constant.TEXT_NO_DATA),
                              Text("VoiceActor"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.voiceActor ??
                                  Constant.TEXT_NO_DATA),
                              Text("Illustrator"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.illustrator ??
                                  Constant.TEXT_NO_DATA),
                              Text("LimitBreak1"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.limitBreak1 ??
                                  Constant.TEXT_NO_DATA),
                              Text("LimitBreak2"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.limitBreak2 ??
                                  Constant.TEXT_NO_DATA),
                              Text("LimitBreak3"),
                              Text(RealtimeDataBaseData
                                  .users[RealtimeDataBaseData.selectedUserId]
                                  ?.limitBreak3 ??
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
