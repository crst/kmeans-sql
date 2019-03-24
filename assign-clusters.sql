TRUNCATE kmeans_demo.clusters; -- Only keep current cluster assignments.

INSERT INTO kmeans_demo.clusters
  SELECT
    point_id,
    cluster_id
  FROM (
    SELECT
      p.point_id,
      c.cluster_id,
      row_number() OVER (PARTITION BY p.point_id ORDER BY sqrt(((p.x1 - c.x1)^2 * (p.x2 - c.x2)^2)) ASC) AS rank
    FROM kmeans_demo.points p
    CROSS JOIN kmeans_demo.cluster_centers c
    WHERE c.iteration = (SELECT max(iteration) FROM kmeans_demo.cluster_centers)
  ) rankings
  WHERE rank = 1
  ORDER BY point_id, cluster_id;
