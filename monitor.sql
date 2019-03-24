SELECT
  cc.cluster_id,
  count(*) AS num_points,
  avg(sqrt(((p.x1 - cc.x1)^2 * (p.x2 - cc.x2)^2))) AS avg_distance_to_center
FROM kmeans_demo.clusters c
JOIN kmeans_demo.points p USING (point_id)
JOIN kmeans_demo.cluster_centers cc USING (cluster_id)
WHERE cc.iteration = (SELECT max(iteration) FROM kmeans_demo.cluster_centers)
GROUP BY cc.cluster_id
ORDER BY cc.cluster_id;
