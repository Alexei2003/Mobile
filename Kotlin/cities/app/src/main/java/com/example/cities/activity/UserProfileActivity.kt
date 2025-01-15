package com.example.cities.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
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
import com.example.cities.ConstantsCustom
import com.example.cities.ControllsFunc
import com.example.cities.RealtimeDataBaseData
import com.example.cities.ui.theme.CitiesTheme
import com.google.firebase.auth.FirebaseAuth

class UserProfileActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CitiesTheme {
                val scrollState = rememberScrollState()

                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                            .verticalScroll(scrollState),
                        verticalArrangement = Arrangement.Top,
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

                        Text("Профиль города", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        Row(
                            modifier = Modifier,
                            horizontalArrangement = Arrangement.Center,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            ControllsFunc.LoadImageFromUrl(
                                imageUrl = RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.MainImage
                                    ?: ConstantsCustom.URL_NO_MAIN_IMAGE,
                                     modifier = Modifier.width(100.dp).height(100.dp)
                            )

                            Spacer(modifier = Modifier.weight(0.5f))

                            Text(
                                text = RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Name
                                    ?: ConstantsCustom.TEXT_NO_DATA,
                                color = ConstantsCustom.CONTROLL_TEXT_COLOR
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

                        Column(
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.Start
                        ) {

                            Text("Region", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Region
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("District", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.District
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("Founded", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Founded
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("Area", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Area
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("Elevation", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Elevation
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("Population", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Population
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("TimeZone", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.TimeZone
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("PostalCode", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.PostalCode
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("AreaCode", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.AreaCode
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                            Text("LicensePlate", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.LicensePlate
                                    ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR
                            )
                        }

                        for (imageUrl in RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]!!.Images){
                            ControllsFunc.LoadImageFromUrl(
                                imageUrl = imageUrl,
                                modifier = Modifier.width(200.dp).height(200.dp)
                            )
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
                                Text("Изменить даные города")
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