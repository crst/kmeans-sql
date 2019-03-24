WITH cluster_points AS (
  SELECT
    *
  FROM kmeans_demo.clusters c
  JOIN kmeans_demo.points p USING (point_id)
),
cluster_errors AS (
  SELECT
    cluster_id,
    sum((x.x1 - y.x1)^2 + (x.x2 - y.x2)^2) :: FLOAT / (2 * count(*)) AS error
  FROM cluster_points x
  JOIN cluster_points y USING (cluster_id)
  GROUP BY cluster_id
)
SELECT
  sum(error) AS error
FROM cluster_errors;
