USE trendpulse;

-- Q1: the 10 most-viewed trending records in GB (WHERE, ORDER BY, LIMIT, aliases)
SELECT video_id,
       trending_date AS trended_on,
       views         AS total_views,
       likes         AS total_likes
FROM trending_records
WHERE country = 'GB'
ORDER BY views DESC
LIMIT 10;

-- Q2: the distinct countries in the data (DISTINCT)
SELECT DISTINCT country AS country_code
FROM trending_records
ORDER BY country_code;

-- Q3: the distinct categories that have videos (DISTINCT)
SELECT DISTINCT category_id
FROM videos
ORDER BY category_id;

-- Q4: US records with 1M+ views and more than 50,000 likes (WHERE with AND)
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