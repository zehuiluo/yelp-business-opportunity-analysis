CREATE DATABASE yelp_project_db;
USE yelp_project_db;

-- ============================================================
-- 1. REGION DIMENSION
-- ============================================================
CREATE TABLE dim_region (
    region_key   INT PRIMARY KEY,
    region_name  VARCHAR(50) NOT NULL
);

-- ============================================================
-- 2. STATE DIMENSION
-- ============================================================
CREATE TABLE dim_state (
    state_key   INT PRIMARY KEY,
    state_code  VARCHAR(5) NOT NULL,
    state_name  VARCHAR(50) NOT NULL,
    region_key  INT NOT NULL,
    FOREIGN KEY (region_key) REFERENCES dim_region(region_key)
);

-- ============================================================
-- 3. CITY DIMENSION
-- ============================================================
CREATE TABLE dim_city (
    city_key   INT PRIMARY KEY,
    city_name  VARCHAR(100) NOT NULL,
    state_key  INT NOT NULL,
    FOREIGN KEY (state_key) REFERENCES dim_state(state_key)
);

-- ============================================================
-- 4. DIM CENSUS (CITY-LEVEL TOTAL POPULATION)
-- ============================================================
CREATE TABLE dim_census (
    census_key        INT PRIMARY KEY,
    city_key          INT NOT NULL,
    population_total  INT,
    FOREIGN KEY (city_key) REFERENCES dim_city(city_key)
);

-- ============================================================
-- 5. DATE DIMENSION
-- ============================================================
CREATE TABLE dim_date (
    date_key    INT PRIMARY KEY,      -- YYYYMMDD
    full_date   DATE NOT NULL,
    year        INT NOT NULL,
    month       INT NOT NULL,
    day         INT NOT NULL,
    weekday     VARCHAR(20) NOT NULL,
    is_weekend  BOOLEAN NOT NULL,
    week_number INT NOT NULL,
    quarter     INT NOT NULL
);

-- ============================================================
-- 6. USER DIMENSION
-- ============================================================
CREATE TABLE dim_user (
    user_id        VARCHAR(50) PRIMARY KEY,
    user_name           VARCHAR(200),
    review_count   INT,
    average_stars  FLOAT,
    fans           INT,
    useful         INT,
    funny          INT,
    cool           INT,
    yelping_since  DATE,
    elite_duration INT
);

-- ============================================================
-- 7. CATEGORY DIMENSION
-- ============================================================
CREATE TABLE dim_category (
    category_key   INT PRIMARY KEY,
    category_name  VARCHAR(100) NOT NULL
);

-- ============================================================
-- 8. RESTAURANT DIMENSION (UPDATED)
--    - removed state_key
--    - added city_key
-- ============================================================
CREATE TABLE dim_restaurant (
    business_id   VARCHAR(50) PRIMARY KEY,
    restaurant_name          VARCHAR(200),
    address       VARCHAR(200),
    postal_code   VARCHAR(20),
    latitude      FLOAT,
    longitude     FLOAT,
    city_key      INT NOT NULL,
    rating        FLOAT,
    review_count  INT,
    FOREIGN KEY (city_key) REFERENCES dim_city(city_key)
);

-- ============================================================
-- 9. BRIDGE TABLE (restaurant ↔ category)
-- ============================================================
CREATE TABLE bridge_restaurant_category (
    business_id   VARCHAR(50) NOT NULL,
    category_key  INT NOT NULL,
    PRIMARY KEY (business_id, category_key),
    FOREIGN KEY (business_id) REFERENCES dim_restaurant(business_id),
    FOREIGN KEY (category_key) REFERENCES dim_category(category_key)
);

-- ============================================================
-- 10. FACT REVIEW
-- ============================================================
CREATE TABLE fact_review (
    review_key   INT AUTO_INCREMENT PRIMARY KEY,
    review_id    VARCHAR(50) NOT NULL,
    business_id  VARCHAR(50) NOT NULL,
    user_id      VARCHAR(50) NOT NULL,
    date_key     INT NOT NULL,
    stars        FLOAT NOT NULL,
    useful       INT NOT NULL,
    funny        INT NOT NULL,
    cool         INT NOT NULL,
    text_length  INT NOT NULL,

    FOREIGN KEY (business_id) REFERENCES dim_restaurant(business_id),
    FOREIGN KEY (user_id)     REFERENCES dim_user(user_id),
    FOREIGN KEY (date_key)    REFERENCES dim_date(date_key)
);