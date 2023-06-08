namespace ScotlandsMountains.App
{
    public partial class MainPage : ContentPage
    {
        public MainPage(MountainsViewModel vm)
        {
            InitializeComponent();
            BindingContext = vm;
        }
    }
}