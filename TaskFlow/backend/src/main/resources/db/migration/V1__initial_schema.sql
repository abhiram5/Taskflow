-- Users: identity only. Profile data and auth credentials both live here for now;
-- we split credentials out only if we add OAuth providers later.
CREATE TABLE users (
    id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
    email           text        NOT NULL,
    password_hash   text        NOT NULL,
    display_name    text        NOT NULL,
    is_active       boolean     NOT NULL DEFAULT true,
    created_at      timestamptz NOT NULL DEFAULT now(),
    updated_at      timestamptz NOT NULL DEFAULT now(),

    CONSTRAINT users_email_not_blank CHECK (length(trim(email)) > 0)
);

-- Case-insensitive uniqueness. A plain UNIQUE(email) would let
-- 'Abhi@x.com' and 'abhi@x.com' both exist.
CREATE UNIQUE INDEX users_email_lower_key ON users (lower(email));

CREATE TABLE teams (
    id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
    name           text        NOT NULL,
    slug           text        NOT NULL UNIQUE,
    created_by     uuid        REFERENCES users(id) ON DELETE SET NULL,
    created_at     timestamptz NOT NULL DEFAULT now(),
    updated_at     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT teams_name_not_blank CHECK (length(trim(name)) > 0)
);


CREATE TABLE team_members (
    team_id        uuid        REFERENCES teams(id) ON DELETE CASCADE,
    user_id        uuid        REFERENCES users(id) ON DELETE CASCADE,
    role           text        NOT NULL CHECK (role IN ('OWNER','ADMIN','MEMBER','VIEWER')),
    joined_at      timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (team_id, user_id)
);

CREATE INDEX team_members_user_id_idx ON team_members (user_id);

