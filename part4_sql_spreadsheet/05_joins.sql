USE trendpulse;

-- Q9: INNER JOIN across three tables: IN records with video title and category name
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

-- Q10: LEFT JOIN: categories that have no video in the data
SELECT c.category_id,
       c.category_name
FROM categories c
LEFT JOIN videos v ON c.category_id = v.category_id
WHERE v.video_id IS NULL
ORDER BY c.category_id;

-- Q11: RIGHT JOIN: every category with its number of videos, including categories with zero
SELECT c.category_name,
       COUNT(v.video_id) AS videos
FROM videos v
RIGHT JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_name
ORDER BY videos DESC;