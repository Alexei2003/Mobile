using AzurLane.Classes;
using AzurLane.Data;

namespace AzurLane.Pages;

public class LogPage : ContentPage
{
    private string email;
    private string pasword;

    public LogPage()
    {
        var namePage = new Label
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            FontSize = 20,
            Text = "Вход"
        };

        var emailField = new Entry
        {
            Placeholder = "Почта", // Текст, отображаемый в поле ввода до того, как пользователь введет текст
            TextColor = Color.FromRgb(255, 255, 255),
            PlaceholderColor = Color.FromRgb(255, 255, 255),
            HorizontalOptions = LayoutOptions.FillAndExpand
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
            Text = "Войти"
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
            var user = FirebaseAuth.Log(email, pasword);

            ProgramData.UsersData = FirebaseRealtimeDataBase.GetAllUsers();

            ProgramData.ActualUserId = user.User.Uid;

            await Navigation.PushAsync(new ObjectListPage());
        }
        catch
        {
            await Navigation.PopAsync();
        }

    }
}