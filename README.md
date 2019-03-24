Demo for k-means clustering in SQL
----------------------------------

This demo creates some sample data points in a PostgreSQL table, and
then repeatedly runs queries to cluster these data points via the
k-means algorithm.


Requirements
------------

  - Python, psycopg2.
  - PostgreSQL with an empty database called `kmeans_demo`.


Run demo
--------

Run via, assuming the PostgreSQL connection works with default parameters:
```
python run.py
```

Cluster assignments from the latest iteration can be found in the
`kmeans_demo.clusters` table.
