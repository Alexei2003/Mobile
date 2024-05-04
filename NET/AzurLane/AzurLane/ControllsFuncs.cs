using AzurLane.Classes;
using AzurLane.Data;

namespace AzurLane
{
    internal static class ControllsFuncs
    {
        public static async void FavouriteIamgeOnButtonClicked(object sender, System.EventArgs e)
        {
            var image = (Image)sender;
            var selectedUser = (string)image.BindingContext;

            if (ProgramData.UsersData[ProgramData.ActualUserId].Favourite == null)
            {
                FirebaseRealtimeDataBase.AddToFavourite(selectedUser);
                image.Source = ConstantCustom.URL_FAVOURITE;
            }
            else
            {
                if (ProgramData.UsersData[ProgramData.ActualUserId].Favourite.ContainsKey(selectedUser))
                {
                    FirebaseRealtimeDataBase.RemoveFromFavourite(selectedUser);
                    image.Source = ConstantCustom.URL_NO_FAVOURITE;
                }
                else
                {
                    FirebaseRealtimeDataBase.AddToFavourite(selectedUser);
                    image.Source = ConstantCustom.URL_FAVOURITE;
                }
            }
        }
    }
}
