//
//  ContentView.swift
//  Overwatch
//
//  Created by Prinz Eugen on 17.04.2024.
//  Copyright © 2024 Prinz Eugen. All rights reserved.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImageSwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

private let TEXT_NO_DATA = "No data"

private let TEXT_BUTTON_BACK = "Назад"
private let TEXT_BUTTON_SAVE = "Сохранить"
private let USER_NAME = "Name"
private let USERS = "Users"

private let URL_NO_MAIN_IMAGE = "https://firebasestorage.googleapis.com/v0/b/overwatch-95808.appspot.com/o/ProgramImage%2Fno_skin.png?alt=media&token=da62aaa8-4551-4e1c-80d8-288570b913c3"
private let URL_FAVOURITE = "https://firebasestorage.googleapis.com/v0/b/overwatch-95808.appspot.com/o/ProgramImage%2Fpng-transparent-abort-delete-cancel-icon-cross-no-access-denied.png?alt=media&token=b3cd70fd-c0cc-44a5-9218-889ec51c895f"
private let URL_NO_FAVOURITE = "https://firebasestorage.googleapis.com/v0/b/overwatch-95808.appspot.com/o/ProgramImage%2Fpng-clipart-computer-icons-graphics-symbol-plus-minus-share-icon-black-and-white.png?alt=media&token=50791534-6e3e-4514-8348-db93763d9ce1"

private let FIELDS = ["Role","HP","Armor","Difficult","Age","Nationality","Occupation","OperationalBase","Relationships","Affiliation"]

private let USER_FAVOURITE = "Favourite"
private let USER_MAIN_IMAGE = "MainImage"
private let USER_IMAGES = "Images"

func GetUserData(completion: @escaping ([String: [String: Any]]) -> Void) {
    Database.database().reference().child("Users").observe(.value) { snapshot in
        var usersDictionary: [String: [String: Any]] = [:]
        if let value = snapshot.value as? [String: Any] {
            // Помещаем ответ базы данных в словарь
            for (key, value) in value {
                if let innerDictionary = value as? [String: Any] {
                    usersDictionary[key] = innerDictionary
                }
            }
        }
        completion(usersDictionary)
    }
}

struct MainView: View {
    @State private var showingScreenNumb = 0
    
    @State private var usersDictionary:  [String: [String: Any]] = [:]
    
    @State private var selectedUserId:  String = ""
    
    @State private var actualUserId:  String = ""
    
