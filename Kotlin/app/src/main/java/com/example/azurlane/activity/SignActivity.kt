package com.example.azurlane.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.sp
import com.example.azurlane.ConstantsCustom
import com.example.azurlane.ControllsFunc
import com.example.azurlane.RealtimeDataBaseData
import com.example.azurlane.User
import com.example.azurlane.ui.theme.AzurLaneTheme
import com.google.firebase.auth.FirebaseAuth
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import kotlinx.coroutines.withContext

class SignActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AzurLaneTheme {
                val name = remember { mutableStateOf("") }
                val email = remember { mutableStateOf("") }
                val password = remember { mutableStateOf("") }

                val errorAuth = remember { mutableStateOf(false) }

                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier.fillMaxSize(),
                        verticalArrangement = Arrangement.Top,
                        horizontalAlignment = Alignment.Start
                    ) {
                        Button(
                            onClick = {
                                startActivity(Intent(this@SignActivity, MainActivity::class.java))
                            }
                        ) {
                            Text(ConstantsCustom.TEXT_BUTTON_BACK)
                        }
                    }

                    Column(
                        modifier = Modifier.fillMaxSize(),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Text(text = "Регистрация", fontSize = 24.sp)

                        Text(text = "Имя")

                        TextField(
                            value = name.value,
                            onValueChange = { newValue -> name.value = newValue },
                            label = { Text("Введите текст") }
                        )

                        Text(text = "Почта")

                        TextField(
                            value = email.value,
                            onValueChange = { newValue -> email.value = newValue },
                            label = { Text("Введите текст") }
                        )

                        Text(text = "Пароль")

                        TextField(
                            value = password.value,
                            onValueChange = { newValue -> password.value = newValue },
                            label = { Text("Введите текст") }
                        )

                        if (errorAuth.value) {
                            Text("Ошибка")
                        }

                        Button(
                            onClick = {
                                // Регистрация нового пользователя
                                GlobalScope.launch {
                                    val success = registerUserWithEmailAndPassword(
                                        email.value,
                                        password.value
                                    )
                                    if (success) {
                                        val auth = FirebaseAuth.getInstance()
                                        val uid = auth.currentUser!!.uid

                                        var user = User()

                                        user.Name = name.value

                                        user.Construction = ConstantsCustom.TEXT_NO_DATA
                                        user.Rarity = ConstantsCustom.TEXT_NO_DATA
                                        user.Classification = ConstantsCustom.TEXT_NO_DATA
                                        user.Faction = ConstantsCustom.TEXT_NO_DATA
                                        user.Class = ConstantsCustom.TEXT_NO_DATA
                                        user.VoiceActor = ConstantsCustom.TEXT_NO_DATA
                                        user.Illustrator = ConstantsCustom.TEXT_NO_DATA
                                        user.LimitBreak1 = ConstantsCustom.TEXT_NO_DATA
                                        user.LimitBreak2 = ConstantsCustom.TEXT_NO_DATA
                                        user.LimitBreak3 = ConstantsCustom.TEXT_NO_DATA

                                        ControllsFunc.PushUserData(user, uid)

                                        ControllsFunc.GetUserDataAndNavigateActivity(
                                            this@SignActivity,
                                            ObjectListActivity::class.java
                                        )
                                    } else {
                                        errorAuth.value = true
                                    }
                                }
                            }
                        ) {
                            Text("Зарегистрироваться")
                        }
                    }
                }
            }
        }
    }

    suspend fun registerUserWithEmailAndPassword(email: String, password: String): Boolean {
        return try {
            val authResult = withContext(Dispatchers.IO) {
                FirebaseAuth.getInstance().createUserWithEmailAndPassword(email, password).await()
            }
            authResult.user != null
        } catch (e: Exception) {
            false
        }
    }

    override fun onBackPressed() {
        startActivity(Intent(this@SignActivity, MainActivity::class.java))
        return
        super.onBackPressed()
    }
}