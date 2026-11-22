# Part 3 - Visualization, EDA and Business Thinking

## Data source
Trending YouTube Video Statistics (public dataset, available on Kaggle).
Files used (in the data/ folder): USvideos.csv, GBvideos.csv, INvideos.csv, categories.csv.
Records loaded: 46,230. After cleaning: 45,908.

## How to install
pip install -r requirements.txt

## How to run
1. Open the notebook in Google Colab.
2. Create a folder named data in Colab and upload the files from this folder's data/ folder.
3. Click Runtime -> Restart session and run all.

## Cleaning
- Dates were converted to datetimes.
- Missing likes and comment_count were filled with 0. Missing descriptions were filled with "No description".
- 230 duplicate rows were removed (same video_id, trending_date and country).
- 92 records of removed or errored videos were dropped.
- Category names were added with a left merge. days_to_trend was added.

## Where to find the results
All charts, interpretations, the funnel table, the retention results, the cohort view and the
content strategy briefing are written in Markdown cells of the notebook.

## Content strategy briefing
(Paste the final briefing here.)
