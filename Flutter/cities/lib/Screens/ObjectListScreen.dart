import 'package:cities/Constan.dart';
import 'package:cities/Screens/UserProfileScreen.dart';
import 'package:flutter/material.dart';

import '../RealtimeDataBaseData.dart';

class ObjectListScreen extends StatefulWidget {
  @override
  _ObjectListScreenState createState() => _ObjectListScreenState();
}

class _ObjectListScreenState extends State<ObjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // или false
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Список городов',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: RealtimeDataBaseData.users.length,
                  itemBuilder: (context, index) {
                    String userId =
                        RealtimeDataBaseData.users.keys.elementAt(index);

                    if (RealtimeDataBaseData.actualUserId == userId) {
                      return const Spacer();
                    }

                    if (userId == null) {
                      return const Spacer();
                    }

                    UserProfile userProfile =
                        RealtimeDataBaseData.users[userId]!;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            RealtimeDataBaseData.selectedUserId = userId;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfileScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                userProfile.mainImage == Constant.TEXT_NO_DATA
                                    ? Constant.URL_NO_MAIN_IMAGE
                                    : userProfile.mainImage ??
                                        Constant.URL_NO_MAIN_IMAGE,
                                width: 50,
                                height: 50,
                              ),
                              Text(userProfile.name ?? Constant.TEXT_NO_DATA,style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    var user = RealtimeDataBaseData.users[
                                        RealtimeDataBaseData.actualUserId];
                                    if (user!.favourite!.containsKey(userId)) {
                                      user.favourite?.remove(userId);
                                    } else {
                                      user.favourite?[userId] =
                                          Constant.TEXT_NO_DATA;
                                    }
                                    RealtimeDataBaseData
                                        .uploadActualUserToFirebase(user);
                                    RealtimeDataBaseData.readDataFromFirebase();
                                  });
                                },
                                child: Image.network(
                                  (RealtimeDataBaseData.users[RealtimeDataBaseData.actualUserId]?.favourite)?.containsKey(userId) ?? false
                                      ? Constant.URL_FAVOURITE
                                      : Constant.URL_NO_FAVOURITE,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
                onPressed: () {
                  RealtimeDataBaseData.selectedUserId =
                      RealtimeDataBaseData.actualUserId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()),
                  );
                },
                child: Text('Профиль пользователя',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
