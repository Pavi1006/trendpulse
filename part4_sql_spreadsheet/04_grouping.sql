USE trendpulse;

-- Q5: records and average views per country (GROUP BY, COUNT, AVG)
SELECT country,
       COUNT(*)          AS records,
       ROUND(AVG(views)) AS avg_views
FROM trending_records
GROUP BY country
ORDER BY avg_views DESC;

-- Q6: countries whose average views are above 1,000,000 (GROUP BY + HAVING)
SELECT country,
       ROUND(AVG(views)) AS avg_views,
       SUM(views)        AS total_views
FROM trending_records
GROUP BY country
HAVING AVG(views) > 1000000;

-- Q7: channels with at least 5 distinct trending videos (GROUP BY + HAVING)
SELECT channel_title,
       COUNT(DISTINCT video_id) AS trending_videos
FROM videos
GROUP BY channel_title
HAVING COUNT(DISTINCT video_id) >= 5
ORDER BY trending_videos DESC
LIMIT 10;

-- Q8: categories whose average views are above 500,000 (GROUP BY + HAVING over joined tables)
SELECT c.category_name,
       COUNT(*)            AS records,
       ROUND(AVG(t.views)) AS avg_views	
FROM trending_records t
INNER JOIN videos v     ON t.video_id = v.video_id
INNER JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_name
HAVING AVG(t.views) > 500000
ORDER BY avg_views DESC;