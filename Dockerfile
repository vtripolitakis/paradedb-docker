# Use the official Debian image as the base
FROM debian:bookworm-slim

# Environment variables for PostgreSQL
ENV POSTGRES_VERSION 15

# Update the base system and install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    gnupg \
    libpq-dev \
    libclang-dev \
    vim \
    postgresql-$POSTGRES_VERSION \
    postgresql-server-dev-$POSTGRES_VERSION \
    git \
    curl \
    libssl-dev \
    pkg-config

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- --default-toolchain 1.73.0 -y
RUN /root/.cargo/bin/cargo install cargo-pgrx --version 0.9.8

# Install pg_bm25 extension
RUN git clone https://github.com/paradedb/paradedb.git
RUN cd paradedb/pg_bm25 && /root/.cargo/bin/cargo pgrx init --pg$POSTGRES_VERSION=`which pg_config` && /root/.cargo/bin/cargo pgrx install

# Install pg_vector extension
RUN git clone --branch v0.5.1 https://github.com/pgvector/pgvector.git 
RUN cd pgvector && make && make install

# Install pg_search extension
RUN cd paradedb/pg_search && /root/.cargo/bin/cargo pgrx init --pg$POSTGRES_VERSION=`which pg_config` && /root/.cargo/bin/cargo pgrx install

# Change the password for postgres user
RUN service postgresql start && su postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'postgres';\""

# Configure PostgreSQL to listen on all interfaces and accept password login
RUN echo "listen_addresses='*'" >> /etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf
RUN echo "host all  all    0.0.0.0/0  scram-sha-256" >> /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf

# Expose PostgreSQL port
EXPOSE 5432

# Start PostgreSQL server on container run
CMD service postgresql start && tail -f /var/log/postgresql/postgresql-$POSTGRES_VERSION-main.log
