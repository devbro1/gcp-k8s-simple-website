ALTER USER postgres REPLICATION;
SELECT pg_create_physical_replication_slot('replication_slot');