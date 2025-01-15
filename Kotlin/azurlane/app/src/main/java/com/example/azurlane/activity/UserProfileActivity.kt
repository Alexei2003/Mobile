package com.example.azurlane.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
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
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.azurlane.ConstantsCustom
import com.example.azurlane.ControllsFunc
import com.example.azurlane.RealtimeDataBaseData
import com.example.azurlane.ui.theme.AzurLaneTheme
import com.google.firebase.auth.FirebaseAuth

class UserProfileActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AzurLaneTheme {
                val scrollState = rememberScrollState()

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
                                    ControllsFunc.GetUserDataAndNavigateActivity(
                                        this@UserProfileActivity,
                                        ObjectListActivity::class.java
                                    )
                                }
                            ) {
                                Text(ConstantsCustom.TEXT_BUTTON_BACK)
                            }
                        }

                        Text("Профиль пользователя")

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
                                    ?: ConstantsCustom.TEXT_NO_DATA
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

                            Text("Construction")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Construction
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("Rarity")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Rarity
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("Classification")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Classification
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("Faction")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Faction
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("Class")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Class
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("Voice Actor")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.VoiceActor
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("Illustrator")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.Illustrator
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("LimitBreak1")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.LimitBreak1
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("LimitBreak2")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.LimitBreak2
                                    ?: ConstantsCustom.TEXT_NO_DATA
                            )
                            Text("LimitBreak3")
                            Text(
                                RealtimeDataBaseData.Users[RealtimeDataBaseData.selectedUserId]?.LimitBreak3
                                    ?: ConstantsCustom.TEXT_NO_DATA
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