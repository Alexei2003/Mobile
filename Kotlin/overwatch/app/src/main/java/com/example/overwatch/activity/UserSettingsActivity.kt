package com.example.overwatch.activity

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
import com.example.overwatch.ConstantsCustom
import com.example.overwatch.ControllsFunc
import com.example.overwatch.RealtimeDataBaseData
import com.example.overwatch.ui.theme.OverwatchTheme

class UserSettingsActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            OverwatchTheme {
                val scrollState = rememberScrollState()
                val Name = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Name ?: ConstantsCustom.TEXT_NO_DATA)}
                val Role = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Role ?: ConstantsCustom.TEXT_NO_DATA)}
                val HP = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.HP ?: ConstantsCustom.TEXT_NO_DATA)}
                val Armor = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Armor ?: ConstantsCustom.TEXT_NO_DATA)}
                val Difficult = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Difficult ?: ConstantsCustom.TEXT_NO_DATA)}
                val Age = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Age ?: ConstantsCustom.TEXT_NO_DATA)}
                val Nationality = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Nationality ?: ConstantsCustom.TEXT_NO_DATA)}
                val Occupation = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Occupation ?: ConstantsCustom.TEXT_NO_DATA)}
                val OperationalBase = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.OperationalBase ?: ConstantsCustom.TEXT_NO_DATA)}
                val Relationships = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Relationships ?: ConstantsCustom.TEXT_NO_DATA)}
                val Affiliation = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Affiliation ?: ConstantsCustom.TEXT_NO_DATA)}
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

                        Text(text = "Настройки профиля", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

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

                            Text("Role", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Role.value,
                                onValueChange = { newValue -> Role.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("HP", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = HP.value,
                                onValueChange = { newValue -> HP.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Armor", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Armor.value,
                                onValueChange = { newValue -> Armor.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Difficult", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Difficult.value,
                                onValueChange = { newValue -> Difficult.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Age", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =Age.value,
                                onValueChange = { newValue -> Age.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Nationality", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =Nationality.value,
                                onValueChange = { newValue -> Nationality.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Occupation", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =Occupation.value,
                                onValueChange = { newValue -> Occupation.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("OperationalBase", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value =OperationalBase.value,
                                onValueChange = { newValue -> OperationalBase.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Relationships", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Relationships.value,
                                onValueChange = { newValue -> Relationships.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Affiliation", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                            TextField(
                                value = Affiliation.value,
                                onValueChange = { newValue ->Affiliation.value = newValue },
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
                                    user!!.Role = Role.value;
                                    user!!.HP = HP.value;
                                    user!!.Armor = Armor.value;
                                    user!!.Difficult = Difficult.value;
                                    user!!.Age = Age.value;
                                    user!!.Nationality = Nationality.value;
                                    user!!.Occupation = Occupation.value;
                                    user!!.OperationalBase = OperationalBase.value;
                                    user!!.Relationships = Relationships.value;
                                    user!!.Affiliation = Affiliation.value;
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