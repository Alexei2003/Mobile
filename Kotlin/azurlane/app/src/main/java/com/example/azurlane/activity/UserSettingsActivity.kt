package com.example.azurlane.activity

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
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import com.example.azurlane.ConstantsCustom
import com.example.azurlane.ControllsFunc
import com.example.azurlane.RealtimeDataBaseData
import com.example.azurlane.ui.theme.AzurLaneTheme

class UserSettingsActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AzurLaneTheme {
                val scrollState = rememberScrollState()
                val Name = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Name ?: ConstantsCustom.TEXT_NO_DATA)}
                val Construction = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Construction ?: ConstantsCustom.TEXT_NO_DATA)}
                val Rarity = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Rarity ?: ConstantsCustom.TEXT_NO_DATA)}
                val Classification = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Classification ?: ConstantsCustom.TEXT_NO_DATA)}
                val Faction = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Faction ?: ConstantsCustom.TEXT_NO_DATA)}
                val Class = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Class ?: ConstantsCustom.TEXT_NO_DATA)}
                val VoiceActor = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.VoiceActor ?: ConstantsCustom.TEXT_NO_DATA)}
                val Illustrator = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Illustrator ?: ConstantsCustom.TEXT_NO_DATA)}
                val LimitBreak1 = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.LimitBreak1 ?: ConstantsCustom.TEXT_NO_DATA)}
                val LimitBreak2 = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.LimitBreak2 ?: ConstantsCustom.TEXT_NO_DATA)}
                val LimitBreak3 = remember { mutableStateOf( RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.LimitBreak3 ?: ConstantsCustom.TEXT_NO_DATA)}
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

                        Text(text = "Настройки профиля")

                        Column(
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.Start
                        ) {
                            Text("Имя")
                            TextField(
                                value = Name.value,
                                onValueChange = { newValue -> Name.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Construction")
                            TextField(
                                value = Construction.value,
                                onValueChange = { newValue -> Construction.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Rarity")
                            TextField(
                                value = Rarity.value,
                                onValueChange = { newValue -> Rarity.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Classification")
                            TextField(
                                value = Classification.value,
                                onValueChange = { newValue -> Classification.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Faction")
                            TextField(
                                value = Faction.value,
                                onValueChange = { newValue -> Faction.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Class")
                            TextField(
                                value =Class.value,
                                onValueChange = { newValue -> Class.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Voice Actor")
                            TextField(
                                value =VoiceActor.value,
                                onValueChange = { newValue -> VoiceActor.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Illustrator")
                            TextField(
                                value =Illustrator.value,
                                onValueChange = { newValue -> Illustrator.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("LimitBreak1")
                            TextField(
                                value =LimitBreak1.value,
                                onValueChange = { newValue -> LimitBreak1.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("LimitBreak2")
                            TextField(
                                value = LimitBreak2.value,
                                onValueChange = { newValue -> LimitBreak2.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("LimitBreak3")
                            TextField(
                                value = LimitBreak3.value,
                                onValueChange = { newValue ->LimitBreak3.value = newValue },
                                label = { Text("Введите текст") }
                            )

                            Text("Аватарка")
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
                                onClick = {
                                    var user = RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]
                                    user!!.Name = Name.value;
                                    user!!.Construction = Construction.value;
                                    user!!.Rarity = Rarity.value;
                                    user!!.Classification = Classification.value;
                                    user!!.Faction = Faction.value;
                                    user!!.Class = Class.value;
                                    user!!.VoiceActor = VoiceActor.value;
                                    user!!.Illustrator = Illustrator.value;
                                    user!!.LimitBreak1 = LimitBreak1.value;
                                    user!!.LimitBreak2 = LimitBreak2.value;
                                    user!!.LimitBreak3 = LimitBreak3.value;
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