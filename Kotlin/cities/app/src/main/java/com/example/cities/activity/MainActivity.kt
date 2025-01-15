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
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.sp
import com.example.cities.ConstantsCustom
import com.example.cities.ui.theme.CitiesTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CitiesTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier.fillMaxSize(),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Text(text = "Авторизация",fontSize = 24.sp, color = ConstantsCustom.CONTROLL_TEXT_COLOR)

                        Button(
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                            ),
                            onClick = {
                                startActivity(Intent(this@MainActivity, LogActivity::class.java))
                            }
                        ) {
                            Text("Вход ", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                        }

                        Button(
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR, // Прозрачный фон кнопки
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR // Цвет текста кнопки
                            ),
                            onClick = {
                                startActivity(Intent(this@MainActivity, SignActivity::class.java))
                            }
                        ) {
                            Text("Регистрация", color = ConstantsCustom.CONTROLL_TEXT_COLOR)
                        }
                    }
                }
            }
        }
    }
}