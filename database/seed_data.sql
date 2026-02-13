-- ============================================================
-- ToySwap Seed Data (v2)
-- Updated with Sub3 high-fidelity prototype features
-- ============================================================

-- ============================================================
-- Categories - matching Sub3 Category Screen exactly
-- Main grid: Plush & Soft Toys, Baby Toys, Toy Vehicles & Playsets,
-- LEGO, Outdoor Toys & Play Equipment, Gaming, Toddler & Pre-School Toys,
-- Board Games & Puzzles, Dolls & Playsets, Children's Books,
-- Action Figures & Playsets
-- Also: Home feed shows GAME, BOOK tags
-- ============================================================
INSERT INTO categories (id, name, description, icon, parent_id, sort_order) VALUES
-- Main categories from Sub3 Category Screen grid
(1,  'Plush & Soft Toys',              'Stuffed animals, plush figures and soft toys',              'plush',          NULL, 1),
(2,  'Baby Toys',                       'Toys suitable for babies and infants',                      'baby',           NULL, 2),
(3,  'Toy Vehicles & Playsets',         'Cars, trucks, trains and vehicle playsets',                  'vehicle',        NULL, 3),
(4,  'LEGO',                            'LEGO building sets and accessories',                         'lego',           NULL, 4),
(5,  'Outdoor Toys & Play Equipment',   'Bikes, scooters, balls and outdoor play gear',              'outdoor',        NULL, 5),
(6,  'Gaming',                          'Video games, consoles and gaming accessories',              'gaming',         NULL, 6),
(7,  'Toddler & Pre-School Toys',       'Toys designed for toddlers and pre-schoolers',              'toddler',        NULL, 7),
(8,  'Board Games & Puzzles',           'Board games, card games, jigsaw puzzles and brain teasers', 'board_game',     NULL, 8),
(9,  'Dolls & Playsets',                'Dolls, dollhouses and doll accessories',                    'doll',           NULL, 9),
(10, 'Children''s Books',               'Picture books, chapter books and educational books',        'book',           NULL, 10),
(11, 'Action Figures & Playsets',        'Action figures, collectible figures and playsets',          'action_figure',  NULL, 11),
(12, 'Arts & Crafts',                   'Creative supplies, paint sets and craft kits',              'art',            NULL, 12),
-- Sub-categories
(13, 'Strategy Games',      'Strategy board games',          'strategy',    8, 1),
(14, 'Family Games',        'Games for the whole family',    'family',      8, 2),
(15, 'Card Games',          'Card-based games',              'cards',       8, 3),
(16, 'Jigsaw Puzzles',      'Jigsaw puzzles of all sizes',  'puzzle',      8, 4),
(17, 'Nintendo Switch',     'Nintendo Switch games',         'switch',      6, 1),
(18, 'PlayStation',         'PlayStation games',             'playstation', 6, 2),
(19, 'Xbox',                'Xbox games',                    'xbox',        6, 3),
(20, 'Bikes & Scooters',    'Bikes, scooters and ride-ons',  'bike',       5, 1),
(21, 'Ball Games',          'Footballs, basketballs etc.',   'ball',        5, 2),
(22, 'STEM & Educational Kits', 'Science and coding kits',  'stem',        7, 1),
(23, 'LEGO City',           'LEGO City sets',                'lego_city',   4, 1),
(24, 'LEGO Technic',        'LEGO Technic sets',             'lego_technic', 4, 2),
(25, 'Magnetic Tiles',      'Magnetic building tiles',       'magnet',      7, 2);

-- ============================================================
-- Tags (Sub3: Tags dropdown with Suggested tags)
-- ============================================================
INSERT INTO tags (id, name, usage_count) VALUES
(1, 'like-new', 45),
(2, 'free-shipping', 30),
(3, 'popular', 28),
(4, 'educational', 22),
(5, 'outdoor', 18),
(6, 'indoor', 25),
(7, 'ages-3-5', 15),
(8, 'ages-6-8', 20),
(9, 'ages-9-12', 17),
(10, 'collectible', 12),
(11, 'bulk-lot', 8),
(12, 'vintage', 6),
(13, 'stem', 19),
(14, 'creative', 14),
(15, 'family-friendly', 23);

