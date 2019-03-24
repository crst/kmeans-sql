INSERT INTO kmeans_demo.cluster_centers
  SELECT
    0 AS iteration,
    row_number() OVER (ORDER BY n ASC) AS cluster_id,
    x1,
    x2
  FROM (
    SELECT
      random() AS n,
      x1,
      x2
    FROM kmeans_demo.points
  ) t
  ORDER BY n ASC
  LIMIT 3;
