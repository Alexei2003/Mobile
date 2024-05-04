package com.example.overwatch.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
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

class ObjectListActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            OverwatchTheme {
                val scrollState = rememberScrollState()

                Surface(
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column (
                        verticalArrangement = Arrangement.Top,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ){
                        Text(text = "Список персонажей", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                        Button(
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                            ),
                            onClick = {
                                RealtimeDataBaseData.selectedUserId = RealtimeDataBaseData.actualUserId
                                startActivity(Intent(this@ObjectListActivity,UserProfileActivity::class.java))
                            }
                        ) {
                            Text("Профиль пользователя")
                        }
                        Row(
                            modifier = Modifier
                                .horizontalScroll(scrollState),
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.SpaceEvenly,
                        ) {
                            for (user in RealtimeDataBaseData.Users) {
                                if (user.key != RealtimeDataBaseData.actualUserId) {
                                    Column(
                                        modifier = Modifier
                                            .clickable {
                                                RealtimeDataBaseData.selectedUserId = user.key
                                                startActivity(
                                                    Intent(
                                                        this@ObjectListActivity,
                                                        UserProfileActivity::class.java
                                                    )
                                                )
                                            },
                                        horizontalAlignment = Alignment.CenterHorizontally,
                                        verticalArrangement = Arrangement.Center
                                    ) {
                                        Spacer(modifier = Modifier.weight(0.3f))

                                        Text(text = user.value.Name ?: ConstantsCustom.TEXT_NO_DATA, color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                                        Spacer(modifier = Modifier.weight(0.1f))

                                        ControllsFunc.LoadImageFromUrl(
                                            imageUrl = user.value.MainImage
                                                ?: ConstantsCustom.URL_NO_MAIN_IMAGE,
                                            modifier = Modifier
                                                .width(400.dp)
                                                .height(400.dp)
                                        )

                                        Spacer(modifier = Modifier.weight(0.1f))

                                        ControllsFunc.LoadImageFromUrl(
                                            imageUrl = if (RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Favourite != null && RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]!!.Favourite.containsKey(
                                                    user.key
                                                )
                                            ) ConstantsCustom.URL_FAVOURITE else ConstantsCustom.URL_NO_FAVOURITE,
                                            uid = user.key,
                                            modifier = Modifier
                                                .width(100.dp)
                                                .height(100.dp)
                                        )

                                        Spacer(modifier = Modifier.weight(0.3f))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override fun onBackPressed() {

        return
        super.onBackPressed()
    }
}