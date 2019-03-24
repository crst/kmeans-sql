import psycopg2

DEMO_DATABASE = 'kmeans_demo'
MAX_ITERATIONS = 100

query_keys = [
    'create-schema',
    'initialize-centers',
    'assign-clusters',
    'update-centers',
    'has-changes',
    'error',
    'monitor'
]
queries = {}
for key in query_keys:
    with open('%s.sql' % key, 'r') as f:
        queries[key] = f.read()


db = psycopg2.connect(database=DEMO_DATABASE)
cur = db.cursor()

cur.execute(queries['create-schema'])
cur.execute(queries['initialize-centers'])
db.commit()

def has_changes():
    cur.execute(queries['has-changes'])
    return cur.fetchall()[0][0] != False

def error():
    cur.execute(queries['error'])
    result = cur.fetchall()
    for r in result:
        print('  Error: %.2f' % r[0])

def monitor():
    cur.execute(queries['monitor'])
    result = cur.fetchall()
    for r in result:
        print('  Cluster %s: %3d nodes, avg distance to cluster center: %.2f\t' % (r[0], r[1], r[2]), end='')
    print()

iteration = 1
while has_changes() and iteration <= MAX_ITERATIONS:
    print('-------------------- Iteration %3d --------------------' % iteration)
    cur.execute(queries['assign-clusters'])
    cur.execute(queries['update-centers'])
    db.commit()
    error()
    monitor()
    iteration += 1

db.close()
