# DB Migrations for Postgres

Migration scripts have created to work with Postgres-compatible databases.
Scripts that have DDL must be in separate migrations from those that have DDL to be compatible with CockroachDB.
The migration process will not create a new database or user credentials, so those must be managed separately.

### Connecting

The connection string must have a `postgres://` prefix.
For development environments, or other cases where SSL is not used, the parameter string `sslmode=disable` is needed.
In <code>[config.json](../../config.json)</code>, set `db_name` to `postgres` and `db_path` to the connection string.
Example:

    postgres://my-user:1password@localhost:5432/gophish?sslmode=disable

You can see a complete list of parameter keywords in [the Postgres documentation](
https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

#### Docker

If you are using a `.env` file with Docker or Docker Compose, set `DB_TYPE` and `DB_FILE_PATH`.
Example:
```
DB_TYPE=postgres
DB_FILE_PATH=postgres://my-user:1password@my-cockroachdb:26257/gophish?serial_normalization=sql_sequence&sslmode=disable
```

### Compatibility

CockroachDB uses a rowid generator that will generate ID values that are too large to work properly with JavaScript numerical precision.
You must include `serial_normalization=sql_sequence` in your connection string when migrations are run.
This will ensure that generated IDs behave the way they do in traditional SQL databases.


### Testing

Migrations have been tested on the following databases:
* PostgreSQL 10.22
* PostgreSQL 15.2
* CockroachDB 22.1.3
