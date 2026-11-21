# Part 1 - Python Foundations & Data Structures

## Data source
Trending YouTube Video Statistics (public dataset, available on Kaggle).
Files used (in the data/ folder): USvideos.csv, GBvideos.csv, INvideos.csv, categories.csv.
Total records loaded: 46,230.

## How to install
pip install -r requirements.txt

## How to run
1. Open the notebook in Google Colab.
2. Upload the files from the data/ folder into a folder named data in Colab.
3. Click Runtime -> Restart session and run all.

## Cleaning rules
- views, likes, dislikes, comment_count: converted to integers. Bad values become 0.
- comments_disabled, ratings_disabled: converted to True/False. Bad values become False.
- trending_date (yy.dd.mm) and publish_time: converted to dates. Records with
  a bad date would be dropped (0 were dropped).
- Parse failures: likes 12, comment_count 36, all other fields 0.

## Classification thresholds
- Unrated: ratings disabled, or likes + dislikes = 0
- Low Engagement: 0 views, under 100,000 views, or comments disabled with under 100,000 views
- Viral Hit: 1,000,000+ views and like ratio >= 0.80
- Steady Performer: 100,000 to 999,999 views and like ratio >= 0.80
- Divisive: 100,000+ views and like ratio < 0.80

## Design decisions
- Only pd.read_csv() and to_dict("records") use Pandas. Everything else is core Python.
- Each data structure was chosen for its job (explained in the notebook).
The CSVs were trimmed by dropping the description, tags and thumbnail_link columns.
Run the notebook top to bottom in Google Colab
