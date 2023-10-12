# paradedb-docker

A Dockerfile to get you started with PostgreSQL + pg_bm25 / pg_search (from ParadeDB) and pg_vector

# Author
Vangelis Tripolitakis

E: vtripolitakis@_NOSMPAM_gmail.com

W: [https://v.trp.gr](https://v.trp.gr)

## Components

- **Base OS**: Debian (Bookworm Slim)

- **Database**: PostgreSQL

- **Extensions**:
  - [pg_bm25](https://github.com/paradedb/paradedb) from [ParadeDB](https://www.paradedb.com/)
  - [pg_search](https://github.com/paradedb/paradedb) from [ParadeDB](https://www.paradedb.com/)
  - [pgvector](https://github.com/pgvector/pgvector)

## Getting Started

To run the Docker container using Docker Compose:

1. Ensure you have Docker and Docker Compose installed.
2. Navigate to the directory containing the `docker-compose.yml`:

```bash
cd /path/to/directory
```

3. Start the container:

```bash
docker compose up -d
```

To stop the container:

```bash
docker compose down
```

Entering the postgres:

```bash
psql -U postgres -h localhost
```

NOTE: default password for `postgres` is `postgres`

NOTE: PostgreSQL is running on `localhost:5432`

# License Information

pg_bm25 and pg_search are part of from [ParadeDB](https://www.paradedb.com/).
ParadeDB is licensed under the [GNU Affero General Public License v3.0](https://github.com/paradedb/paradedb/blob/dev/LICENSE).

pgvector: Licensing details can be found on [pgvector GitHub repository](https://github.com/pgvector/pgvector/blob/master/LICENSE).

Please ensure you understand and comply with the licensing terms of each component if you plan to use this Docker image in a commercial or public-facing environment.
