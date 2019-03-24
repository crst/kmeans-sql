INSERT INTO kmeans_demo.cluster_centers
  SELECT
    i.last_iteration + 1 AS iteration,
    c.cluster_id,
    avg(p.x1) AS x1,
    avg(p.x2) AS x2
  FROM kmeans_demo.points p
  JOIN kmeans_demo.clusters c USING (point_id)
  CROSS JOIN (SELECT max(iteration) AS last_iteration FROM kmeans_demo.cluster_centers) i
  GROUP BY iteration, c.cluster_id;
