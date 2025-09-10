CREATE TABLE youtube_trending (
    video_id VARCHAR(20),
    title VARCHAR(255),
    channel_title VARCHAR(100),
    category VARCHAR(50),
    views INT,
    likes INT,
    dislikes INT,
    comment_count INT,
    publish_time DATE,
    country VARCHAR(50)
);
ALTER TABLE youtube_trending ALTER COLUMN publish_time TYPE TEXT;

SELECT * FROM youtube_trending LIMIT 5;

--Top 3 Viral Videos by Like Ratio

SELECT title, channel_title, 
       ROUND((likes * 1.0 / views) * 100, 2) AS like_ratio
FROM youtube_trending
ORDER BY like_ratio DESC
LIMIT 3;


--Most Popular Category per Country

SELECT country, category, SUM(views) AS total_views
FROM youtube_trending
GROUP BY country, category
ORDER BY country, total_views DESC;


--Rank Creators by Engagement

SELECT channel_title, 
       SUM(likes + comment_count) AS engagement_score,
       RANK() OVER (ORDER BY SUM(likes + comment_count) DESC) AS rank_position
FROM youtube_trending
GROUP BY channel_title;




