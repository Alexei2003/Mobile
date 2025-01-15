namespace AzurLane.Data
{
    internal static class ProgramData
    {
        public static Dictionary<string, User> UsersData { get; set; } = null;

        public static string ActualUserId { get; set; } = null;
        public static string SelectedUserId { get; set; } = null;
    }
}
