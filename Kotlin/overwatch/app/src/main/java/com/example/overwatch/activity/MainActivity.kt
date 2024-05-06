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
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.sp
import com.example.overwatch.ConstantsCustom
import com.example.overwatch.ui.theme.OverwatchTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            OverwatchTheme {
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
                                containerColor = ConstantsCustom.CONTROLL_COLOR,
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR
                            ),
                            onClick = {
                                startActivity(Intent(this@MainActivity, LogActivity::class.java))
                            }
                        ) {
                            Text("Вход ")
                        }

                        Button(
                            colors = ButtonDefaults.buttonColors(
                                containerColor = ConstantsCustom.CONTROLL_COLOR,
                                contentColor = ConstantsCustom.CONTROLL_TEXT_COLOR
                            ),
                            onClick = {//
                                startActivity(Intent(this@MainActivity, SignActivity::class.java))
                            }
                        ) {
                            Text("Регистрация")
                        }
                    }
                }
            }
        }
    }
}