package com.example.overwatch.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
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
import androidx.compose.ui.unit.sp
import com.example.overwatch.ConstantsCustom
import com.example.overwatch.ControllsFunc
import com.example.overwatch.ui.theme.OverwatchTheme
import com.google.firebase.auth.FirebaseAuth
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import kotlinx.coroutines.withContext

class LogActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            OverwatchTheme {
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
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR,
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR
                            ),
                            onClick = {
                                startActivity(Intent(this@LogActivity, MainActivity::class.java))
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
                        Text(text = "Вход",fontSize = 24.sp, color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        Text(text = "Почта", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        TextField(
                            value = email.value,
                            onValueChange = { newValue -> email.value = newValue },
                            label = { Text("Введите текст") }
                        )

                        Text(text = "Пароль", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        TextField(
                            value = password.value,
                            onValueChange = { newValue -> password.value = newValue },
                            label = { Text("Введите текст") }
                        )

                        if(errorAuth.value){
                            Text("Ошибка", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                        }

                        Button(
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                            ),
                            onClick = {
                                GlobalScope.launch {
                                    val success = signInUserWithEmailAndPassword(email.value, password.value)
                                    if (success) {
                                        ControllsFunc.GetUserDataAndNavigateActivity(this@LogActivity,ObjectListActivity::class.java)
                                    } else {
                                        errorAuth.value = true
                                    }
                                }
                            }
                        ) {
                            Text("Войти")
                        }
                    }
                }
            }
        }
    }

    suspend fun signInUserWithEmailAndPassword(email: String, password: String): Boolean {
        return try {
            val authResult = withContext(Dispatchers.IO) {
                FirebaseAuth.getInstance().signInWithEmailAndPassword(email, password).await()
            }
            authResult.user != null
        } catch (e: Exception) {
            false
        }
    }

    override fun onBackPressed() {
        startActivity(Intent(this@LogActivity, MainActivity::class.java))
        return
        super.onBackPressed()
    }
}