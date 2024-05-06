using AzurLane.Classes;
using AzurLane.Data;
using Microsoft.Maui.Layouts;

namespace AzurLane.Pages;

public class UserProfilePage : ContentPage
{
    public UserProfilePage()
    {

        var verticalStack = new VerticalStackLayout()
        {
            HorizontalOptions = LayoutOptions.Fill,
            VerticalOptions = LayoutOptions.Start,
            Spacing = ConstantCustom.IMAGE_SIZE * 1.5f / 2,
        };


        var namePage = new Label
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            FontSize = 20,
            Text = "Профиль пользователя"
        };
        verticalStack.Add(namePage);

        var horizontalStack = new FlexLayout
        {
            Direction = FlexDirection.Row, // Элементы будут располагаться в ряд
            JustifyContent = FlexJustify.SpaceBetween, // Распределение пространства между элементами
            AlignItems = FlexAlignItems.Center, // Выравнивание элементов по центру
            AlignContent = FlexAlignContent.Center, // Выравнивание содержимого по центру
            Wrap = FlexWrap.NoWrap, // Без переноса элементов
            BindingContext = ProgramData.ActualUserId,
        };

        var user = ProgramData.UsersData[ProgramData.SelectedUserId];

        var mainImage = new Image()
        {
            Source = user.MainImage == ConstantCustom.TEXT_NO_DATA ? ConstantCustom.URL_NO_MAIN_IMAGE : user.MainImage ?? ConstantCustom.URL_NO_MAIN_IMAGE,
            WidthRequest = ConstantCustom.IMAGE_SIZE * 1.5f, 
            HeightRequest = ConstantCustom.IMAGE_SIZE * 1.5f, 
        };
        horizontalStack.Add(mainImage);

        var name = new Label()
        {
            HorizontalOptions = LayoutOptions.Center,
            VerticalOptions = LayoutOptions.Center,
            TextColor = Color.FromRgb(255, 255, 255),
            FontSize = 28,
            Text = user.Name ?? ConstantCustom.TEXT_NO_DATA
        };
        horizontalStack.Add(name);

        if (ProgramData.SelectedUserId != ProgramData.ActualUserId)
        {
            var favouriteImage = new Image()
            {
                Source = ProgramData.UsersData[ProgramData.ActualUserId].Favourite == null ? ConstantCustom.URL_NO_FAVOURITE : ProgramData.UsersData[ProgramData.ActualUserId].Favourite.ContainsKey(ProgramData.SelectedUserId) ? ConstantCustom.URL_FAVOURITE : ConstantCustom.URL_NO_FAVOURITE,
                WidthRequest = ConstantCustom.IMAGE_SIZE * 1.5f,
                HeightRequest = ConstantCustom.IMAGE_SIZE * 1.5f,
                BindingContext = ProgramData.SelectedUserId,
            };
            var favouriteImageGestureRecognizer = new TapGestureRecognizer();
            favouriteImageGestureRecognizer.Tapped += ControllsFuncs.FavouriteIamgeOnButtonClicked;
            favouriteImage.GestureRecognizers.Add(favouriteImageGestureRecognizer);
            horizontalStack.Add(favouriteImage);
        }
        else
        {
            var spacer = new BoxView()
            {
                WidthRequest = ConstantCustom.IMAGE_SIZE * 1.5f, 
                HeightRequest = ConstantCustom.IMAGE_SIZE * 1.5f, 
            };
            horizontalStack.Add(spacer);
        }
        verticalStack.Add(horizontalStack);

        var vStackTextField = new VerticalStackLayout();

        var constructionLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Construction"
        };
        vStackTextField.Add(constructionLabelName);
        var constructionLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].Construction ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(constructionLabelData);

        var rarityLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Rarity"
        };
        vStackTextField.Add(rarityLabelName);
        var rarityLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].Rarity ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(rarityLabelData);

        var classificationLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Classification"
        };
        vStackTextField.Add(classificationLabelName);
        var classificationLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].Classification ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(classificationLabelData);

        var factionLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Faction"
        };
        vStackTextField.Add(factionLabelName);
        var factionLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].Faction ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(factionLabelData);

        var classLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Class"
        };
        vStackTextField.Add(classLabelName);
        var classLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].Class ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(classLabelData);

        var voiceActorLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "VoiceActor"
        };
        vStackTextField.Add(voiceActorLabelName);
        var voiceActorLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].VoiceActor ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(voiceActorLabelData);

        var illustratorLabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "Illustrator"
        };
        vStackTextField.Add(illustratorLabelName);
        var illustratorLabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].Illustrator ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(illustratorLabelData);

        var limitBreak1LabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "LimitBreak1"
        };
        vStackTextField.Add(limitBreak1LabelName);
        var limitBreak1LabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].LimitBreak1 ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(limitBreak1LabelData);

        var limitBreak2LabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "LimitBreak2"
        };
        vStackTextField.Add(limitBreak2LabelName);
        var limitBreak2LabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].LimitBreak2 ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(limitBreak2LabelData);

        var limitBreak3LabelName = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = "LimitBreak3"
        };
        vStackTextField.Add(limitBreak3LabelName);
        var limitBreak3LabelData = new Label()
        {
            TextColor = Color.FromRgb(255, 255, 255),
            Text = ProgramData.UsersData[ProgramData.SelectedUserId].LimitBreak3 ?? ConstantCustom.TEXT_NO_DATA
        };
        vStackTextField.Add(limitBreak3LabelData);

        verticalStack.Add(vStackTextField);

        var vStackImage = new VerticalStackLayout()
        {
            HorizontalOptions = LayoutOptions.Fill,
            VerticalOptions = LayoutOptions.Center,
            Spacing = ConstantCustom.IMAGE_SIZE * 4f / 2,
        };

        if (ProgramData.UsersData[ProgramData.SelectedUserId].Images != null)
        {
            foreach (var imageURL in ProgramData.UsersData[ProgramData.SelectedUserId].Images)
            {
                var image = new Image()
                {
                    Source = imageURL == ConstantCustom.TEXT_NO_DATA ? ConstantCustom.URL_NO_MAIN_IMAGE : imageURL ?? ConstantCustom.URL_NO_MAIN_IMAGE,
                    WidthRequest = ConstantCustom.IMAGE_SIZE * 4f,
                    HeightRequest = ConstantCustom.IMAGE_SIZE * 4f,
                };
                vStackImage.Add(image);
            }
        }

        verticalStack.Add(vStackImage);

        if (ProgramData.SelectedUserId == ProgramData.ActualUserId)
        {
            var vStackButton = new VerticalStackLayout()
            {
                Spacing = 10,
            };

            var signOut = new Button
            {
                HorizontalOptions = LayoutOptions.Center,
                VerticalOptions = LayoutOptions.Center,
                TextColor = Color.FromRgb(255, 255, 255),
                Text = "Выход"
            };
            signOut.Clicked += SignOutOnButtonClicked;
            vStackButton.Add(signOut);
            verticalStack.Add(vStackButton);
        }

        var usersScrollView = new ScrollView
        {
            Content = verticalStack
        };

        Content = usersScrollView;
    }

    private async void SignOutOnButtonClicked(object sender, System.EventArgs e)
    {
        FirebaseAuth.SignOut();
        await Navigation.PopToRootAsync();
    }

    protected override bool OnBackButtonPressed()
    {
        ProgramData.UsersData = FirebaseRealtimeDataBase.GetAllUsers();
        Navigation.PushAsync(new ObjectListPage());
        return true;
    }
}