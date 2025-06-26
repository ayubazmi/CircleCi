-- Create the postgres user if it doesn't exist
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'postgres') THEN
        CREATE USER postgres WITH PASSWORD '123';
        ALTER USER postgres WITH SUPERUSER;
    END IF;
END
$$;

-- Create the database if it doesn't exist
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'to_do_list_development') THEN
        CREATE DATABASE to_do_list_development OWNER postgres;
    END IF;
END
$$;

