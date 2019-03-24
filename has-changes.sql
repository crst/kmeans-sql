SELECT
  BOOL_OR(latest.x1 != previous.x1 OR latest.x2 != previous.x2) AS has_changes
FROM (
  SELECT cluster_id, x1, x2
  FROM kmeans_demo.cluster_centers
  WHERE iteration = (SELECT max(iteration) FROM kmeans_demo.cluster_centers)
) latest
JOIN (
  SELECT cluster_id, x1, x2
  FROM kmeans_demo.cluster_centers
  WHERE iteration = (SELECT max(iteration) - 1 FROM kmeans_demo.cluster_centers)
) previous USING (cluster_id);
