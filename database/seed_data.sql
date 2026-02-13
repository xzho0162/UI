-- ============================================================
-- ToySwap Seed Data
-- Sample data for development and testing
-- ============================================================

-- ============================================================
-- Categories (hierarchical)
-- ============================================================
INSERT INTO categories (id, name, description, icon, parent_id, sort_order) VALUES
(1, 'Board Games', 'Classic and modern board games', 'board_game', NULL, 1),
(2, 'Video Games', 'Console and PC video games', 'video_game', NULL, 2),
(3, 'Outdoor Toys', 'Toys for outdoor play', 'outdoor', NULL, 3),
(4, 'Educational Toys', 'Learning and STEM toys', 'education', NULL, 4),
(5, 'Plush Toys', 'Stuffed animals and plush figures', 'plush', NULL, 5),
(6, 'Building & Construction', 'LEGO, blocks and construction sets', 'building', NULL, 6),
(7, 'Action Figures', 'Action figures and collectibles', 'action_figure', NULL, 7),
(8, 'Dolls & Accessories', 'Dolls, dollhouses and accessories', 'doll', NULL, 8),
(9, 'Puzzles', 'Jigsaw puzzles and brain teasers', 'puzzle', NULL, 9),
(10, 'Arts & Crafts', 'Creative and art supplies', 'art', NULL, 10),
-- Sub-categories
(11, 'Strategy Games', 'Strategy board games', 'strategy', 1, 1),
(12, 'Family Games', 'Games for the whole family', 'family', 1, 2),
(13, 'Card Games', 'Card-based games', 'cards', 1, 3),
(14, 'Nintendo Switch', 'Nintendo Switch games', 'switch', 2, 1),
(15, 'PlayStation', 'PlayStation games', 'playstation', 2, 2),
(16, 'Bikes & Scooters', 'Bikes, scooters and ride-ons', 'bike', 3, 1),
(17, 'Ball Games', 'Footballs, basketballs etc.', 'ball', 3, 2),
(18, 'STEM Kits', 'Science and coding kits', 'stem', 4, 1),
(19, 'LEGO Sets', 'LEGO building sets', 'lego', 6, 1),
(20, 'Magnetic Tiles', 'Magnetic building tiles', 'magnet', 6, 2);

