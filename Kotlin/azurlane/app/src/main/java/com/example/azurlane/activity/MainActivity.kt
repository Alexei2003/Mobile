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
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.sp
import com.example.azurlane.ui.theme.AzurLaneTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AzurLaneTheme {
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
                        Text(text = "Авторизация",fontSize = 24.sp)

                        Button(
                            onClick = {
                                startActivity(Intent(this@MainActivity, LogActivity::class.java))
                            }
                        ) {
                            Text("Вход ")
                        }

                        Button(
                            onClick = {
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