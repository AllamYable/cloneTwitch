CREATE TABLE IF NOT EXISTS utilisateur (
    user_id      INT AUTO_INCREMENT PRIMARY KEY,
    username     VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    password     VARCHAR(255) NOT NULL,
    bio          VARCHAR(250),
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_verified  BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE KEY uq_username (username),
    UNIQUE KEY uq_email (email)
);

CREATE TABLE IF NOT EXISTS categorie (
    categorie_id INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    description  TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS stream (
    stream_id    INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(150) NOT NULL,
    categorie_id INT NOT NULL,
    is_live      BOOLEAN NOT NULL DEFAULT FALSE,
    started_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ended_at     DATETIME,
    user_id      INT NOT NULL,
    CONSTRAINT fk_stream_user
        FOREIGN KEY (user_id) REFERENCES utilisateur(user_id),
    CONSTRAINT fk_stream_categorie
        FOREIGN KEY (categorie_id) REFERENCES categorie(categorie_id)
);

CREATE TABLE IF NOT EXISTS ban (
    ban_id      INT AUTO_INCREMENT PRIMARY KEY,
    reason      VARCHAR(255) NOT NULL,
    banned_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expire_at   DATETIME,
    user_id     INT NOT NULL,
    streamer_id INT NOT NULL,
    CONSTRAINT fk_ban_user
        FOREIGN KEY (user_id) REFERENCES utilisateur(user_id),
    CONSTRAINT fk_ban_streamer
        FOREIGN KEY (streamer_id) REFERENCES utilisateur(user_id)
);

CREATE TABLE IF NOT EXISTS followers (
    follow_id          INT AUTO_INCREMENT PRIMARY KEY,
    follower_id        INT NOT NULL,
    followed_user_id   INT NOT NULL,
    CONSTRAINT fk_follow_follower
        FOREIGN KEY (follower_id)      REFERENCES utilisateur(user_id),
    CONSTRAINT fk_follow_followed
        FOREIGN KEY (followed_user_id) REFERENCES utilisateur(user_id),
    CONSTRAINT uq_follow UNIQUE (follower_id, followed_user_id)
);

CREATE TABLE IF NOT EXISTS chat (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    message    VARCHAR(255) NOT NULL,
    sent_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    stream_id  INT NOT NULL,
    user_id    INT NOT NULL,
    CONSTRAINT fk_chat_stream
        FOREIGN KEY (stream_id) REFERENCES stream(stream_id),
    CONSTRAINT fk_chat_user
        FOREIGN KEY (user_id)  REFERENCES utilisateur(user_id)
);

CREATE TABLE IF NOT EXISTS points (
    points_id    INT AUTO_INCREMENT PRIMARY KEY,
    points_count INT NOT NULL,
    user_id      INT NOT NULL,
    streamer_id  INT NOT NULL,
    CONSTRAINT fk_points_user
        FOREIGN KEY (user_id) REFERENCES utilisateur(user_id),
    CONSTRAINT fk_points_streamer
        FOREIGN KEY (streamer_id) REFERENCES utilisateur(user_id),
    CONSTRAINT uq_points UNIQUE (user_id, streamer_id)
);

CREATE TABLE IF NOT EXISTS subscriptions (
    sub_id       INT AUTO_INCREMENT PRIMARY KEY,
    tier         INT NOT NULL,
    subscribed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expire_at     DATETIME,
    user_id       INT NOT NULL,
    streamer_id   INT NOT NULL,
    CONSTRAINT fk_sub_user
        FOREIGN KEY (user_id)     REFERENCES utilisateur(user_id),
    CONSTRAINT fk_sub_streamer
        FOREIGN KEY (streamer_id) REFERENCES utilisateur(user_id),
    CONSTRAINT uq_sub UNIQUE (user_id, streamer_id, tier)
);

CREATE TABLE IF NOT EXISTS roles (
    role_id     INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    permissions INT NOT NULL,
    user_id     INT NOT NULL,
    streamer_id INT NOT NULL,
    CONSTRAINT fk_role_user
        FOREIGN KEY (user_id)     REFERENCES utilisateur(user_id),
    CONSTRAINT fk_role_streamer
        FOREIGN KEY (streamer_id) REFERENCES utilisateur(user_id)
);
