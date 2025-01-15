package com.example.azurlane

object RealtimeDataBaseData {
    var Users: HashMap<String, User> = hashMapOf()

    lateinit var actualUserId: String
    lateinit var selectedUserId: String
}

data class User(
    public var Construction: String? = null,
    public var Rarity: String? = null,
    public var Classification: String? = null,
    public var Faction: String? = null,
    public var Class: String? = null,
    public var VoiceActor: String? = null,
    public var Illustrator: String? = null,
    public var LimitBreak1: String? = null,
    public var LimitBreak2: String? = null,
    public var LimitBreak3: String? = null,

    public var Name: String? = null,
    public var MainImage: String? = null,
    public var Favourite: HashMap<String, String> = hashMapOf(),
    public var Images: ArrayList<String> = arrayListOf()
)
