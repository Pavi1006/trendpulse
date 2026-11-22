CREATE DATABASE IF NOT EXISTS trendpulse;
USE trendpulse;

DROP TABLE IF EXISTS trending_records;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
    category_id   INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE videos (
    video_id      VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin PRIMARY KEY,
    title         VARCHAR(500) NOT NULL,
    channel_title VARCHAR(255),
    category_id   INT NOT NULL,
    publish_time  DATETIME,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE trending_records (
    record_id     INT PRIMARY KEY,
    video_id      VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    country       CHAR(2) NOT NULL,
    trending_date DATE NOT NULL,
    views         BIGINT,
    likes         BIGINT,
    dislikes      BIGINT,
    comment_count BIGINT,
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);