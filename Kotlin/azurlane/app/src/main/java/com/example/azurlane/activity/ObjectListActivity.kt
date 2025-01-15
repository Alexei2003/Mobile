package com.example.azurlane.activity

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.azurlane.ConstantsCustom
import com.example.azurlane.ControllsFunc
import com.example.azurlane.RealtimeDataBaseData
import com.example.azurlane.ui.theme.AzurLaneTheme
import com.google.firebase.Firebase
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.ValueEventListener
import com.google.firebase.database.database

class ObjectListActivity : ComponentActivity() {
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
                        verticalArrangement = Arrangement.SpaceEvenly,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Text(text = "Список персонажей")

                        for (user in RealtimeDataBaseData.Users) {
                            if (user.key != RealtimeDataBaseData.actualUserId) {
                                Row(
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
                                    horizontalArrangement = Arrangement.Center,
                                    verticalAlignment = Alignment.CenterVertically
                                ) {

                                    ControllsFunc.LoadImageFromUrl(
                                        imageUrl = user.value.MainImage
                                            ?: ConstantsCustom.URL_NO_MAIN_IMAGE
                                    )

                                    Spacer(modifier = Modifier.weight(0.5f))

                                    Text(text = user.value.Name ?: ConstantsCustom.TEXT_NO_DATA)

                                    Spacer(modifier = Modifier.weight(0.5f))

                                    ControllsFunc.LoadImageFromUrl(
                                        imageUrl = if (RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]?.Favourite != null && RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]!!.Favourite.containsKey(
                                                user.key
                                            )
                                        ) ConstantsCustom.URL_FAVOURITE else ConstantsCustom.URL_NO_FAVOURITE,
                                        uid = user.key,
                                    )
                                }
                            }
                        }

                        Button(
                            onClick = {
                                RealtimeDataBaseData.selectedUserId = RealtimeDataBaseData.actualUserId
                                startActivity(Intent(this@ObjectListActivity,UserProfileActivity::class.java))
                            }
                        ) {
                            Text("Профиль пользователя")
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