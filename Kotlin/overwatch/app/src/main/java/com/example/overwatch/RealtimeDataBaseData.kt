package com.example.overwatch

object RealtimeDataBaseData {
    var Users: HashMap<String, User> = hashMapOf()

    lateinit var actualUserId: String
    lateinit var selectedUserId: String
}

data class User(
    public var Role: String? = null,
    public var HP: String? = null,
    public var Armor: String? = null,
    public var Difficult: String? = null,
    public var Age: String? = null,
    public var Nationality: String? = null,
    public var Occupation: String? = null,
    public var OperationalBase: String? = null,
    public var Relationships: String? = null,
    public var Affiliation: String? = null,

    public var Name: String? = null,
    public var MainImage: String? = null,
    public var Favourite: HashMap<String, String> = hashMapOf(),
    public var Images: ArrayList<String> = arrayListOf()
)
