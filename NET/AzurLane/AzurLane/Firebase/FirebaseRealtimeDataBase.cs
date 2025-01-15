using AzurLane.Data;
using FireSharp.Config;
using FireSharp.Interfaces;
using Newtonsoft.Json;

namespace AzurLane.Classes
{
    internal static class FirebaseRealtimeDataBase
    {
        private static IFirebaseClient client = new FireSharp.FirebaseClient(
            new FirebaseConfig()
            {
                AuthSecret = FirebaseConfigConstant.DB_SECRET,
                BasePath = FirebaseConfigConstant.URL_DATABASE
            }
        );

        private const string USERS_NODE = "Users";
        private const string FAVOURITE = "Favourite";

        public static Dictionary<string, User> GetAllUsers()
        {
            var response = client.Get(USERS_NODE);
            return JsonConvert.DeserializeObject<Dictionary<string, User>>(response.Body);
        }

        public static void SetUser(string uid, User user)
        {
            client.Set(USERS_NODE + "\\" + uid, user);
        }

        public static void AddToFavourite(string uid)
        {

            client.Set(USERS_NODE + "\\" + ProgramData.ActualUserId + "\\" + FAVOURITE + "\\" + uid, ConstantCustom.TEXT_NO_DATA);

            if (ProgramData.UsersData[ProgramData.ActualUserId].Favourite == null)
            {
                ProgramData.UsersData[ProgramData.ActualUserId].Favourite = new Dictionary<string, string>
                {
                    { uid, ConstantCustom.TEXT_NO_DATA }
                };
            }
            else
            {
                ProgramData.UsersData[ProgramData.ActualUserId].Favourite.Add(uid, ConstantCustom.TEXT_NO_DATA);
            }
        }

        public static void RemoveFromFavourite(string uid)
        {
            client.Delete(USERS_NODE + "\\" + ProgramData.ActualUserId + "\\" + FAVOURITE + "\\" + uid);

            ProgramData.UsersData[ProgramData.ActualUserId].Favourite.Remove(uid);
        }
    }
}
