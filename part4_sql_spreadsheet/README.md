# Part 4 - SQL and Spreadsheet Analysis

## Tools used
- Python (Pandas) in Google Colab: to prepare the three clean CSV tables and the workbook data
- MySQL Server 8.0 and MySQL Workbench: schema, loading and queries
- Google Sheets (exported to .xlsx): pivot table, formulas, filters, conditional formatting

## Data source
Trending YouTube Video Statistics (public dataset, available on Kaggle), US, GB and IN files
plus categories.csv.

## How the tables were prepared (Python/Pandas)
- Combined the US, GB and IN files and converted the dates.
- Filled missing likes and comment_count with 0.
- Removed duplicates (same video_id, trending_date and country) and records of removed or
  errored videos. 45,908 clean records remain.
- categories.csv: from the course file.
- videos.csv: one row per unique video_id (its first trending appearance).
- trending_records.csv: one row per video per day per country, with a new record_id.
- Saved with df.to_csv(..., index=False).

## Order to run the .sql files
1. 01_schema.sql (creates the database and tables)
2. 02_load.sql (loads the three CSV files; the file paths must be changed to your own folder)
3. 03_basic_queries.sql
4. 04_grouping.sql
5. 05_joins.sql

## Schema design
- categories(category_id PK, category_name)
- videos(video_id PK, title, channel_title, category_id FK -> categories, publish_time)
- trending_records(record_id PK, video_id FK -> videos, country, trending_date, views, likes,
  dislikes, comment_count)
A category has many videos and a video has many trending records, so each fact is stored once
and linked by keys. video_id uses a case-sensitive collation because YouTube ids are
case-sensitive.

## Row counts after loading
- categories: [N]
- videos: [N]
- trending_records: 45,908

## Queries and output
SELECT video_id,
       trending_date AS trended_on,
       views         AS total_views,
       likes         AS total_likes
FROM trending_records
WHERE country = 'GB'
ORDER BY views DESC
LIMIT 10;
# video_id, trended_on, total_views, total_likes
'RdqSDDng84n', '2018-01-05', '360760164', '27537822'
'QYwpwP6y0Eb', '2018-01-27', '343297002', '9581910'
'RdqSDDng84n', '2018-01-04', '286714357', '21885701'
'QYwpwP6y0Eb', '2018-01-26', '282812154', '7893691'
'WQEWsMmimzZ', '2017-12-24', '255362869', '11413793'
'RdqSDDng84n', '2018-01-03', '236275528', '18035565'
'QYwpwP6y0Eb', '2018-01-25', '230704137', '6439282'
'RdqSDDng84n', '2018-01-02', '210747294', '16086924'
'WQEWsMmimzZ', '2017-12-23', '200444300', '8959133'
'QYwpwP6y0Eb', '2018-01-24', '181785943', '5073905'

SELECT DISTINCT country AS country_code
FROM trending_records
ORDER BY country_code;

# country_code
'GB'
'IN'
'US'

SELECT DISTINCT category_id
FROM videos
ORDER BY category_id;

# category_id
'1'
'2'
'10'
'15'
'17'
'19'
'20'
'22'
'23'
'24'
'25'
'26'
'27'
'28'

SELECT video_id,
       trending_date AS trended_on,
       views         AS total_views,
       likes         AS total_likes
FROM trending_records
WHERE country = 'US'
  AND views >= 1000000
  AND likes > 50000
ORDER BY views DESC
LIMIT 5;

# video_id, trended_on, total_views, total_likes
'HPG-bd_JLxn', '2018-01-11', '129229245', '5964932'
'yd4LMLxXzWE', '2018-01-06', '119711498', '6795138'
'HPG-bd_JLxn', '2018-01-10', '109129467', '5037172'
'Nc1MUQvmyWO', '2017-12-18', '97553795', '3371264'
'yd4LMLxXzWE', '2018-01-05', '97342335', '5525406'

SELECT country,
       COUNT(*)          AS records,
       ROUND(AVG(views)) AS avg_views
FROM trending_records
GROUP BY country
ORDER BY avg_views DESC;

# country, records, avg_views
'GB', '14970', '1583959'
'US', '15968', '1014564'
'IN', '14970', '953217'

SELECT country,
       ROUND(AVG(views)) AS avg_views,
       SUM(views)        AS total_views
FROM trending_records
GROUP BY country
HAVING AVG(views) > 1000000;

# country, avg_views, total_views
'US', '1014564', '16200562599'
'GB', '1583959', '23711862022'

SELECT channel_title,
       COUNT(DISTINCT video_id) AS trending_videos
FROM videos
GROUP BY channel_title
HAVING COUNT(DISTINCT video_id) >= 5
ORDER BY trending_videos DESC
LIMIT 10;

