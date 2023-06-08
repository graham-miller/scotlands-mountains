namespace ScotlandsMountains.App.ViewModels
{
    public partial class MountainsViewModel : ObservableObject
    {
        public MountainsViewModel(ScotlandsMountainsDbContext dbContext)
        {
            var classification = dbContext.Classifications
                .Where(x => x.DisplayOrder.HasValue)
                .OrderBy(x => x.DisplayOrder)
                .First();

            var mountains = dbContext.Mountains
                .Where(x => x.Classifications.Contains(classification))
                .OrderByDescending(x => (double) x.Height)
                .ToList();

            MountainNames = new ObservableCollection<string>(mountains.Select(x => x.Name));
        }

        [ObservableProperty]
        ObservableCollection<string> _mountainNames;

        [ObservableProperty]
        private string _name;

        [RelayCommand]
        private void Add()
        {
            MountainNames.Add(Name);
            Name = string.Empty;
        }
    }
}
