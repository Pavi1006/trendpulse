# Part 2 - NumPy and Pandas

## Data source
Trending YouTube Video Statistics (public dataset, available on Kaggle).
Files used (in the data/ folder): USvideos.csv, GBvideos.csv, INvideos.csv, categories.csv.
Records loaded: 46,230. After removing duplicates: 46,000.

## How to install
pip install -r requirements.txt

## How to run
1. Open the notebook in Google Colab.
2. Create a folder named data in Colab and upload the files from this folder's data/ folder.
3. Click Runtime -> Restart session and run all.

## Engagement score
score = 0.2 * normalized views + 0.4 * normalized likes + 0.4 * normalized comments
Each part is min-max normalized (scaled to 0-1) so that they can be added fairly.
Likes and comments need an action from the viewer, so I gave them more weight (0.4 each)
than views (0.2), which only means someone watched.

## Data-quality issues found
- Missing values: likes (12), comment_count (36), description (1,624).
- Duplicate rows: 230 rows with the same video_id, trending_date and country.
- Removed or errored videos: 92 records (kept).
- Comments disabled: 1,048 and ratings disabled: 544 (kept).
- Date columns were stored as text and were converted to datetimes.
- No zero-view records and no videos published after their trending date.

## Missing values and duplicates
- likes and comment_count: filled with 0 (a missing count means no recorded likes or comments).
- description: filled with "No description" (text, not used in calculations).
- dropna was applied to the key columns only (video_id, trending_date, title,
  channel_title). 0 rows were dropped.
- A duplicate is a row with the same video_id, trending_date and country. 230 were removed,
  keeping the first copy.

## Design decisions
- A left merge was used to add category names, so no trending records could be lost.
- The best publishing time was calculated with one row per video (its highest views),
  so popular videos were not counted many times.