-- ============================================================
-- Users (based on personas from Sub1, updated with Sub3 fields)
-- Sub3 Profile: Lv.5, Verified, Followers/Following, Credit
-- ============================================================
INSERT INTO users (id, email, password_hash, username, first_name, last_name, avatar_url, phone, date_of_birth, gender, bio, location, postcode, level, credit_balance, trust_score, total_swaps, total_donations, follower_count, following_count, is_email_verified, is_phone_verified, is_id_verified) VALUES
(1, 'maria.chen@email.com',     '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'maria_chen',  'Maria',  'Chen',     '/avatars/maria.jpg',   '+61412345678', '1972-05-15', 'Female', 'Mother of two who loves finding good homes for outgrown toys. Passionate about reducing waste.', 'Melbourne', '3000', 5, 250.00, 4.50, 30, 15, 128, 45, TRUE, TRUE, TRUE),
(2, 'emily.zhang@email.com',    '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'emily_zhang', 'Emily',  'Zhang',    '/avatars/emily_z.jpg', '+61423456789', '1999-08-22', 'Female', 'Working professional who values efficiency. Love quick and easy swapping!', 'Sydney', '2000', 3, 80.00, 3.80, 8, 5, 42, 30, TRUE, TRUE, FALSE),
(3, 'emily.chen@email.com',     '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'emily_chen',  'Emily',  'Chen',     '/avatars/emily_c.jpg', '+61434567890', '2004-03-10', 'Female', 'Uni student on a budget. Looking to swap games and save money!', 'Melbourne', '3053', 2, 30.00, 3.20, 3, 1, 15, 22, TRUE, FALSE, FALSE),
(4, 'alex.joe@email.com',       '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'alex_joe',    'Alex',   'Joe',      '/avatars/alex.jpg',    '+61445678901', '1994-11-28', 'Male',   'Digitally savvy donor. Happy to share toys that bring joy to others.', 'Brisbane', '4000', 4, 180.00, 4.20, 12, 20, 95, 38, TRUE, TRUE, TRUE),
(5, 'sarah.williams@email.com', '$2b$12$LJ3m4ys3Lz0QOPNnqEPKxOQzHQyE1Uj4YJHXZ8gF8nKpZwXmVhSe', 'sarah_w',     'Sarah',  'Williams', '/avatars/sarah.jpg',   '+61456789012', '1988-07-03', 'Female', 'Mum of three, always looking for great toy swaps for the kids.', 'Perth', '6000', 5, 320.00, 4.70, 45, 10, 210, 55, TRUE, TRUE, TRUE);

-- ============================================================
-- User Addresses
-- ============================================================
INSERT INTO user_addresses (user_id, label, address_line1, city, state, postcode, country, latitude, longitude, is_default) VALUES
(1, 'Home',       '123 Collins St',           'Melbourne', 'VIC', '3000', 'Australia', -37.8136276, 144.9630576, TRUE),
(1, 'Local Park', 'Fitzroy Gardens',          'Melbourne', 'VIC', '3002', 'Australia', -37.8130, 144.9800, FALSE),
(2, 'Office',     '456 George St',            'Sydney',    'NSW', '2000', 'Australia', -33.8688197, 151.2092955, TRUE),
(3, 'Uni',        'Monash University Clayton', 'Clayton',   'VIC', '3168', 'Australia', -37.9105, 145.1363, TRUE),
(4, 'Home',       '789 Queen St',             'Brisbane',  'QLD', '4000', 'Australia', -27.4697707, 153.0251235, TRUE),
(5, 'Home',       '321 Hay St',               'Perth',     'WA',  '6000', 'Australia', -31.9505269, 115.8604572, TRUE);

-- ============================================================
-- User Verifications (Sub3: Verified badge on profile)
-- ============================================================
INSERT INTO user_verifications (user_id, type, status, verified_at) VALUES
(1, 'email',    'verified', '2024-01-15 10:00:00'),
(1, 'phone',    'verified', '2024-01-15 10:05:00'),
(1, 'identity', 'verified', '2024-01-20 14:00:00'),
(2, 'email',    'verified', '2024-03-01 09:00:00'),
(2, 'phone',    'verified', '2024-03-01 09:10:00'),
(3, 'email',    'verified', '2024-06-10 16:00:00'),
(4, 'email',    'verified', '2024-02-05 11:00:00'),
(4, 'phone',    'verified', '2024-02-05 11:15:00'),
(4, 'identity', 'verified', '2024-02-10 13:00:00'),
(5, 'email',    'verified', '2024-01-10 08:00:00'),
(5, 'phone',    'verified', '2024-01-10 08:10:00'),
(5, 'identity', 'verified', '2024-01-12 10:00:00');

-- ============================================================
-- User Follows (Sub3: Followers/Following on Profile)
-- ============================================================
INSERT INTO user_follows (follower_id, following_id) VALUES
(1, 4), (1, 5),
(2, 1), (2, 5),
(3, 1), (3, 2), (3, 4),
(4, 1), (4, 5),
(5, 1), (5, 2), (5, 4);

-- ============================================================
-- Items (updated condition/preference values per Sub3)
-- Sub3 conditions: brand_new, like_new, good, used, needs_repair
-- Sub3 preferences: pickup, dropoff, both
-- Sub3 Post Detail: location, comment_count, bookmark_count
-- ============================================================
INSERT INTO items (id, user_id, title, description, category_id, condition, age_range_min, age_range_max, type, price_estimate, exchange_preference, location, status, completion_pct, view_count, like_count, bookmark_count, comment_count) VALUES
(1,  1, 'Settlers of Catan',                    'Complete board game, played a few times. All pieces included. Great family game!',                    13, 'like_new',    10, 99, 'swap',   45.00, 'pickup',  'Melbourne CBD',    'active', 100, 52,  8,  3, 5),
(2,  1, 'LEGO City Police Station 60316',        'Built once, then carefully disassembled. All bricks and instructions included.',                      23, 'like_new',    6,  12, 'swap',   55.00, 'pickup',  'Melbourne CBD',    'active', 100, 38,  12, 4, 3),
(3,  1, 'Plush Teddy Bear Collection (5 pieces)', 'Set of 5 stuffed bears in various sizes. Kids have outgrown them. Clean and in great shape.',       1,  'good',        0,  6,  'donate', NULL,  'both',    'Fitzroy, Melbourne', 'active', 100, 25, 5,  2, 2),
(4,  2, 'Nintendo Switch - Mario Kart 8',         'Physical cartridge, case included. Finished playing it.',                                            17, 'good',        6,  99, 'swap',   40.00, 'both',    'Sydney CBD',       'active', 100, 67,  15, 6, 8),
(5,  2, 'Uno Card Game',                          'Classic Uno set. Missing 1 blue card but otherwise complete.',                                       15, 'used',        7,  99, 'donate', NULL,  'pickup',  'Sydney CBD',       'active', 100, 18,  3,  1, 1),
(6,  3, 'Codenames Board Game',                   'Popular party game. Played many times but all cards in good condition.',                              14, 'good',        14, 99, 'swap',   20.00, 'pickup',  'Clayton, Melbourne', 'active', 100, 31, 7,  3, 4),
(7,  3, 'Chemistry STEM Kit',                     'Educational chemistry set for kids. Some reagents used but most experiments still available.',        22, 'used',        8,  14, 'swap',   25.00, 'both',    'Clayton, Melbourne', 'active', 85,  14, 2,  1, 0),
(8,  4, 'Outdoor Cricket Set',                    'Full backyard cricket set with bat, ball, stumps. Used one summer season.',                           21, 'good',        6,  99, 'donate', NULL,  'pickup',  'Brisbane CBD',     'active', 100, 42,  9,  4, 6),
(9,  4, 'Large Plush Dinosaur',                   'Giant T-Rex plush toy, about 80cm tall. Child-safe materials.',                                      1,  'like_new',    3,  10, 'donate', NULL,  'both',    'Brisbane',         'active', 100, 29,  6,  2, 3),
(10, 5, 'Magnetic Tiles 100-piece Set',           'Complete magnetic building tiles set. Great for creative play and STEM learning.',                    25, 'good',        3,  8,  'swap',   35.00, 'pickup',  'Perth CBD',        'active', 100, 55,  14, 5, 7),
(11, 5, 'Puzzle Collection (3 x 1000 pieces)',    'Three 1000-piece jigsaw puzzles. Nature themes. All pieces verified complete.',                       16, 'good',        12, 99, 'swap',   30.00, 'both',    'Perth',            'active', 100, 22,  4,  2, 2),
(12, 5, 'Kids Scooter - Blue',                    'Adjustable height scooter for kids. Minor scratches on deck but fully functional.',                   20, 'used',        4,  10, 'swap',   20.00, 'pickup',  'Perth',            'active', 100, 48,  11, 3, 5),
(13, 1, 'Watercolor Paint Set',                   'Professional-grade kids watercolor set with 24 colors. Barely used.',                                12, 'like_new',    5,  99, 'donate', NULL,  'pickup',  'Melbourne',        'active', 70,  8,   1,  0, 0),
(14, 4, 'Action Figure Bundle - Marvel',           '5 Marvel action figures (Spider-Man, Iron Man, Captain America, Thor, Hulk). Good condition.',       11, 'good',        4,  12, 'donate', NULL,  'both',    'Brisbane',         'active', 100, 35,  10, 4, 3),
(15, 2, 'Barbie Dreamhouse',                      'Large Barbie dreamhouse with furniture. Some stickers applied. All doors/elevators work.',            9,  'good',        3,  10, 'swap',   60.00, 'pickup',  'Sydney',           'active', 100, 73,  18, 7, 12),
(16, 1, 'The Very Hungry Caterpillar + 3 Books',   'Classic children''s book bundle. 4 picture books in great reading condition.',                       10, 'good',        2,  6,  'donate', NULL,  'both',    'Melbourne',        'active', 100, 15,  4,  2, 1),
(17, 4, 'Baby Stacking Rings',                     'Fisher-Price Rock-a-Stack. Classic baby toy, all rings included. Sanitized.',                        2,  'good',        0,  2,  'donate', NULL,  'dropoff', 'Brisbane',         'active', 100, 12,  3,  1, 0),
(18, 5, 'Hot Wheels Track Builder Set',             'Mega track set with loops, launcher and 5 cars included. Box slightly damaged.',                    3,  'used',        4,  10, 'swap',   25.00, 'pickup',  'Perth',            'active', 100, 33,  8,  3, 4);

-- ============================================================
-- Item Tags (Sub3: Tags on items)
-- ============================================================
INSERT INTO item_tags (item_id, tag_id) VALUES
(1, 15), (1, 6),           -- Catan: family-friendly, indoor
(2, 1), (2, 8),            -- LEGO: like-new, ages-6-8
(3, 11),                   -- Teddy bears: bulk-lot
(4, 3), (4, 8),            -- Mario Kart: popular, ages-6-8
(6, 15), (6, 3),           -- Codenames: family-friendly, popular
(7, 13), (7, 4),           -- STEM Kit: stem, educational
(8, 5),                    -- Cricket: outdoor
(10, 4), (10, 13),         -- Magnetic tiles: educational, stem
(12, 5), (12, 7),          -- Scooter: outdoor, ages-3-5
(14, 3), (14, 10),         -- Marvel: popular, collectible
(15, 3),                   -- Barbie: popular
(16, 4), (16, 7),          -- Books: educational, ages-3-5
(18, 5), (18, 8);          -- Hot Wheels: outdoor, ages-6-8

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
(15, '/images/items/barbie_house_3.jpg', FALSE, 3),
(16, '/images/items/books_1.jpg', TRUE, 1),
(17, '/images/items/baby_rings_1.jpg', TRUE, 1),
(18, '/images/items/hotwheels_1.jpg', TRUE, 1),
(18, '/images/items/hotwheels_2.jpg', FALSE, 2);

-- ============================================================
-- Credit Transactions (Sub3 Profile: Credit tab)
-- ============================================================
INSERT INTO credit_transactions (user_id, amount, type, description, reference_type, reference_id) VALUES
(1,  10.00, 'signup_bonus',    'Welcome bonus for joining ToySwap',      NULL, NULL),
(1,  20.00, 'swap_completed',  'Completed swap: Settlers of Catan',      'transaction', 1),
(1,  15.00, 'donation_made',   'Donated: Plush Teddy Bear Collection',   'transaction', 2),
(1,   5.00, 'review_given',    'Left a review for Sarah',                'review', 2),
(2,  10.00, 'signup_bonus',    'Welcome bonus for joining ToySwap',      NULL, NULL),
(3,  10.00, 'signup_bonus',    'Welcome bonus for joining ToySwap',      NULL, NULL),
(4,  10.00, 'signup_bonus',    'Welcome bonus for joining ToySwap',      NULL, NULL),
(4,  15.00, 'donation_made',   'Donated: Large Plush Dinosaur',          'transaction', 5),
(5,  10.00, 'signup_bonus',    'Welcome bonus for joining ToySwap',      NULL, NULL),
(5,  20.00, 'swap_completed',  'Completed swap: Magnetic Tiles',         'transaction', 1),
(5,   5.00, 'review_given',    'Left a review for Maria',                'review', 1);

-- ============================================================
-- Transactions
-- ============================================================
INSERT INTO transactions (id, type, item_id, from_user_id, to_user_id, offered_item_id, status, message, meeting_location, meeting_time, completed_at) VALUES
(1, 'swap',     1, 5, 1, 10, 'completed', 'Hi Maria! Would you like to swap your Catan for my magnetic tiles? My kids love board games!', 'Fitzroy Gardens, Melbourne', '2024-09-15 14:00:00', '2024-09-15 14:30:00'),
(2, 'donation', 3, 3, 1, NULL, 'completed', 'Hi, I would love the teddy bears for my little cousin!', 'Monash University Clayton', '2024-10-01 11:00:00', '2024-10-01 11:15:00'),
(3, 'swap',     4, 3, 2, 6, 'pending', 'Hey Emily! Want to swap Mario Kart for Codenames?', NULL, NULL, NULL),
(4, 'donation', 8, 5, 4, NULL, 'accepted', 'Would love to get this cricket set for the neighbourhood kids!', 'Brisbane CBD Park', '2025-02-20 10:00:00', NULL),
(5, 'donation', 9, 1, 4, NULL, 'completed', 'My kids would adore this dinosaur!', 'Fitzroy Gardens, Melbourne', '2024-11-10 15:00:00', '2024-11-10 15:20:00'),
(6, 'swap',     15, 1, 2, NULL, 'pending', 'Interested in the Barbie Dreamhouse for my daughter. What would you like in return?', NULL, NULL, NULL);

-- ============================================================
-- Parcels (Sub3 Profile: Parcels tab)
-- ============================================================
INSERT INTO parcels (transaction_id, sender_id, receiver_id, tracking_number, carrier, status, estimated_delivery, shipped_at, delivered_at) VALUES
(1, 5, 1, NULL, NULL, 'delivered', NULL, NULL, '2024-09-15 14:30:00'),  -- in-person, instant
(2, 1, 3, NULL, NULL, 'delivered', NULL, NULL, '2024-10-01 11:15:00'),  -- in-person, instant
(4, 4, 5, 'AP1234567890', 'auspost', 'in_transit', '2025-02-22', '2025-02-18 09:00:00', NULL),
(5, 4, 1, NULL, NULL, 'delivered', NULL, NULL, '2024-11-10 15:20:00');  -- in-person

-- ============================================================
-- Reviews (Sub3 Profile: tabs - recommend, exchange, donate)
-- Shows: reviewer name, type, category, time, stars, comment, heart
-- ============================================================
INSERT INTO reviews (transaction_id, reviewer_id, reviewed_user_id, rating, review_type, category, comment, like_count) VALUES
(1, 5, 1, 5, 'exchange',  'Board Games & Puzzles',  'Maria was wonderful! Items exactly as described, very friendly and punctual.', 3),
(1, 1, 5, 5, 'exchange',  'Board Games & Puzzles',  'Sarah is fantastic to swap with. The magnetic tiles were in perfect condition!', 2),
(2, 1, 3, 4, 'donate',    'Plush & Soft Toys',      'Emily was polite and on time. Nice first swap!', 1),
(2, 3, 1, 5, 'recommend', 'Plush & Soft Toys',      'Maria is so generous. The teddy bears were in great shape. Thank you!', 4),
(5, 4, 1, 5, 'donate',    'Plush & Soft Toys',      'Kids absolutely love the dinosaur! Maria is a great donor.', 2);

-- ============================================================
-- Review Likes (Sub3: heart icon on reviews)
-- ============================================================
INSERT INTO review_likes (review_id, user_id) VALUES
(1, 2), (1, 3), (1, 4),   -- review 1 has 3 likes
(2, 3), (2, 4),            -- review 2 has 2 likes
(3, 5),                    -- review 3 has 1 like
(4, 2), (4, 4), (4, 5), (4, 1),  -- review 4 has 4 likes
(5, 1), (5, 3);            -- review 5 has 2 likes

-- ============================================================
-- Conversations & Messages
-- Sub3 Message screen: chat list with preview
-- Sub3 Chat: text + image sharing, edit/delete actions
-- ============================================================
INSERT INTO conversations (id, item_id) VALUES
(1, 1), (2, 3), (3, 4), (4, 8), (5, 15);

INSERT INTO conversation_participants (conversation_id, user_id) VALUES
(1, 1), (1, 5),
(2, 1), (2, 3),
(3, 2), (3, 3),
(4, 4), (4, 5),
(5, 1), (5, 2);

INSERT INTO messages (conversation_id, sender_id, content, message_type, is_read, is_edited, is_deleted) VALUES
(1, 5, 'Hi Maria! I saw your Catan game. Would you be interested in swapping for magnetic tiles?', 'text', TRUE, FALSE, FALSE),
(1, 1, 'Hi Sarah! Yes, that sounds great. My kids would love magnetic tiles!', 'text', TRUE, FALSE, FALSE),
(1, 5, 'Perfect! Shall we meet at Fitzroy Gardens this Saturday at 2pm?', 'text', TRUE, FALSE, FALSE),
(1, 1, 'Saturday 2pm works perfectly. See you there!', 'text', TRUE, FALSE, FALSE),
(1, 5, NULL, 'image', TRUE, FALSE, FALSE),  -- image message
(2, 3, 'Hi Maria, are the teddy bears still available for donation?', 'text', TRUE, FALSE, FALSE),
(2, 1, 'Yes they are! Would you like to pick them up at Monash?', 'text', TRUE, FALSE, FALSE),
(2, 3, 'That would be great, thank you so much!', 'text', TRUE, FALSE, FALSE),
(3, 3, 'Hey Emily! Want to swap Mario Kart for my Codenames?', 'text', TRUE, FALSE, FALSE),
(3, 2, 'Hmm let me think about it! I do love party games...', 'text', FALSE, FALSE, FALSE),
(4, 5, 'Hi Alex, the cricket set looks perfect for the kids in our street!', 'text', TRUE, FALSE, FALSE),
(4, 4, 'Happy to donate it! When works for you to pick up?', 'text', TRUE, FALSE, FALSE),
(4, 4, 'Actually I can ship it via AusPost if that is easier?', 'text', TRUE, TRUE, FALSE),  -- edited message
(5, 1, 'Hi Emily, the Barbie Dreamhouse looks amazing! Is it still available?', 'text', TRUE, FALSE, FALSE),
(5, 2, 'Yes it is! What do you have to offer for a swap?', 'text', FALSE, FALSE, FALSE);

-- ============================================================
-- Message Attachments (Sub3 Chat: photo, gallery, voice)
-- ============================================================
INSERT INTO message_attachments (message_id, attachment_type, file_url, file_name, file_size) VALUES
(5, 'image', '/uploads/chat/catan_meetup_map.jpg', 'catan_meetup_map.jpg', 245000);

-- ============================================================
-- Comments (Sub3 Post Detail: comment section with nested replies)
-- "20 comments", avatar, username, text, time, location, Reply, "View 3 Replies"
-- ============================================================
INSERT INTO comments (id, item_id, user_id, parent_id, content, location, like_count, reply_count) VALUES
-- Comments on Barbie Dreamhouse (item 15) - most popular post
(1,  15, 3, NULL, 'This looks amazing! My little sister would love it. Is the elevator working?', 'Melbourne', 4, 2),
(2,  15, 1, NULL, 'Beautiful dreamhouse! What are you looking to swap for?', 'Melbourne', 2, 1),
(3,  15, 4, NULL, 'Great condition for a used dreamhouse. My niece would be thrilled!', 'Brisbane', 3, 0),
(4,  15, 5, NULL, 'I have a LEGO Friends set I could offer in exchange!', 'Perth', 1, 1),
-- Nested replies
(5,  15, 2, 1,    'Yes the elevator works perfectly! And all the furniture is included.', 'Sydney', 2, 0),
(6,  15, 3, 1,    'That is great to hear, thank you!', 'Melbourne', 0, 0),
(7,  15, 2, 2,    'Looking for educational toys or outdoor toys preferably!', 'Sydney', 1, 0),
(8,  15, 2, 4,    'That sounds interesting! Can you send me photos?', 'Sydney', 0, 0),
-- Comments on Mario Kart (item 4)
(9,  4,  1, NULL, 'My son has been asking for this game! Is the cartridge in good condition?', 'Melbourne', 3, 1),
(10, 4,  5, NULL, 'Great price for Mario Kart. Can you do mail swap?', 'Perth', 1, 1),
(11, 4,  2, 9,    'Yes, no scratches on the cartridge. Works perfectly!', 'Sydney', 2, 0),
(12, 4,  2, 10,   'I prefer in-person but can consider mail for interstate!', 'Sydney', 0, 0),
-- Comments on Magnetic Tiles (item 10)
(13, 10, 1, NULL, 'These are great for kids! How many different shapes are included?', 'Melbourne', 2, 1),
(14, 10, 3, NULL, 'My nephew loves magnetic tiles. Are all magnets still strong?', 'Melbourne', 1, 0),
(15, 10, 5, 13,   'There are 8 different shapes - squares, triangles, hexagons and more!', 'Perth', 1, 0),
-- Comments on Cricket Set (item 8)
(16, 8,  1, NULL, 'Perfect for summer! What size is the bat?', 'Melbourne', 2, 1),
(17, 8,  5, NULL, 'Would love this for the kids in our street. Very generous!', 'Perth', 3, 0),
(18, 8,  3, NULL, 'Is this suitable for 5 year olds?', 'Melbourne', 0, 1),
(19, 8,  4, 16,   'It is a junior size bat, perfect for kids aged 6-12.', 'Brisbane', 1, 0),
(20, 8,  4, 18,   'It might be a bit big for a 5 year old, recommended 6+.', 'Brisbane', 1, 0);

-- ============================================================
-- Comment Likes (Sub3: heart on comments)
-- ============================================================
INSERT INTO comment_likes (comment_id, user_id) VALUES
(1, 2), (1, 4), (1, 5), (1, 1),
(2, 3), (2, 5),
(3, 1), (3, 2), (3, 5),
(4, 2),
(5, 3), (5, 1),
(7, 3),
(9, 2), (9, 5), (9, 4),
(10, 2),
(11, 1), (11, 5),
(13, 3), (13, 4),
(14, 5),
(15, 3),
(16, 5), (16, 4),
(17, 1), (17, 4), (17, 2),
(19, 1),
(20, 3);

-- ============================================================
-- Likes (Sub3 Post Detail: heart icon)
-- ============================================================
INSERT INTO likes (user_id, item_id) VALUES
(1, 10), (1, 15), (1, 8), (1, 14),
(2, 1), (2, 2), (2, 10), (2, 12),
(3, 4), (3, 15), (3, 9), (3, 10), (3, 12),
(4, 1), (4, 12), (4, 15), (4, 6),
(5, 2), (5, 6), (5, 14), (5, 15), (5, 4);

-- ============================================================
-- Bookmarks (Sub3 Post Detail: star/bookmark icon, Profile: Shortlist tab)
-- ============================================================
INSERT INTO bookmarks (user_id, item_id) VALUES
(1, 15), (1, 4), (1, 10),
(2, 10), (2, 12),
(3, 4), (3, 15), (3, 14),
(4, 1), (4, 6),
(5, 2), (5, 15), (5, 14), (5, 8);

-- ============================================================
-- Notifications
-- ============================================================
INSERT INTO notifications (user_id, type, title, body, reference_type, reference_id, is_read) VALUES
(1, 'swap_request',       'New swap request',       'Emily wants to swap for your Barbie Dreamhouse',                'transaction', 6,  FALSE),
(2, 'swap_request',       'New swap request',       'Emily Chen wants to swap Codenames for your Mario Kart',        'transaction', 3,  FALSE),
(4, 'transaction_update', 'Donation accepted',      'Sarah accepted your donation request for the Cricket Set',      'transaction', 4,  TRUE),
(1, 'review',             'New review received',    'Sarah left you a 5-star review!',                               'review',      1,  TRUE),
(5, 'review',             'New review received',    'Maria left you a 5-star review!',                               'review',      2,  TRUE),
(3, 'system',             'Complete your profile',  'Verify your phone number to increase your trust score',          NULL,          NULL, FALSE),
(1, 'follow',             'New follower',           'Emily Chen started following you',                               'user',        3,  TRUE),
(1, 'comment',            'New comment',            'Emily Chen commented on your Watercolor Paint Set',              'item',        13, FALSE),
(2, 'like',               'Someone liked your post', 'Maria liked your Barbie Dreamhouse listing',                    'item',        15, TRUE),
(5, 'comment',            'New comment',            'Maria commented on your Magnetic Tiles listing',                 'item',        10, FALSE);

-- ============================================================
-- Notification Settings
-- ============================================================
INSERT INTO notification_settings (user_id, swap_requests_enabled, messages_enabled, reviews_enabled, transaction_updates_enabled, system_updates_enabled, marketing_enabled, email_notifications, push_notifications) VALUES
(1, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE),
(2, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE),
(3, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE),
(4, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE),
(5, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);

-- ============================================================
-- Reports
-- ============================================================
INSERT INTO reports (reporter_id, reported_user_id, reported_item_id, reason, description, status) VALUES
(3, NULL, NULL, 'spam', 'Received suspicious message from a deleted account offering "free" electronics.', 'resolved');

-- ============================================================
-- Search History (Sub3 Home: historical search, "Guess you want")
-- ============================================================
INSERT INTO search_history (user_id, query, category_id, result_count) VALUES
(1, 'magnetic tiles',    NULL, 8),
(1, 'LEGO',             4,    15),
(1, 'educational toys',  NULL, 22),
(2, 'board games',       8,    12),
(2, 'barbie',            9,    5),
(3, 'mario kart',        6,    3),
(3, 'plush toys',        1,    9),
(3, 'books',             10,   14),
(4, 'outdoor',           5,    11),
(5, 'puzzles',           8,    7),
(5, 'scooter',           5,    4);

-- ============================================================
-- Saved Searches
-- ============================================================
INSERT INTO saved_searches (user_id, name, query, category_id, condition_filter, type_filter, max_distance_km) VALUES
(1, 'LEGO for kids',            'LEGO', 4,    NULL,       'swap', 20),
(3, 'Cheap board games',        NULL,   8,    NULL,       'swap', 10),
(5, 'Educational toys near me', NULL,   7,    'good',     'both', 15);
