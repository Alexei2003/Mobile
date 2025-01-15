using AzurLane.Data;
using Microsoft.Maui.Layouts;

namespace AzurLane.Pages;

public class ObjectListPage : ContentPage
{
    public ObjectListPage()
    {
        var verticalStack = new VerticalStackLayout()
        {
            HorizontalOptions = LayoutOptions.Fill,
            VerticalOptions = LayoutOptions.Start,
            Spacing = ConstantCustom.IMAGE_SIZE / 2, // Установка расстояния между дочерними элементами
        };

        var namePage = new Label
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            FontSize = 20,
            Text = "Список персонажей"
        };
        verticalStack.Add(namePage);

        foreach (var user in ProgramData.UsersData)
        {
            if (user.Key == ProgramData.ActualUserId)
            {
                continue;
            }

            var horizontalStack = new FlexLayout
            {
                Direction = FlexDirection.Row, // Элементы будут располагаться в ряд
                JustifyContent = FlexJustify.SpaceBetween, // Распределение пространства между элементами
                AlignItems = FlexAlignItems.Center, // Выравнивание элементов по центру
                AlignContent = FlexAlignContent.Center, // Выравнивание содержимого по центру
                Wrap = FlexWrap.NoWrap, // Без переноса элементов
                BindingContext = user.Key,
            };
            var HorizontalStacktapGestureRecognizer = new TapGestureRecognizer();
            HorizontalStacktapGestureRecognizer.Tapped += ToSelectedUserProfileOnButtonClicked;
            horizontalStack.GestureRecognizers.Add(HorizontalStacktapGestureRecognizer);

            var mainImage = new Image()
            {
                Source = user.Value.MainImage == ConstantCustom.TEXT_NO_DATA ? ConstantCustom.URL_NO_MAIN_IMAGE : user.Value.MainImage ?? ConstantCustom.URL_NO_MAIN_IMAGE,
                WidthRequest = ConstantCustom.IMAGE_SIZE,
                HeightRequest = ConstantCustom.IMAGE_SIZE
            };
            horizontalStack.Add(mainImage);

            var name = new Label()
            {
                HorizontalOptions = LayoutOptions.Center,
                VerticalOptions = LayoutOptions.Center,
                TextColor = Color.FromRgb(255, 255, 255),
                FontSize = 18,
                Text = user.Value.Name ?? ConstantCustom.TEXT_NO_DATA
            };
            horizontalStack.Add(name);

            var favouriteImage = new Image()
            {
                Source = ProgramData.UsersData[ProgramData.ActualUserId].Favourite == null ? ConstantCustom.URL_NO_FAVOURITE : ProgramData.UsersData[ProgramData.ActualUserId].Favourite.ContainsKey(user.Key) ? ConstantCustom.URL_FAVOURITE : ConstantCustom.URL_NO_FAVOURITE,
                WidthRequest = ConstantCustom.IMAGE_SIZE,
                HeightRequest = ConstantCustom.IMAGE_SIZE,
                BindingContext = user.Key,
            };
            var favouriteImageGestureRecognizer = new TapGestureRecognizer();
            favouriteImageGestureRecognizer.Tapped += ControllsFuncs.FavouriteIamgeOnButtonClicked;
            favouriteImage.GestureRecognizers.Add(favouriteImageGestureRecognizer);
            horizontalStack.Add(favouriteImage);

            verticalStack.Add(horizontalStack);
        }

        var toActualUserProfile = new Button
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Профиль пользователя"
        };
        toActualUserProfile.Clicked += ToActualUserProfileOnButtonClicked;
        verticalStack.Add(toActualUserProfile);

        var usersScrollView = new ScrollView
        {
            Content = verticalStack
        };

        Content = usersScrollView;
    }

    private async void ToActualUserProfileOnButtonClicked(object sender, System.EventArgs e)
    {
        ProgramData.SelectedUserId = ProgramData.ActualUserId;
        await Navigation.PushAsync(new UserProfilePage());
    }

    private async void ToSelectedUserProfileOnButtonClicked(object sender, System.EventArgs e)
    {
        ProgramData.SelectedUserId = (string)((FlexLayout)sender).BindingContext;
        await Navigation.PushAsync(new UserProfilePage());
    }
    protected override bool OnBackButtonPressed()
    {
        return true;
    }
}