namespace AzurLane.Pages;

public class MainPage : ContentPage
{
    public MainPage()
    {
        var namePage = new Label
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            FontSize = 20,
            Text = "Авторизация"
        };

        var toLogPage = new Button
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Вход"
        };
        toLogPage.Clicked += ToLogPageOnButtonClicked;

        var toSignPage = new Button
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Регистрация"
        };
        toSignPage.Clicked += ToSignPageOnButtonClicked;

        Content = new VerticalStackLayout
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            Spacing = 10, // Установка расстояния между дочерними элементами
            Padding = new Thickness(ConstantCustom.PADDING_ALL_PAGES),
            Children =
            {
                namePage,
                toLogPage,
                toSignPage,
            }
        };
    }

    private async void ToLogPageOnButtonClicked(object sender, System.EventArgs e)
    {
        await Navigation.PushAsync(new LogPage());
    }

    private async void ToSignPageOnButtonClicked(object sender, System.EventArgs e)
    {
        await Navigation.PushAsync(new SignPage());
    }
}