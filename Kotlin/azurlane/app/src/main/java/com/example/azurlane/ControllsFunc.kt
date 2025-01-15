package com.example.azurlane

import android.app.Activity
import android.content.Intent
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import coil.compose.rememberImagePainter
import com.example.azurlane.activity.UserProfileActivity
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.ValueEventListener
import com.google.firebase.database.database


object ControllsFunc {
    @Composable
    fun LoadImageFromUrl(
        imageUrl: String,
        modifier: Modifier = Modifier
            .width(50.dp)
            .height(50.dp),
        uid :String = "",
    ) {
        // Обновляем URL изображения
        var currentImageUrl by remember { mutableStateOf(imageUrl) }

        val painter: Painter = rememberImagePainter(
            data = if(currentImageUrl!= ConstantsCustom.TEXT_NO_DATA) currentImageUrl else ConstantsCustom.URL_NO_MAIN_IMAGE,
            builder = {
                // Дополнительные настройки, если нужно
            }
        )

        if (imageUrl == ConstantsCustom.URL_FAVOURITE || imageUrl == ConstantsCustom.URL_NO_FAVOURITE) {
            Image(
                painter = painter,
                contentDescription = null,
                modifier = modifier
                    .clickable {
                        var user = RealtimeDataBaseData.Users[RealtimeDataBaseData.actualUserId]
                        if(currentImageUrl == ConstantsCustom.URL_FAVOURITE){
                            currentImageUrl = ConstantsCustom.URL_NO_FAVOURITE
                            user!!.Favourite.remove(uid)
                        }else{
                            currentImageUrl = ConstantsCustom.URL_FAVOURITE
                            user!!.Favourite.set(uid,ConstantsCustom.TEXT_NO_DATA)
                        }
                        PushUserData(user);
                    },
                contentScale = ContentScale.Crop
            )
        } else {
            Image(
                painter = painter,
                contentDescription = null,
                modifier = modifier,
                contentScale = ContentScale.Crop
            )
        }
    }

    fun GetUserDataAndNavigateActivity(currentActivity: Activity, nextActivityClass: Class<*>) {
        val database = Firebase.database
        val myRef = database.getReference()

        // Чтение данных один раз
        myRef.addListenerForSingleValueEvent(object : ValueEventListener {
            override fun onDataChange(dataSnapshot: DataSnapshot) {
                try {
                    val realtimeData = dataSnapshot.getValue(RealtimeDataBaseData::class.java)
                    if (realtimeData != null) {
                        RealtimeDataBaseData.Users = realtimeData.Users

                        val auth = FirebaseAuth.getInstance()
                        RealtimeDataBaseData.actualUserId = auth.currentUser!!.uid

                        // Переход к следующему окну
                        navigateToNextActivity(currentActivity, nextActivityClass)
                    }
                } catch (ex: Exception) {
                    return;
                }
            }

            override fun onCancelled(error: DatabaseError) {
                TODO("Not yet implemented")
            }
        })
    }

    fun navigateToNextActivity(currentActivity: Activity, nextActivityClass: Class<*>) {
        val intent = Intent(currentActivity, nextActivityClass)
        currentActivity.startActivity(intent)
    }

    fun PushUserData(user: User, uid: String = RealtimeDataBaseData.actualUserId) {
        val database = Firebase.database
        val myRef = database.getReference("Users/" + uid)

        myRef.setValue(user)
    }
}

