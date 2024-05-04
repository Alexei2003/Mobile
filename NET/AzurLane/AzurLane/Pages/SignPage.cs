using AzurLane.Classes;
using AzurLane.Data;

namespace AzurLane.Pages;

public class SignPage : ContentPage
{
    private string name;
    private string email;
    private string pasword;

    public SignPage()
    {
        var namePage = new Label
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            FontSize = 20,
            Text = "Регистрация"
        };

        var nameField = new Entry
        {
            Placeholder = "Имя", // Текст, отображаемый в поле ввода до того, как пользователь введет текст
            HorizontalOptions = LayoutOptions.FillAndExpand,
            PlaceholderColor = Color.FromRgb(255, 255, 255),
            TextColor = Color.FromRgb(255, 255, 255),
        };
        nameField.TextChanged += (sender, e) =>
        {
            name = e.NewTextValue;
        };

        var emailField = new Entry
        {
            Placeholder = "Почта", // Текст, отображаемый в поле ввода до того, как пользователь введет текст
            HorizontalOptions = LayoutOptions.FillAndExpand,
            PlaceholderColor = Color.FromRgb(255, 255, 255),
            TextColor = Color.FromRgb(255, 255, 255),
        };
        emailField.TextChanged += (sender, e) =>
        {
            email = e.NewTextValue;
        };

        var passwordField = new Entry
        {
            Placeholder = "Пароль", // Текст, отображаемый в поле ввода до того, как пользователь введет текст
            HorizontalOptions = LayoutOptions.FillAndExpand,
            PlaceholderColor = Color.FromRgb(255, 255, 255),
            TextColor = Color.FromRgb(255, 255, 255),
        };
        passwordField.TextChanged += (sender, e) =>
        {
            pasword = e.NewTextValue;
        };

        var toObjectList = new Button
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Зарегистрироваться"
        };
        toObjectList.Clicked += ToObjectListOnButtonClicked;

        Content = new VerticalStackLayout
        {
            VerticalOptions = LayoutOptions.Center,
            Spacing = 10, // Установка расстояния между дочерними элементами
            Padding = new Thickness(ConstantCustom.PADDING_ALL_PAGES),
            Children =
            {
                namePage,
                nameField,
                emailField,
                passwordField,
                toObjectList
            }
        };
    }

    private async void ToObjectListOnButtonClicked(object sender, System.EventArgs e)
    {
        try
        {
            var user = FirebaseAuth.Sign(email, pasword, name);

            ProgramData.ActualUserId = user.User.Uid;

            FirebaseRealtimeDataBase.SetUser(ProgramData.ActualUserId, new User
            {
                Name = name,
                MainImage = ConstantCustom.TEXT_NO_DATA,
            });

            ProgramData.UsersData = FirebaseRealtimeDataBase.GetAllUsers();

            await Navigation.PushAsync(new ObjectListPage());
        }
        catch (Exception ex)
        {
            await Navigation.PopAsync();
        }
    }
}