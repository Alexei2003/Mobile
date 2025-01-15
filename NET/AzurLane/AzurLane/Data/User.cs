namespace AzurLane.Data
{
    internal class User
    {
        public string Name { get; set; } = null;
        public string MainImage { get; set; } = null;
        public Dictionary<string, string> Favourite { get; set; } = null;
        public List<string> Images { get; set; } = null;
        public string Construction { get; set; } = null;
        public string Rarity { get; set; } = null;
        public string Classification { get; set; } = null;
        public string Faction { get; set; } = null;
        public string Class { get; set; } = null;
        public string VoiceActor { get; set; } = null;
        public string Illustrator { get; set; } = null;
        public string LimitBreak1 { get; set; } = null;
        public string LimitBreak2 { get; set; } = null;
        public string LimitBreak3 { get; set; } = null;
    }
}