-- ============================================================
-- Users (based on personas from Sub1)
-- ============================================================
-- password_hash is bcrypt of 'password123' for all test users
INSERT INTO users (id, email, password_hash, username, first_name, last_name, avatar_url, phone, date_of_birth, gender, bio, location, postcode, trust_score, total_swaps, total_donations, is_email_verified, is_phone_verified, is_id_verified) VALUES
(1, 'maria.chen@email.com', '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'maria_chen', 'Maria', 'Chen', '/avatars/maria.jpg', '+61412345678', '1972-05-15', 'Female', 'Mother of two who loves finding good homes for outgrown toys. Passionate about reducing waste.', 'Melbourne', '3000', 4.50, 30, 15, TRUE, TRUE, TRUE),
(2, 'emily.zhang@email.com', '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'emily_zhang', 'Emily', 'Zhang', '/avatars/emily_z.jpg', '+61423456789', '1999-08-22', 'Female', 'Working professional who values efficiency. Love quick and easy swapping!', 'Sydney', '2000', 3.80, 8, 5, TRUE, TRUE, FALSE),
(3, 'emily.chen@email.com', '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'emily_chen', 'Emily', 'Chen', '/avatars/emily_c.jpg', '+61434567890', '2004-03-10', 'Female', 'Uni student on a budget. Looking to swap games and save money!', 'Melbourne', '3053', 3.20, 3, 1, TRUE, FALSE, FALSE),
(4, 'alex.joe@email.com', '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'alex_joe', 'Alex', 'Joe', '/avatars/alex.jpg', '+61445678901', '1994-11-28', 'Male', 'Digitally savvy donor. Happy to share toys that bring joy to others.', 'Brisbane', '4000', 4.20, 12, 20, TRUE, TRUE, TRUE),
(5, 'sarah.williams@email.com', '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'sarah_w', 'Sarah', 'Williams', '/avatars/sarah.jpg', '+61456789012', '1988-07-03', 'Female', 'Mum of three, always looking for great toy swaps for the kids.', 'Perth', '6000', 4.70, 45, 10, TRUE, TRUE, TRUE);

-- ============================================================
-- User Addresses
-- ============================================================
INSERT INTO user_addresses (user_id, label, address_line1, city, state, postcode, country, latitude, longitude, is_default) VALUES
(1, 'Home', '123 Collins St', 'Melbourne', 'VIC', '3000', 'Australia', -37.8136276, 144.9630576, TRUE),
(1, 'Local Park', 'Fitzroy Gardens', 'Melbourne', 'VIC', '3002', 'Australia', -37.8130, 144.9800, FALSE),
(2, 'Office', '456 George St', 'Sydney', 'NSW', '2000', 'Australia', -33.8688197, 151.2092955, TRUE),
(3, 'Uni', 'Monash University Clayton', 'Clayton', 'VIC', '3168', 'Australia', -37.9105, 145.1363, TRUE),
(4, 'Home', '789 Queen St', 'Brisbane', 'QLD', '4000', 'Australia', -27.4697707, 153.0251235, TRUE),
(5, 'Home', '321 Hay St', 'Perth', 'WA', '6000', 'Australia', -31.9505269, 115.8604572, TRUE);

-- ============================================================
-- User Verifications
-- ============================================================
INSERT INTO user_verifications (user_id, type, status, verified_at) VALUES
(1, 'email', 'verified', '2024-01-15 10:00:00'),
(1, 'phone', 'verified', '2024-01-15 10:05:00'),
(1, 'identity', 'verified', '2024-01-20 14:00:00'),
(2, 'email', 'verified', '2024-03-01 09:00:00'),
(2, 'phone', 'verified', '2024-03-01 09:10:00'),
(3, 'email', 'verified', '2024-06-10 16:00:00'),
(4, 'email', 'verified', '2024-02-05 11:00:00'),
(4, 'phone', 'verified', '2024-02-05 11:15:00'),
(4, 'identity', 'verified', '2024-02-10 13:00:00'),
(5, 'email', 'verified', '2024-01-10 08:00:00'),
(5, 'phone', 'verified', '2024-01-10 08:10:00'),
(5, 'identity', 'verified', '2024-01-12 10:00:00');

-- ============================================================
-- Items (toy/game listings)
-- ============================================================
INSERT INTO items (id, user_id, title, description, category_id, condition, age_range_min, age_range_max, type, price_estimate, exchange_preference, status, completion_pct, view_count, like_count) VALUES
(1, 1, 'Settlers of Catan', 'Complete board game, played a few times. All pieces included. Great family game!', 11, 'like_new', 10, 99, 'swap', 45.00, 'in_person', 'active', 100, 52, 8),
(2, 1, 'LEGO City Police Station 60316', 'Built once, then carefully disassembled. All bricks and instructions included.', 19, 'like_new', 6, 12, 'swap', 55.00, 'in_person', 'active', 100, 38, 12),
(3, 1, 'Plush Teddy Bear Collection (5 pieces)', 'Set of 5 stuffed bears in various sizes. Kids have outgrown them. Clean and in great shape.', 5, 'good', 0, 6, 'donate', NULL, 'both', 'active', 100, 25, 5),
(4, 2, 'Nintendo Switch - Mario Kart 8', 'Physical cartridge, case included. Finished playing it.', 14, 'good', 6, 99, 'swap', 40.00, 'both', 'active', 100, 67, 15),
(5, 2, 'Uno Card Game', 'Classic Uno set. Missing 1 blue card but otherwise complete.', 13, 'fair', 7, 99, 'donate', NULL, 'in_person', 'active', 100, 18, 3),
(6, 3, 'Codenames Board Game', 'Popular party game. Played many times but all cards in good condition.', 12, 'good', 14, 99, 'swap', 20.00, 'in_person', 'active', 100, 31, 7),
(7, 3, 'Chemistry STEM Kit', 'Educational chemistry set for kids. Some reagents used but most experiments still available.', 18, 'fair', 8, 14, 'swap', 25.00, 'both', 'active', 85, 14, 2),
(8, 4, 'Outdoor Cricket Set', 'Full backyard cricket set with bat, ball, stumps. Used one summer season.', 17, 'good', 6, 99, 'donate', NULL, 'in_person', 'active', 100, 42, 9),
(9, 4, 'Large Plush Dinosaur', 'Giant T-Rex plush toy, about 80cm tall. Child-safe materials.', 5, 'like_new', 3, 10, 'donate', NULL, 'both', 'active', 100, 29, 6),
(10, 5, 'Magnetic Tiles 100-piece Set', 'Complete magnetic building tiles set. Great for creative play and STEM learning.', 20, 'good', 3, 8, 'swap', 35.00, 'in_person', 'active', 100, 55, 14),
(11, 5, 'Puzzle Collection (3 x 1000 pieces)', 'Three 1000-piece jigsaw puzzles. Nature themes. All pieces verified complete.', 9, 'good', 12, 99, 'swap', 30.00, 'both', 'active', 100, 22, 4),
(12, 5, 'Kids Scooter - Blue', 'Adjustable height scooter for kids. Minor scratches on deck but fully functional.', 16, 'fair', 4, 10, 'swap', 20.00, 'in_person', 'active', 100, 48, 11),
(13, 1, 'Watercolor Paint Set', 'Professional-grade kids watercolor set with 24 colors. Barely used.', 10, 'like_new', 5, 99, 'donate', NULL, 'in_person', 'active', 70, 8, 1),
(14, 4, 'Action Figure Bundle - Marvel', '5 Marvel action figures (Spider-Man, Iron Man, Captain America, Thor, Hulk). Good condition.', 7, 'good', 4, 12, 'donate', NULL, 'both', 'active', 100, 35, 10),
(15, 2, 'Barbie Dreamhouse', 'Large Barbie dreamhouse with furniture. Some stickers applied. All doors/elevators work.', 8, 'good', 3, 10, 'swap', 60.00, 'in_person', 'active', 100, 73, 18);

-- ============================================================
-- Item Images
-- ============================================================
INSERT INTO item_images (item_id, image_url, is_primary, sort_order) VALUES
(1, '/images/items/catan_1.jpg', TRUE, 1),
(1, '/images/items/catan_2.jpg', FALSE, 2),
(2, '/images/items/lego_police_1.jpg', TRUE, 1),
(2, '/images/items/lego_police_2.jpg', FALSE, 2),
(2, '/images/items/lego_police_3.jpg', FALSE, 3),
(3, '/images/items/teddy_bears_1.jpg', TRUE, 1),
(4, '/images/items/mario_kart_1.jpg', TRUE, 1),
(5, '/images/items/uno_1.jpg', TRUE, 1),
(6, '/images/items/codenames_1.jpg', TRUE, 1),
(7, '/images/items/chemistry_kit_1.jpg', TRUE, 1),
(8, '/images/items/cricket_set_1.jpg', TRUE, 1),
(8, '/images/items/cricket_set_2.jpg', FALSE, 2),
(9, '/images/items/dino_plush_1.jpg', TRUE, 1),
(10, '/images/items/magnetic_tiles_1.jpg', TRUE, 1),
(10, '/images/items/magnetic_tiles_2.jpg', FALSE, 2),
(11, '/images/items/puzzles_1.jpg', TRUE, 1),
(12, '/images/items/scooter_1.jpg', TRUE, 1),
(12, '/images/items/scooter_2.jpg', FALSE, 2),
(13, '/images/items/watercolor_1.jpg', TRUE, 1),
(14, '/images/items/marvel_figures_1.jpg', TRUE, 1),
(14, '/images/items/marvel_figures_2.jpg', FALSE, 2),
(15, '/images/items/barbie_house_1.jpg', TRUE, 1),
(15, '/images/items/barbie_house_2.jpg', FALSE, 2),
(15, '/images/items/barbie_house_3.jpg', FALSE, 3);

-- ============================================================
-- Transactions
-- ============================================================
INSERT INTO transactions (id, type, item_id, from_user_id, to_user_id, offered_item_id, status, message, meeting_location, meeting_time, completed_at) VALUES
(1, 'swap', 1, 5, 1, 10, 'completed', 'Hi Maria! Would you like to swap your Catan for my magnetic tiles? My kids love board games!', 'Fitzroy Gardens, Melbourne', '2024-09-15 14:00:00', '2024-09-15 14:30:00'),
(2, 'donation', 3, 3, 1, NULL, 'completed', 'Hi, I would love the teddy bears for my little cousin!', 'Monash University Clayton', '2024-10-01 11:00:00', '2024-10-01 11:15:00'),
(3, 'swap', 4, 3, 2, 6, 'pending', 'Hey Emily! Want to swap Mario Kart for Codenames?', NULL, NULL, NULL),
(4, 'donation', 8, 5, 4, NULL, 'accepted', 'Would love to get this cricket set for the neighbourhood kids!', 'Brisbane CBD Park', '2025-02-20 10:00:00', NULL),
(5, 'donation', 9, 1, 4, NULL, 'completed', 'My kids would adore this dinosaur!', 'Fitzroy Gardens, Melbourne', '2024-11-10 15:00:00', '2024-11-10 15:20:00'),
(6, 'swap', 15, 1, 2, NULL, 'pending', 'Interested in the Barbie Dreamhouse for my daughter. What would you like in return?', NULL, NULL, NULL);

-- ============================================================
-- Reviews
-- ============================================================
INSERT INTO reviews (transaction_id, reviewer_id, reviewed_user_id, rating, comment) VALUES
(1, 5, 1, 5, 'Maria was wonderful! Items exactly as described, very friendly and punctual.'),
(1, 1, 5, 5, 'Sarah is fantastic to swap with. The magnetic tiles were in perfect condition!'),
(2, 1, 3, 4, 'Emily was polite and on time. Nice first swap!'),
(2, 3, 1, 5, 'Maria is so generous. The teddy bears were in great shape. Thank you!'),
(5, 4, 1, 5, 'Kids absolutely love the dinosaur! Maria is a great donor.');

-- ============================================================
-- Conversations & Messages
-- ============================================================
INSERT INTO conversations (id, item_id) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 8),
(5, 15);

INSERT INTO conversation_participants (conversation_id, user_id) VALUES
(1, 1), (1, 5),
(2, 1), (2, 3),
(3, 2), (3, 3),
(4, 4), (4, 5),
(5, 1), (5, 2);

INSERT INTO messages (conversation_id, sender_id, content, message_type, is_read) VALUES
(1, 5, 'Hi Maria! I saw your Catan game. Would you be interested in swapping for magnetic tiles?', 'text', TRUE),
(1, 1, 'Hi Sarah! Yes, that sounds great. My kids would love magnetic tiles!', 'text', TRUE),
(1, 5, 'Perfect! Shall we meet at Fitzroy Gardens this Saturday at 2pm?', 'text', TRUE),
(1, 1, 'Saturday 2pm works perfectly. See you there!', 'text', TRUE),
(2, 3, 'Hi Maria, are the teddy bears still available for donation?', 'text', TRUE),
(2, 1, 'Yes they are! Would you like to pick them up at Monash?', 'text', TRUE),
(2, 3, 'That would be great, thank you so much!', 'text', TRUE),
(3, 3, 'Hey Emily! Want to swap Mario Kart for my Codenames?', 'text', TRUE),
(3, 2, 'Hmm let me think about it! I do love party games...', 'text', FALSE),
(4, 5, 'Hi Alex, the cricket set looks perfect for the kids in our street!', 'text', TRUE),
(4, 4, 'Happy to donate it! When works for you to pick up?', 'text', TRUE),
(5, 1, 'Hi Emily, the Barbie Dreamhouse looks amazing! Is it still available?', 'text', TRUE),
(5, 2, 'Yes it is! What do you have to offer for a swap?', 'text', FALSE);

-- ============================================================
-- Likes (Favorites)
-- ============================================================
INSERT INTO likes (user_id, item_id) VALUES
(1, 10), (1, 15),
(2, 1), (2, 2), (2, 10),
(3, 4), (3, 15), (3, 9),
(4, 1), (4, 12),
(5, 2), (5, 6), (5, 14), (5, 15);

-- ============================================================
-- Notifications
-- ============================================================
INSERT INTO notifications (user_id, type, title, body, reference_type, reference_id, is_read) VALUES
(1, 'swap_request', 'New swap request', 'Emily wants to swap for your Barbie Dreamhouse', 'transaction', 6, FALSE),
(2, 'swap_request', 'New swap request', 'Emily Chen wants to swap Codenames for your Mario Kart', 'transaction', 3, FALSE),
(4, 'transaction_update', 'Donation accepted', 'Sarah accepted your donation request for the Cricket Set', 'transaction', 4, TRUE),
(1, 'review', 'New review received', 'Sarah left you a 5-star review!', 'review', 1, TRUE),
(5, 'review', 'New review received', 'Maria left you a 5-star review!', 'review', 2, TRUE),
(3, 'system', 'Complete your profile', 'Verify your phone number to increase your trust score', NULL, NULL, FALSE);

-- ============================================================
-- Notification Settings
-- ============================================================
INSERT INTO notification_settings (user_id, swap_requests_enabled, messages_enabled, reviews_enabled, transaction_updates_enabled, system_updates_enabled, marketing_enabled, email_notifications, push_notifications) VALUES
(1, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE),
(2, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE),
(3, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE),
(4, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE),  -- Alex prefers controlled notifications
(5, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);

-- ============================================================
-- Reports
-- ============================================================
INSERT INTO reports (reporter_id, reported_user_id, reported_item_id, reason, description, status) VALUES
(3, NULL, NULL, 'spam', 'Received suspicious message from a deleted account offering "free" electronics.', 'resolved');

-- ============================================================
-- Saved Searches
-- ============================================================
INSERT INTO saved_searches (user_id, name, query, category_id, condition_filter, type_filter, max_distance_km) VALUES
(1, 'LEGO for kids', 'LEGO', 6, NULL, 'swap', 20),
(3, 'Cheap board games', NULL, 1, NULL, 'swap', 10),
(5, 'Educational toys near me', NULL, 4, 'good', 'both', 15);
