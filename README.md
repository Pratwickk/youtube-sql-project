# YouTube Trending Video Analysis (PostgreSQL Project)

## Project Overview
This project uses **PostgreSQL** to analyze a mock dataset of trending YouTube videos.  
The goal was to explore **viral content patterns**, identify **popular categories by country**, and **rank creators** based on engagement.

---

## Dataset
Dataset: `youtube_trending_mock.csv` (15 sample records).  
Columns include:  
- `video_id`, `title`, `channel_title`, `category`  
- `views`, `likes`, `dislikes`, `comment_count`  
- `publish_time`, `country`

---

## SQL Queries & Insights

### Top 3 Viral Videos (Like-to-View Ratio)

SELECT title, channel_title, 
       ROUND((likes * 1.0 / views) * 100, 2) AS like_ratio
FROM youtube_trending
ORDER BY like_ratio DESC
LIMIT 3;
Insight: “Funny Dog Video” had the highest engagement rate, showing strong viral potential.



### Most Popular Category per Country

SELECT country, category, SUM(views) AS total_views
FROM youtube_trending
GROUP BY country, category
ORDER BY country, total_views DESC;

Insight: Technology dominated in India/USA, while Entertainment led in the UK.



### Ranking Creators by Engagement

SELECT channel_title, 
       SUM(likes + comment_count) AS engagement_score,
       RANK() OVER (ORDER BY SUM(likes + comment_count) DESC) AS rank_position
FROM youtube_trending
GROUP BY channel_title;

Insight: SpaceChannel ranked #1 due to high likes + comments, showing strong audience interaction.

## Key Takeaways

Viral videos = high like-to-view ratios, not just high views.
Technology is a global trending category.
Engagement (likes + comments) is a better measure of creator success.


##How to Run

1. Create a PostgreSQL DB youtube_project.
2. Import youtube_trending_mock.csv into table youtube_trending.
3. Run queries from youtube_trending_queries.sql.
