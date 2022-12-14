CREATE TABLE IF NOT EXISTS user_profile (
	id BIGSERIAL PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	email TEXT UNIQUE NOT NULL,
	gender TEXT CHECK(gender IN ('MALE', 'FEMALE')) NOT NULL,
	created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_account (
    id BIGINT PRIMARY KEY REFERENCES user_profile(id), -- one to one relation
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_channel (
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id), -- one to many (cause not unique)
    channel_name TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

-- bridge table
CREATE TABLE IF NOT EXISTS channel_subscriber (
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    youtube_channel_id BIGINT REFERENCES youtube_channel(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY (youtube_account_id, youtube_channel_id)
);

CREATE TABLE IF NOT EXISTS video (
    id BIGSERIAL PRIMARY KEY,
    youtube_channel_id BIGINT REFERENCES youtube_channel(id),
    uri TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_view (
    id BIGSERIAL PRIMARY KEY,
    video_id BIGINT REFERENCES video(id),
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_comment (
    id BIGSERIAL PRIMARY KEY,
    video_id BIGINT REFERENCES video(id),
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    body TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_like (
    video_id BIGINT REFERENCES video(id),
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY(video_id, youtube_account_id)
);

CREATE TABLE IF NOT EXISTS video_comment_like (
    video_comment_id BIGINT REFERENCES video_comment(id),
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY(video_comment_id, youtube_account_id)
);

-- INSERTS

-- user_profile
INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('Jamila', 'Ahmed', 'jahmed@gmail.com', 'FEMALE','2020-11-24 23:42:47.000000');
INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('Dmitry', 'Popov', 'popov@gmail.com', 'MALE', '2022-12-11 23:42:47.000000');
INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('Alex', 'Smith', 'alex@gmail.com', 'MALE', '2010-11-24 23:42:47.000000');
INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('James', 'Bond', 'bondoff@gmail.com', 'MALE', '2021-11-24 23:42:47.000000');

-- youtube_account
INSERT INTO youtube_account (id, created_at)
VALUES (1, '2021-11-24 23:42:47.000000');
INSERT INTO youtube_account (id, created_at)
VALUES (2, '2021-12-20 23:42:47.000000');
INSERT INTO youtube_account (id, created_at)
VALUES (3, '2020-11-24 23:42:47.000000');
INSERT INTO youtube_account (id, created_at)
VALUES (4, '2020-11-24 23:42:47.000000');

-- youtube_channel
INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (1, 'ahmed1', '2021-12-24 23:42:47.000000');
INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (1, 'ahmed2', '2021-12-26 23:42:47.000000');
INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (3, 'alexoff', '2022-12-26 23:42:47.000000');
INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (4, 'bond007', '2022-12-16 23:42:47.000000');

-- channel_subscriber
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (1, 1, '2021-12-24 23:42:47.000000');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (2, 1, '2021-12-24 23:42:47.000000');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (3, 2, '2021-12-24 23:42:47.000000');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (1, 4, '2021-12-24 23:42:47.000000');

-- video
INSERT INTO video (youtube_channel_id, uri, name, description, created_at)
VALUES (1, 'https://www.youtube.com/watch?v=fQ0sOPSYBTc&ab_channel=ahmed1','video1', 'description1', '2021-12-24 23:42:47.000000');
INSERT INTO video (youtube_channel_id, name, description, created_at)
VALUES (2, 'https://www.youtube.com/watch?v=fQ0sOPSYDVDVD_channel=ahmed2', 'video2', 'description2', '2021-12-24 23:42:47.000000');
INSERT INTO video (youtube_channel_id, name, description, created_at)
VALUES (1, 'https://www.youtube.com/watch?v=fQ0sOPSDFVSV_channel=ahmed1', 'video3', 'description3', '2021-12-24 23:42:47.000000');

-- video_view
INSERT INTO video_view (video_id, youtube_account_id, created_at)
VALUES (1, 1, '2021-12-24 23:42:47.000000');
INSERT INTO video_view (video_id, youtube_account_id, created_at)
VALUES (1, 1, '2021-12-24 23:43:47.000000');
INSERT INTO video_view (video_id, youtube_account_id, created_at)
VALUES (2, 1, '2021-12-24 23:42:47.000000');
INSERT INTO video_view (video_id, youtube_account_id, created_at)
VALUES (4, 1, '2021-12-24 23:42:47.000000'); -- не пройдет - нельзя посмотреть несуществуюшее видео
INSERT INTO video_view (video_id, youtube_account_id, created_at)
VALUES (2, 4, '2021-12-24 23:42:47.000000');

-- video_comment
INSERT INTO video_comment (video_id, youtube_account_id, body, created_at)
VALUES (1, 1, 'cool video', '2021-12-24 23:42:47.000000');
INSERT INTO video_comment (video_id, youtube_account_id, body, created_at)
VALUES (1, 2, 'cool video2', '2021-12-24 23:42:47.000000');
INSERT INTO video_comment (video_id, youtube_account_id, body, created_at)
VALUES (1, 1, 'cool video3', '2021-12-24 23:42:47.000000');
INSERT INTO video_comment (video_id, youtube_account_id, body, created_at)
VALUES (2, 4, 'cool video', '2021-12-24 23:42:47.000000');

-- video like
INSERT INTO video_like (video_id, youtube_account_id, created_at)
VALUES (1, 1, '2021-12-24 23:42:47.000000');
INSERT INTO video_like (video_id, youtube_account_id, created_at)
VALUES (1, 2, '2021-12-24 23:42:47.000000');
INSERT INTO video_like (video_id, youtube_account_id, created_at)
VALUES (1, 1, '2021-12-24 23:42:47.000000'); -- не пройдет потому что нельзя лайкнуть одно видео 2 раза

-- video_comment_like
INSERT INTO video_comment_like (video_comment_id, youtube_account_id, created_at)
VALUES (1, 1, '2021-12-24 23:42:47.000000');
INSERT INTO video_comment_like (video_comment_id, youtube_account_id, created_at)
VALUES (2, 1, '2021-12-24 23:42:47.000000');