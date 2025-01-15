package com.example.cities

object RealtimeDataBaseData {
    var Users: HashMap<String, User> = hashMapOf()

    lateinit var actualUserId: String
    lateinit var selectedUserId: String
}

data class User(
    public var Region: String? = null,
    public var District: String? = null,
    public var Founded: String? = null,
    public var Area: String? = null,
    public var Elevation: String? = null,
    public var Population: String? = null,
    public var TimeZone: String? = null,
    public var PostalCode: String? = null,
    public var AreaCode: String? = null,
    public var LicensePlate: String? = null,

    public var Name: String? = null,
    public var MainImage: String? = null,
    public var Favourite: HashMap<String, String> = hashMapOf(),
    public var Images: ArrayList<String> = arrayListOf()
)
