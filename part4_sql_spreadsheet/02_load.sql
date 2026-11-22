USE trendpulse;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv'
INTO TABLE categories
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(category_id, category_name);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/videos.csv'
INTO TABLE videos
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(video_id, title, channel_title, category_id, publish_time);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/trending_records.csv'
INTO TABLE trending_records
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(record_id, video_id, country, trending_date, views, likes, dislikes, comment_count);

SELECT COUNT(*) AS categories_rows FROM categories;
SELECT COUNT(*) AS videos_rows FROM videos;
SELECT COUNT(*) AS trending_records_rows FROM trending_records;