package com.example.overwatch.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.overwatch.ConstantsCustom
import com.example.overwatch.ControllsFunc
import com.example.overwatch.RealtimeDataBaseData
import com.example.overwatch.ui.theme.OverwatchTheme
import com.google.firebase.auth.FirebaseAuth

class UserProfileActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            OverwatchTheme {
                val scrollVState = rememberScrollState()
                val scrollHState = rememberScrollState()
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                            .verticalScroll(scrollVState),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Column(
                            modifier = Modifier.fillMaxSize(),
                            verticalArrangement = Arrangement.Top,
                            horizontalAlignment = Alignment.Start
                        ) {
                            Button(
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                    contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                                ),
                                onClick = {
                                    ControllsFunc.GetUserDataAndNavigateActivity(
                                        this@UserProfileActivity,
                                        ObjectListActivity::class.java
                                    )
                                }
                            ) {
                                Text(ConstantsCustom.TEXT_BUTTON_BACK)
                            }
                        }

                        Text("Профиль пользователя", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        Row(
                            modifier = Modifier,
                            horizontalArrangement = Arrangement.Center,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            ControllsFunc.LoadImageFromUrl(
                                imageUrl = RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.MainImage
                                    ?: ConstantsCustom.URL_NO_MAIN_IMAGE,
                                     modifier = Modifier
                                         .width(100.dp)
                                         .height(100.dp)
                            )

                            Spacer(modifier = Modifier.weight(0.5f))

                            Text(
                                text = RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Name
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )

                            Spacer(modifier = Modifier.weight(0.5f))

                            if (RealtimeDataBaseData.selectedUserId != RealtimeDataBaseData.actualUserId) {
                                ControllsFunc.LoadImageFromUrl(
                                    imageUrl = if (RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]!!.Favourite.containsKey(
                                            RealtimeDataBaseData.selectedUserId
                                        )
                                    ) ConstantsCustom.URL_FAVOURITE else ConstantsCustom.URL_NO_FAVOURITE,
                                    uid = RealtimeDataBaseData.selectedUserId,
                                )
                            }
                        }

                        Spacer(modifier = Modifier.height(10.dp))

                        Row(
                            modifier = Modifier
                                .fillMaxSize()
                                .horizontalScroll(scrollHState),
                        ){

                            for (imageUrl in RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]!!.Images) {
                                ControllsFunc.LoadImageFromUrl(
                                    imageUrl = imageUrl,
                                    modifier = Modifier
                                        .width(200.dp)
                                        .height(200.dp)
                                )
                            }
                        }

                        Column(
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.Start
                        ) {
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Role", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Role
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("HP", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.HP
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Armor", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Armor
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Difficult", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Difficult
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Age", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Age
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Nationality", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Nationality
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Occupation", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Occupation
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Operational Base", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.OperationalBase
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Relationships", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Relationships
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text("Affiliation", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Affiliation
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                        }

                        if (RealtimeDataBaseData.selectedUserId == RealtimeDataBaseData.actualUserId) {
                            Button(
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                    contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                                ),
                                onClick = {
                                    startActivity(
                                        Intent(
                                            this@UserProfileActivity,
                                            UserSettingsActivity::class.java
                                        )
                                    )
                                }
                            ) {
                                Text("Изменить даные пользователя")
                            }

                            Button(
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                    contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                                ),
                                onClick = {
                                    // Получение объекта FirebaseAuth
                                    val auth = FirebaseAuth.getInstance()

                                    // Выход из аккаунта
                                    auth.signOut()

                                    startActivity(
                                        Intent(
                                            this@UserProfileActivity,
                                            MainActivity::class.java
                                        )
                                    )
                                }
                            ) {
                                Text("Выйти из аккаунта")
                            }
                        }
                    }
                }
            }
        }
    }

    override fun onBackPressed() {
        ControllsFunc.GetUserDataAndNavigateActivity(
            this@UserProfileActivity,
            ObjectListActivity::class.java
        )
        return
        super.onBackPressed()
    }
}