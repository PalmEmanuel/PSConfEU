namespace PipeHow.RssTrigger
{
    public class RssPost
    {
        public string Source { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }

        public override string ToString()
        {
            return $"{Source}: {Title}";
        }
    }
}