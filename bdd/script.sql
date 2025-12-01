-- 1) Utilisateurs
INSERT INTO utilisateur (username, email, password, bio, is_verified)
VALUES
  ('droskill',  'droskill@example.com',  'hash1', 'Streamer FR chill',        TRUE),
  ('lenigobrick','lego@example.com',     'hash2', 'Speedrun et lego',         FALSE),
  ('viewer1',   'viewer1@example.com',   'hash3', 'Juste un viewer',         FALSE),
  ('johnDOE','mod@example.com',        'hash4', 'Modérateur principal',    TRUE);

-- 2) Catégories
INSERT INTO categorie (name, description)
VALUES
  ('Just Chatting', 'Discussion avec la commu'),
  ('Gaming',        'Jeux vidéo en tout genre');

-- 3) Streams (droskill et lenigobrick)
INSERT INTO stream (title, categorie_id, is_live, started_at, user_id)
VALUES
  ('Live Chill du soir',  1, TRUE,  '2025-12-01 20:00:00', 1),  -- stream_id = 1
  ('Speedrun Lego 100%',  2, FALSE, '2025-11-30 18:00:00', 2);  -- stream_id = 2

-- 4) Followers (viewer1 suit les deux streamers)
INSERT INTO followers (follower_id, followed_user_id)
VALUES
  (3, 1),  -- viewer1 suit droskill
  (3, 2),  -- viewer1 suit lenigobrick
  (4, 1);

-- 5) Subscriptions (viewer1 sub à droskill)
INSERT INTO subscriptions (user_id, streamer_id, tier, subscribed_at, expire_at)
VALUES
  (3, 1, 1, '2025-12-01 21:00:00', '2026-01-01 21:00:00');

-- 6) Chat (viewer1 + droskill parlent dans le stream 1)
INSERT INTO chat (message, sent_at, stream_id, user_id)
VALUES
  ('Salut le chat !',      '2025-12-01 20:05:00', 1, 3),
  ('Bienvenue à tous !',   '2025-12-01 20:06:00', 1, 1);

-- 7) Points (points de chaine pour viewer1 chez les streamers)
INSERT INTO points (points_count, user_id, streamer_id)
VALUES
  (1500, 3, 1),   -- viewer1 a 1500 pts sur la chaîne de droskill
  (300,  3, 2);   -- viewer1 a 300 pts sur la chaîne de lenigobrick

-- 8) Rôles (moderator modère le stream de droskill)
INSERT INTO roles (name, permissions, user_id, streamer_id)
VALUES
  ('moderator', 2, 4, 1);   -- user 4 = moderator, sur chaîne de user 1

-- 9) Ban (exemple: viewer1 banni de la chaîne de lenigobrick)
INSERT INTO ban (reason, banned_at, expire_at, user_id, streamer_id)
VALUES
  ('Insultes dans le chat', '2025-12-01 21:30:00', '2025-12-02 21:30:00', 3, 2);


-- liste streamer avec leurs follow
/*SELECT u.username AS streamer, COUNT(f.follower_id) AS followers_count FROM utilisateur u
LEFT JOIN followers f ON f.followed_user_id = u.user_id
GROUP BY u.user_id;*/


-- liste des ban
/*SELECT u.username AS banned_user, s.username AS streamer, b.reason, b.banned_at FROM ban b
JOIN utilisateur u ON u.user_id = b.user_id
JOIN utilisateur s ON s.user_id = b.streamer_id
ORDER BY b.banned_at DESC;*/

-- qui est modo de qui ?
/*SELECT u.username AS moderator, s.username AS streamer, r.name AS role_name, r.permissions FROM roles r
JOIN utilisateur u ON u.user_id = r.user_id
JOIN utilisateur s ON s.user_id = r.streamer_id;*/

-- quel catégorie sont les lives en cour ?
/*SELECT st.title AS stream_title, u.username AS streamer, c.name AS category FROM stream st
JOIN utilisateur u ON u.user_id = st.user_id
JOIN categorie c ON c.categorie_id = st.categorie_id
WHERE st.is_live = TRUE;*/

-- liste user verif 
/*SELECT username FROM utilisateur
WHERE is_verified = TRUE;*/