# channel_title, trending_videos
'UltimateUnboxing65', '522'
'QuietChallenge75', '466'
'OfficialReview41', '457'
'InsaneReaction46', '321'
'Brand NewChallenge45', '302'
'UltimateSpeech20', '292'
'CrazyTrailer91', '283'
'WildHighlights7', '245'
'UltimateVlog96', '233'
'SurprisingChallenge82', '216'

SELECT c.category_name,
       COUNT(*)            AS records,
       ROUND(AVG(t.views)) AS avg_views
FROM trending_records t
INNER JOIN videos v     ON t.video_id = v.video_id
INNER JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_name
HAVING AVG(t.views) > 500000
ORDER BY avg_views DESC;

# category_name, records, avg_views
'Music', '10286', '3193066'
'Entertainment', '12244', '901973'
'Comedy', '3251', '602812'
'Film & Animation', '2290', '578835'
'People & Blogs', '3797', '551729'
'Gaming', '2055', '509739'

### Join explanations
SELECT t.record_id,
       v.title         AS video_title,
       c.category_name AS category,
       t.trending_date AS trended_on,
       t.views         AS total_views
FROM trending_records t
INNER JOIN videos v     ON t.video_id = v.video_id
INNER JOIN categories c ON v.category_id = c.category_id
WHERE t.country = 'IN'
ORDER BY t.views DESC
LIMIT 10;

# record_id, video_title, category, trended_on, total_views
'36327', 'The Hollow Pines - Cricket (Official Video) FINALE', 'Music', '2017-12-11', '123208090'
'36128', 'The Hollow Pines - Cricket (Official Video) FINALE', 'Music', '2017-12-10', '104843706'
'36727', 'Surprising Election Highlights', 'Entertainment', '2017-12-13', '101560749'
'35929', 'The Hollow Pines - Cricket (Official Video) FINALE', 'Music', '2017-12-09', '84980873'
'36527', 'Surprising Election Highlights', 'Entertainment', '2017-12-12', '78112111'
'35730', 'The Hollow Pines - Cricket (Official Video) FINALE', 'Music', '2017-12-08', '70470396'
'36328', 'Surprising Election Highlights', 'Entertainment', '2017-12-11', '65822172'
'35532', 'The Hollow Pines - Cricket (Official Video) FINALE', 'Music', '2017-12-07', '60909227'
'45110', 'Kairo - Space (Lyric Video)!!', 'Music', '2018-01-24', '56884049'
'36129', 'Surprising Election Highlights', 'Entertainment', '2017-12-10', '55271615'

Records that have both a matching video and a matching category, and an INNER JOIN drops anything without a match.

SELECT c.category_id,
       c.category_name
FROM categories c
LEFT JOIN videos v ON c.category_id = v.category_id
WHERE v.video_id IS NULL
ORDER BY c.category_id;

# category_id, category_name
'29', 'Nonprofits & Activism'
'30', 'Movies'
'43', 'Shows'
every category, including those with no video, and then find them with IS NULL. An INNER JOIN would remove exactly the categories I am looking for.

SELECT c.category_name,
       COUNT(v.video_id) AS videos
FROM videos v
RIGHT JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_name
ORDER BY videos DESC;

# category_name, videos
'Entertainment', '3385'
'Music', '1882'
'News & Politics', '1379'
'People & Blogs', '1330'
'Comedy', '1128'
'Film & Animation', '827'
'Sports', '797'
'Gaming', '767'
'Howto & Style', '742'
'Science & Technology', '660'
'Education', '653'
'Autos & Vehicles', '415'
'Pets & Animals', '395'
'Travel & Events', '328'
'Nonprofits & Activism', '0'
'Movies', '0'
'Shows', '0'
count for every category, including zero. An INNER JOIN would hide categories with no videos, and COUNT(v.video_id) counts only matched videos.

## Spreadsheet workbook
Country	Records	Average views
US	15968	1014564.291
GB	14970	1583958.719
IN	14970	953217.3738
		
Total records	45908	
Total views	54182088707	
Overall average views	1180231.958	
		
Music records	10286	
Music average views	3193066.328	
## Cross-check
Spreadsheet: Summary!B2 = 15,968.

SELECT country, COUNT(*) AS records
FROM trending_records
WHERE country = 'US'
GROUP BY country;  

# country, records
'US', '15968'
### Cross-check: SQL vs spreadsheet

| Number | SQL result | Spreadsheet result | Match? |
|---|---|---|---|
| Records for US | 15,968 | 15,968 (Summary!B2, =COUNTIF) | Yes |
| Records for Music | 10,286 | 10,286 (Summary!B10, =COUNTIF) | Yes |
| Average views for Music | 3,193,066 | 3,193,066.328 (Summary!B11, =AVERAGEIF) | Yes (SQL rounds to a whole number) |

Both tools read the same 45,908 cleaned records, so the results agree.
