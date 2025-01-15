package com.example.cities.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import com.example.cities.ConstantsCustom
import com.example.cities.ControllsFunc
import com.example.cities.RealtimeDataBaseData
import com.example.cities.ui.theme.CitiesTheme

class UserSettingsActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CitiesTheme {
                val scrollState = rememberScrollState()
                val Name = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Name ?: ConstantsCustom.TEXT_NO_DATA)}
                val Region = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Region ?: ConstantsCustom.TEXT_NO_DATA)}
                val District = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.District ?: ConstantsCustom.TEXT_NO_DATA)}
                val Founded = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Founded ?: ConstantsCustom.TEXT_NO_DATA)}
                val Area = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Area ?: ConstantsCustom.TEXT_NO_DATA)}
                val Elevation = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Elevation ?: ConstantsCustom.TEXT_NO_DATA)}
                val Population = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Population ?: ConstantsCustom.TEXT_NO_DATA)}
                val TimeZone = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.TimeZone ?: ConstantsCustom.TEXT_NO_DATA)}
                val PostalCode = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.PostalCode ?: ConstantsCustom.TEXT_NO_DATA)}
                val AreaCode = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.AreaCode ?: ConstantsCustom.TEXT_NO_DATA)}
                val LicensePlate = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.LicensePlate ?: ConstantsCustom.TEXT_NO_DATA)}
                val MainImage = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.MainImage ?: ConstantsCustom.TEXT_NO_DATA)}

                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                            .verticalScroll(scrollState),
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
                                    startActivity(
                                        Intent(
                                            this@UserSettingsActivity,
                                            UserProfileActivity::class.java
                                        )
                                    )
                                }
                            ) {
                                Text(ConstantsCustom.TEXT_BUTTON_BACK)
                            }
                        }

                        Text(text = "Настройки города", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        Column(
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.Start
                        ) {
                            Text("Имя", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Name.value,
                                onValueChange = { newValue -> Name.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Region", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Region.value,
                                onValueChange = { newValue -> Region.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("District", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = District.value,
                                onValueChange = { newValue -> District.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Founded", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Founded.value,
                                onValueChange = { newValue -> Founded.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Area", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Area.value,
                                onValueChange = { newValue -> Area.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Elevation", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =Elevation.value,
                                onValueChange = { newValue -> Elevation.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Population", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =Population.value,
                                onValueChange = { newValue -> Population.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("TimeZone", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =TimeZone.value,
                                onValueChange = { newValue -> TimeZone.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("PostalCode", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =PostalCode.value,
                                onValueChange = { newValue -> PostalCode.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("AreaCode", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = AreaCode.value,
                                onValueChange = { newValue -> AreaCode.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("LicensePlate", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = LicensePlate.value,
                                onValueChange = { newValue ->LicensePlate.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Аватарка", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = MainImage.value,
                                onValueChange = { newValue -> MainImage.value = newValue },
                                label = { Text("Введите текст") }
                            )
                        }

                        Column(
                            modifier = Modifier.fillMaxSize(),
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Button(
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                    contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                                ),
                                onClick = {
                                    var user = RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]
                                    user!!.Name = Name.value;
                                    user!!.Region = Region.value;
                                    user!!.District = District.value;
                                    user!!.Founded = Founded.value;
                                    user!!.Area = Area.value;
                                    user!!.Elevation = Elevation.value;
                                    user!!.Population = Population.value;
                                    user!!.TimeZone = TimeZone.value;
                                    user!!.PostalCode = PostalCode.value;
                                    user!!.AreaCode = AreaCode.value;
                                    user!!.LicensePlate = LicensePlate.value;
                                    user!!.MainImage = MainImage.value;

                                    ControllsFunc.PushUserData(user!!);
                                    ControllsFunc.GetUserDataAndNavigateActivity(
                                        this@UserSettingsActivity,
                                        UserProfileActivity::class.java
                                    )
                                }
                            ) {
                                Text("Сохранить")
                            }
                        }
                    }
                }
            }
        }
    }

    override fun onBackPressed() {
        startActivity(Intent(this@UserSettingsActivity,UserProfileActivity::class.java))
        return
        super.onBackPressed()
    }
}