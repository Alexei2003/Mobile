package com.example.cities.activity

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
import com.example.cities.ConstantsCustom
import com.example.cities.ControllsFunc
import com.example.cities.User
import com.example.cities.ui.theme.CitiesTheme
import com.google.firebase.auth.FirebaseAuth
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import kotlinx.coroutines.withContext

class

SignActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CitiesTheme {
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
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                            ),
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
                        Text(text = "Регистрация", fontSize = 24.sp, color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        Text(text = "Имя", color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        TextField(
                            value = name.value,
                            onValueChange = { newValue -> name.value = newValue },
                            label = { Text("Введите текст") }
                        )

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

                        if (errorAuth.value) {
                            Text("Ошибка", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                        }

                        Button(
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                            ),
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

                                        user.Region = ConstantsCustom.TEXT_NO_DATA
                                        user.District = ConstantsCustom.TEXT_NO_DATA
                                        user.Founded = ConstantsCustom.TEXT_NO_DATA
                                        user.Area = ConstantsCustom.TEXT_NO_DATA
                                        user.Elevation = ConstantsCustom.TEXT_NO_DATA
                                        user.Population = ConstantsCustom.TEXT_NO_DATA
                                        user.TimeZone = ConstantsCustom.TEXT_NO_DATA
                                        user.PostalCode = ConstantsCustom.TEXT_NO_DATA
                                        user.AreaCode = ConstantsCustom.TEXT_NO_DATA
                                        user.LicensePlate = ConstantsCustom.TEXT_NO_DATA

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