    var body: some View {
        VStack {
            if showingScreenNumb == 0{
                
                Text("Авторизация", tableName: nil, bundle: Bundle.main, comment: "") // Пример параметров конструктора Text
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Button(action: {
                    self.showingScreenNumb = 1
                }) {
                    Text("Вход", tableName: nil, bundle: Bundle.main, comment: "") // Пример параметров конструктора Text
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.showingScreenNumb = 2
                }) {
                    Text("Регистрация", tableName: nil, bundle: Bundle.main, comment: "") // Пример параметров конструктора Text
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }else{
                if showingScreenNumb == 1{
                    LogView(isShowingScreen: $showingScreenNumb, usersDictionary: $usersDictionary, actualUserId: $actualUserId)
                }else{
                    if showingScreenNumb == 2{
                        SignView(isShowingScreen: $showingScreenNumb, usersDictionary: $usersDictionary, actualUserId: $actualUserId)
                    }else{
                        if showingScreenNumb == 3{
                            ObjectListView(isShowingScreen: $showingScreenNumb, usersDictionary: $usersDictionary, selectedUserId: $selectedUserId, actualUserId: $actualUserId)
                        }else{
                            if showingScreenNumb == 4{
                                UserProfileView(isShowingScreen: $showingScreenNumb, usersDictionary: $usersDictionary, selectedUserId: $selectedUserId, actualUserId: $actualUserId)
                            }else{
                                if showingScreenNumb == 5{
                                    UserSettingsView(isShowingScreen: $showingScreenNumb, usersDictionary: $usersDictionary, actualUserId: $actualUserId)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LogView: View {
    @Binding var isShowingScreen: Int
    
    @Binding var usersDictionary:  [String: [String: Any]]
    
    @Binding var actualUserId:  String
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var errorAuth = false
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.isShowingScreen = 0
                }) {
                    Text(TEXT_BUTTON_BACK)
                        .foregroundColor(.white) // Цвет текста
                        .padding() // Отступы внутри кнопки
                        .background(Color.orange)
                        .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                }
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Вход")
                .foregroundColor(.black) // Цвет текста
                .padding() // Отступы внутри кнопки
                .background(Color.white) // Цвет фона кнопки
                .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            
            VStack (alignment: .leading) {
                Text("Почта")
                    .foregroundColor(.black) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                
                TextField("Введите текст", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Отступы внутри кнопки
                
                Text("Пароль")
                    .foregroundColor(.black) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                
                TextField("Введите текст", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Отступы внутри кнопки
            }
            
            if errorAuth {
                Text("Ошибка аунтификации")
                    .foregroundColor(.red) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            }
            
            Button(action: {
                // Аутентификация пользователя
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (user, error) in
                    if let error = error {
                        // Обработка ошибок
                        print("Ошибка аутентификации: \(error.localizedDescription)")
                        self.errorAuth = true;
                    } else {
                        // Успешная аутентификация
                        print("Пользователь успешно вошел в систему: \(user?.user.email ?? "No email")")
                        
                        self.actualUserId = Auth.auth().currentUser?.uid ?? "Error"
                        
                        GetUserData { usersDictionary in
                            // Используйте полученный словарь пользователей здесь
                            self.usersDictionary = usersDictionary
                            // Выполняйте другие действия после успешной аутентификации
                            self.isShowingScreen = 3
                        }
                    }
                }
            }) {
                Text("Войти")
                    .foregroundColor(.white) // Цвет текста
                    .padding() // Отступы внутри кнопки
                    .background(Color.orange)
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            }
            
            Spacer()
        }
    }
}


struct SignView: View {
    @Binding var isShowingScreen: Int
    
    @Binding var usersDictionary:  [String: [String: Any]]
    
    @Binding var actualUserId:  String
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var errorAuth = false
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.isShowingScreen = 0
                }) {
                    Text(TEXT_BUTTON_BACK)
                        .foregroundColor(.white) // Цвет текста
                        .padding() // Отступы внутри кнопки
                        .background(Color.orange)
                        .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                }
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Регистрация")
                .foregroundColor(.black) // Цвет текста
                .padding() // Отступы внутри кнопки
                .background(Color.white) // Цвет фона кнопки
                .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            
            VStack (alignment: .leading) {
                Text("Имя")
                    .foregroundColor(.black) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                
                TextField("Введите текст", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Отступы внутри кнопки
                
                Text("Почта")
                    .foregroundColor(.black) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                
                TextField("Введите текст", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Отступы внутри кнопки
                
                Text("Пароль")
                    .foregroundColor(.black) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                
                TextField("Введите текст", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Отступы внутри кнопки
            }
            
            if errorAuth {
                Text("Ошибка регестрации")
                    .foregroundColor(.red) // Цвет текста
                    .padding(.horizontal) // Отступы внутри кнопки
                    .background(Color.white) // Цвет фона кнопки
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            }
            
            Button(action: {
                // Регистрация нового пользователя
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (user, error) in
                    if let error = error {
                        // Обработка ошибок
                        print("Ошибка регистрации: \(error.localizedDescription)")
                        self.errorAuth = true;
                    } else {
                        // Успешная регистрация
                        print("Пользователь успешно зарегистрирован: \(user?.user.email ?? "No email")")
                        
                        let uid = Auth.auth().currentUser?.uid
                        
                        self.actualUserId = uid!
                        
                        var userData: [String: Any] = [:]
                        userData[USER_NAME] = self.name
                        userData[USER_FAVOURITE] = [:]
                        userData[USER_MAIN_IMAGE] = nil
                        userData[USER_IMAGES] = [:]
                        
                        // Добавляем данные в словарь внутри цикла
                        for field in FIELDS {
                            userData[field] = TEXT_NO_DATA
                        }
                        
                        // Добавляем данные в определенный узел
                        Database.database().reference().child(USERS).child(uid!).setValue(userData)
                        
                        // Дождемся завершения операции регистрации и получим данные пользователя
                        GetUserData { usersDictionary in
                            // Используйте полученный словарь пользователей здесь
                            self.usersDictionary = usersDictionary
                            
                            // Выполним дальнейшие действия после успешной регистрации и получения данных пользователя
                            self.isShowingScreen = 3
                        }
                    }
                }
            }) {
                Text("Зарегистрироваться")
                    .foregroundColor(.white) // Цвет текста
                    .padding() // Отступы внутри кнопки
                    .background(Color.orange)
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            }
            
            
            Spacer()
        }
    }
}

struct ObjectListView: View {
    @Binding var isShowingScreen: Int
    
    @Binding var usersDictionary: [String: [String: Any]]
    
    @Binding var selectedUserId:  String
    
    @Binding var actualUserId:  String
    
    @State var showFavourite: Bool = false
    
    var body: some View {
        VStack {
            Text("Список персонажей", tableName: nil, bundle: Bundle.main, comment: "")
                .foregroundColor(.black) // Цвет текста
                .padding(.horizontal) // Отступы внутри кнопки
                .background(Color.white) // Цвет фона кнопки
                .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                       
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack{
                    ForEach(usersDictionary.keys.sorted(), id: \.self) { key in
                        VStack{
                            if (self.actualUserId != key){
                                Text(self.usersDictionary[key]?[USER_NAME] as? String ?? TEXT_NO_DATA)
                                    .padding(.horizontal)
                                
                                WebImage(url: URL(string: self.usersDictionary[key]?[USER_MAIN_IMAGE] as? String ??  URL_NO_MAIN_IMAGE))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                                    .padding()
                                
                                if (self.usersDictionary[self.actualUserId]?[USER_FAVOURITE] as? [String: String])?[key] != nil{
                                    WebImage(url: URL(string: URL_FAVOURITE))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .padding()
                                        .onTapGesture {
                                            Database.database().reference().child(USERS).child(self.actualUserId).child(USER_FAVOURITE).child(key).removeValue()
                                    }
                                }else{
                                    WebImage(url: URL(string: URL_NO_FAVOURITE))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .padding()
                                        .onTapGesture {
                                            Database.database().reference().child(USERS).child(self.actualUserId).child(USER_FAVOURITE).child(key).setValue(TEXT_NO_DATA)
                                    }
                                }
                            }
                        }
                        .onTapGesture { // Обработка нажатия на горизонтальный стек
                            self.selectedUserId = key
                            self.isShowingScreen = 4
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                self.selectedUserId = self.actualUserId
                
                // Выполним дальнейшие действия после успешной регистрации и получения данных пользователя
                self.isShowingScreen = 4
            }) {
                Text("Профиль пользователя", tableName: nil, bundle: Bundle.main, comment: nil)
                    .foregroundColor(.white) // Цвет текста
                    .padding() // Отступы внутри кнопки
                    .background(Color.orange)
                    .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            }
            
        }
    }
}


struct UserProfileView: View {
    @Binding var isShowingScreen: Int
    
    @Binding var usersDictionary: [String: [String: Any]]
    
    @Binding var selectedUserId:  String
    
    @Binding var actualUserId:  String
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    // Дождемся завершения операции регистрации и получим данные пользователя
                    GetUserData { usersDictionary in
                        // Используйте полученный словарь пользователей здесь
                        self.usersDictionary = usersDictionary
                        
                        // Выполним дальнейшие действия после успешной регистрации и получения данных пользователя
                        self.isShowingScreen = 3
                    }
                }) {
                    Text(TEXT_BUTTON_BACK)
                        .foregroundColor(.white) // Цвет текста
                        .padding() // Отступы внутри кнопки
                        .background(Color.orange)
                        .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                }
                Spacer()
            }
                .padding(.horizontal) // Отступы внутри кнопки
            
            Text("Профиль пользователя", tableName: nil, bundle: Bundle.main, comment: "") // Пример параметров конструктора Text
                .foregroundColor(Color.black) // Цвет текста
                .padding() // Отступы внутри кнопки
                .background(Color.white) // Цвет фона кнопки
                .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
            
            HStack{
                WebImage(url: URL(string: self.usersDictionary[self.selectedUserId]?[USER_MAIN_IMAGE] as? String ??  URL_NO_MAIN_IMAGE))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding()
                
                Text(self.usersDictionary[self.selectedUserId]?[USER_NAME] as? String ?? TEXT_NO_DATA)
                    .padding(.horizontal)
                
                Spacer()
                
                if self.actualUserId != self.selectedUserId{
                    if (self.usersDictionary[self.actualUserId]?[USER_FAVOURITE] as? [String: String])?[self.selectedUserId] != nil{
                        WebImage(url: URL(string: URL_FAVOURITE))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding()
                            .onTapGesture {
                                Database.database().reference().child(USERS).child(self.actualUserId).child(USER_FAVOURITE).child(self.selectedUserId).removeValue()
                                
                        }
                    }else{
                        WebImage(url: URL(string: URL_NO_FAVOURITE))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding()
                            .onTapGesture {
                                Database.database().reference().child(USERS).child(self.actualUserId).child(USER_FAVOURITE).child(self.selectedUserId).setValue(TEXT_NO_DATA)
                        }
                    }
                }
            }
                .padding(.horizontal) // Отступы внутри кнопки
            
          
            ScrollView(.vertical, showsIndicators: true) {
                VStack (alignment: .leading) {
                    ForEach(0..<FIELDS.count) { index in
                        HStack{
                            Text(FIELDS[index])
                                .foregroundColor(.black) // Цвет текста
                                .padding(.horizontal) // Отступы внутри кнопки
                                .background(Color.white) // Цвет фона кнопки
                                .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                            Spacer()
                        }
                        HStack{
                            Text(self.usersDictionary[self.selectedUserId]?[FIELDS[index]] as? String ?? TEXT_NO_DATA)
                                .foregroundColor(.black) // Цвет текста
                                .padding(.horizontal) // Отступы внутри кнопки
                                .background(Color.white) // Цвет фона кнопки
                                .cornerRadius(10) // Радиус скругления углов, делает кнопку круглой
                            Spacer()
                        }
                    }
                }
            }
            ScrollView(.horizontal, showsIndicators: true) {
                HStack{
                    ForEach(0..<((self.usersDictionary[self.selectedUserId]?[USER_IMAGES]as? [String])?.count ?? 0)) { index in
                        VStack{
                            WebImage(url: URL(string: (self.usersDictionary[self.selectedUserId]?[USER_IMAGES]as? [String])?[index] ?? URL_NO_MAIN_IMAGE))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250)
                                .padding()
                        }
                    }
                }
            }
            if self.actualUserId == self.selectedUserId{
                Button(action: {
                    self.isShowingScreen = 5
                }) {
                    Text("Редактировать данные", tableName: nil, bundle: Bundle.main, comment: "")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        // Успешный выход из аккаунта
                    } catch let signOutError as NSError {
                        // Обработка ошибки при выходе из аккаунта
                        print("Ошибка выхода из аккаунта: \(signOutError.localizedDescription)")
                    }
                    self.isShowingScreen = 0
                }) {
                    Text("Выход", tableName: nil, bundle: Bundle.main, comment: "")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

struct UserSettingsView: View {
    @Binding var isShowingScreen: Int
    @Binding var usersDictionary: [String: [String: Any]]
    @Binding var actualUserId: String
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    GetUserData { usersDictionary in
                        self.usersDictionary = usersDictionary
                        self.isShowingScreen = 4
                    }
                }) {
                    Text(TEXT_BUTTON_BACK)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Text("Настройки профиля", tableName: nil, bundle: Bundle.main, comment: nil)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    ForEach(0..<FIELDS.count) { index in
                        HStack {
                            Text(FIELDS[index])
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(10)
                            Spacer()
                        }
                        HStack {
                            TextField("", text: Binding<String>(
                                get: {
                                    self.usersDictionary[self.actualUserId]?[FIELDS[index]] as? String ?? "No Data"
                            },
                                set: { newValue in
                                    self.usersDictionary[self.actualUserId]?[FIELDS[index]] = newValue
                            }
                            ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("Аватарка")
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(10)
                        Spacer()
                    }
                    HStack {
                        TextField("", text: Binding<String>(
                            get: {
                                self.usersDictionary[self.actualUserId]?[USER_MAIN_IMAGE] as? String ?? TEXT_NO_DATA
                        },
                            set: { newValue in
                                self.usersDictionary[self.actualUserId]?[USER_MAIN_IMAGE] = newValue
                        }
                        ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        Spacer()
                    }
                }
            }
            
            
            Button(action: {
                Database.database().reference().child(USERS).child(self.actualUserId).setValue(self.usersDictionary[self.actualUserId])
                
                GetUserData { usersDictionary in
                    self.usersDictionary = usersDictionary
                    self.isShowingScreen = 4
                }
            }) {
                Text(TEXT_BUTTON_SAVE)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}

