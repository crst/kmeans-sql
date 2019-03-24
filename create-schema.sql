CREATE SCHEMA kmeans_demo;

-- Example data.
CREATE TABLE kmeans_demo.points (
  point_id INTEGER PRIMARY KEY,
  x1       FLOAT,
  x2       FLOAT
);

-- Generate 100 points for three different clusters.
INSERT INTO kmeans_demo.points
  SELECT
    n,
    (sqrt(-2 * ln(GREATEST(random(), 0.01))) * cos(2 * 3.14 * random()) * 5) + 10 AS x1,
    (sqrt(-2 * ln(GREATEST(random(), 0.01))) * cos(2 * 3.14 * random()) * 5) + 10 AS x2
  FROM generate_series(1, 100) n;

INSERT INTO kmeans_demo.points
  SELECT
    n,
    (sqrt(-2 * ln(GREATEST(random(), 0.01))) * cos(2 * 3.14 * random()) * 5) + 20 AS x1,
    (sqrt(-2 * ln(GREATEST(random(), 0.01))) * cos(2 * 3.14 * random()) * 5) + 20 AS x2
  FROM generate_series(101, 200) n;

INSERT INTO kmeans_demo.points
  SELECT
    n,
    (sqrt(-2 * ln(GREATEST(random(), 0.01))) * cos(2 * 3.14 * random()) * 5) + 30 AS x1,
    (sqrt(-2 * ln(GREATEST(random(), 0.01))) * cos(2 * 3.14 * random()) * 5) + 30 AS x2
  FROM generate_series(201, 300) n;


-- Maintain cluster centers for each iteration.
CREATE TABLE kmeans_demo.cluster_centers (
  iteration  INTEGER,
  cluster_id INTEGER,
  x1         FLOAT,
  x2         FLOAT,
  PRIMARY KEY (iteration, cluster_id)
);

-- But only keep current clusters.
CREATE TABLE kmeans_demo.clusters (
  point_id   INTEGER PRIMARY KEY,
  cluster_id INTEGER
);
