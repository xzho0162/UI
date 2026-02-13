-- ============================================================
-- ToySwap Database Schema (v2)
-- Toy & Game Swapping/Donation Platform
-- Based on FIT5152 Sub1 + Sub2 + Sub3 + Sub4 Requirements
-- ============================================================

-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS search_history;
DROP TABLE IF EXISTS saved_searches;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS notification_settings;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS bookmarks;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS comment_likes;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS message_attachments;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS conversation_participants;
DROP TABLE IF EXISTS conversations;
DROP TABLE IF EXISTS review_likes;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS parcels;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS credit_transactions;
DROP TABLE IF EXISTS item_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS item_images;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS user_follows;
DROP TABLE IF EXISTS user_verifications;
DROP TABLE IF EXISTS user_addresses;
DROP TABLE IF EXISTS users;

-- ============================================================
-- 1. USERS
-- Core user accounts with trust scoring, level system, and credit balance
-- Sub3: Profile shows Lv.5, Verified badge, Followers/Following counts,
--       Credit tab, Exchange tab, Shortlist tab, Parcels tab
-- ============================================================
CREATE TABLE users (
    id              SERIAL PRIMARY KEY,
    email           VARCHAR(255) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    avatar_url      VARCHAR(500),
    phone           VARCHAR(20),
    date_of_birth   DATE,
    gender          VARCHAR(20),
    bio             TEXT,
    location        VARCHAR(255),
    postcode        VARCHAR(10),
    level           INTEGER DEFAULT 1,              -- User level (Sub3: Lv.5)
    credit_balance  DECIMAL(10,2) DEFAULT 0.00,     -- Credit points (Sub3: Credit tab)
    trust_score     DECIMAL(3,2) DEFAULT 0.00,      -- 0.00 to 5.00
    total_swaps     INTEGER DEFAULT 0,
    total_donations INTEGER DEFAULT 0,
    follower_count  INTEGER DEFAULT 0,              -- Sub3: Followers count
    following_count INTEGER DEFAULT 0,              -- Sub3: Following count
    is_email_verified  BOOLEAN DEFAULT FALSE,
    is_phone_verified  BOOLEAN DEFAULT FALSE,
    is_id_verified     BOOLEAN DEFAULT FALSE,
    is_active       BOOLEAN DEFAULT TRUE,
    last_login_at   TIMESTAMP,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. USER ADDRESSES
-- Exchange/meeting locations for in-person swaps
-- ============================================================
CREATE TABLE user_addresses (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    label           VARCHAR(50) NOT NULL,
    address_line1   VARCHAR(255) NOT NULL,
    address_line2   VARCHAR(255),
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL,
    postcode        VARCHAR(10) NOT NULL,
    country         VARCHAR(100) DEFAULT 'Australia',
    latitude        DECIMAL(10,7),
    longitude       DECIMAL(10,7),
    is_default      BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_addresses_user ON user_addresses(user_id);

-- ============================================================
-- 3. USER VERIFICATIONS
-- Verification badges (Sub3: Verified badge on profile)
-- ============================================================
CREATE TABLE user_verifications (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type            VARCHAR(30) NOT NULL,  -- 'email', 'phone', 'identity', 'address'
    status          VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'verified', 'expired'
    verified_at     TIMESTAMP,
    expires_at      TIMESTAMP,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, type)
);

CREATE INDEX idx_user_verifications_user ON user_verifications(user_id);

-- ============================================================
-- 4. USER FOLLOWS
-- Sub3: Followers/Following system visible on Profile screen
-- ============================================================
CREATE TABLE user_follows (
    id              SERIAL PRIMARY KEY,
    follower_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    following_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(follower_id, following_id),
    CHECK(follower_id != following_id)
);

CREATE INDEX idx_user_follows_follower ON user_follows(follower_id);
CREATE INDEX idx_user_follows_following ON user_follows(following_id);

-- ============================================================
-- 5. CATEGORIES
-- Sub3 Category Screen: 12 main categories displayed in grid
-- Plush & Soft Toys, Baby Toys, Toy Vehicles & Playsets, LEGO,
-- Outdoor Toys & Play Equipment, Gaming, Toddler & Pre-School Toys,
-- Board Games & Puzzles, Dolls & Playsets, Children's Books,
-- Action Figures & Playsets
-- Also has tabs: Recent Visited, View All Toys, Hot Post
-- ============================================================
CREATE TABLE categories (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    icon            VARCHAR(100),
    parent_id       INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    sort_order      INTEGER DEFAULT 0,
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_categories_parent ON categories(parent_id);

-- ============================================================
-- 6. TAGS
-- Sub3 Add Post: "Tags" dropdown with "Suggested" tags for items
-- ============================================================
CREATE TABLE tags (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(50) NOT NULL UNIQUE,
    usage_count     INTEGER DEFAULT 0,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 7. ITEMS
-- Sub3 Add Post screen shows:
--   Type selector (Swap/Donate), Item Name, Condition (Brand New, Like New,
--   Good, Used, Needs Repair), Preference (Pickup Available, Drop-off Preferred, Both),
--   Category (Suggested), Tags, Image gallery, Auto contents from Quick Fill,
--   Rich text (#, @, Tt formatting), Voice input, 20% Completion progress
-- Sub3 Post Detail shows: location, time since update, comment count,
--   like count (heart 15), bookmark count (star 5), comment count (20)
-- ============================================================
CREATE TABLE items (
    id                  SERIAL PRIMARY KEY,
    user_id             INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title               VARCHAR(200) NOT NULL,
    description         TEXT NOT NULL,
    category_id         INTEGER NOT NULL REFERENCES categories(id),
    condition           VARCHAR(20) NOT NULL,  -- 'brand_new', 'like_new', 'good', 'used', 'needs_repair' (Sub3)
    age_range_min       INTEGER,
    age_range_max       INTEGER,
    type                VARCHAR(20) NOT NULL,  -- 'swap', 'donate' (Sub3 dropdown)
    price_estimate      DECIMAL(10,2),
    exchange_preference VARCHAR(20) DEFAULT 'both',  -- 'pickup', 'dropoff', 'both' (Sub3)
    location            VARCHAR(255),                 -- Sub3: location shown on post detail
    status              VARCHAR(20) DEFAULT 'draft',  -- 'draft', 'active', 'reserved', 'completed', 'archived'
    completion_pct      INTEGER DEFAULT 0,            -- Sub3: "20% Completion" progress bar
    view_count          INTEGER DEFAULT 0,
    like_count          INTEGER DEFAULT 0,            -- Sub3: heart icon count (15)
    bookmark_count      INTEGER DEFAULT 0,            -- Sub3: star/bookmark count (5)
    comment_count       INTEGER DEFAULT 0,            -- Sub3: comment count (20)
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_items_user ON items(user_id);
CREATE INDEX idx_items_category ON items(category_id);
CREATE INDEX idx_items_status ON items(status);
CREATE INDEX idx_items_type ON items(type);
CREATE INDEX idx_items_created ON items(created_at DESC);

-- ============================================================
-- 8. ITEM TAGS (many-to-many)
-- Sub3: Tags on items from Add Post screen
-- ============================================================
CREATE TABLE item_tags (
    id              SERIAL PRIMARY KEY,
    item_id         INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    tag_id          INTEGER NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    UNIQUE(item_id, tag_id)
);

CREATE INDEX idx_item_tags_item ON item_tags(item_id);
CREATE INDEX idx_item_tags_tag ON item_tags(tag_id);

-- ============================================================
-- 9. ITEM IMAGES
-- Sub3: Image gallery in Add Post, multiple images on Post Detail
-- ============================================================
CREATE TABLE item_images (
    id              SERIAL PRIMARY KEY,
    item_id         INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    image_url       VARCHAR(500) NOT NULL,
    is_primary      BOOLEAN DEFAULT FALSE,
    sort_order      INTEGER DEFAULT 0,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_item_images_item ON item_images(item_id);

-- ============================================================
-- 10. CREDIT TRANSACTIONS
-- Sub3 Profile: "Credit" tab - user credit/points system
-- ============================================================
CREATE TABLE credit_transactions (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount          DECIMAL(10,2) NOT NULL,        -- positive = earned, negative = spent
    type            VARCHAR(30) NOT NULL,          -- 'swap_completed', 'donation_made', 'review_given', 'signup_bonus', 'spent'
    description     VARCHAR(255),
    reference_type  VARCHAR(50),                   -- 'transaction', 'review'
    reference_id    INTEGER,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_credit_transactions_user ON credit_transactions(user_id);

-- ============================================================
-- 11. TRANSACTIONS
-- Records of swaps and donations between users
-- Sub3 Profile: "Exchange" tab shows transaction history
-- ============================================================
CREATE TABLE transactions (
    id                  SERIAL PRIMARY KEY,
    type                VARCHAR(20) NOT NULL,  -- 'swap', 'donation'
    item_id             INTEGER NOT NULL REFERENCES items(id),
    from_user_id        INTEGER NOT NULL REFERENCES users(id),
    to_user_id          INTEGER NOT NULL REFERENCES users(id),
    offered_item_id     INTEGER REFERENCES items(id),
    status              VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'accepted', 'rejected', 'in_progress', 'completed', 'cancelled'
    message             TEXT,
    meeting_location    VARCHAR(255),
    meeting_time        TIMESTAMP,
    completed_at        TIMESTAMP,
    cancelled_at        TIMESTAMP,
    cancellation_reason TEXT,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_transactions_item ON transactions(item_id);
CREATE INDEX idx_transactions_from_user ON transactions(from_user_id);
CREATE INDEX idx_transactions_to_user ON transactions(to_user_id);
CREATE INDEX idx_transactions_status ON transactions(status);

-- ============================================================
-- 12. PARCELS
-- Sub3 Profile: "Parcels" tab - parcel/shipping tracking
-- ============================================================
CREATE TABLE parcels (
    id                  SERIAL PRIMARY KEY,
    transaction_id      INTEGER NOT NULL REFERENCES transactions(id),
    sender_id           INTEGER NOT NULL REFERENCES users(id),
    receiver_id         INTEGER NOT NULL REFERENCES users(id),
    tracking_number     VARCHAR(100),
    carrier             VARCHAR(100),           -- 'auspost', 'sendle', 'aramex', etc.
    status              VARCHAR(30) DEFAULT 'preparing',  -- 'preparing', 'shipped', 'in_transit', 'delivered', 'returned'
    estimated_delivery  DATE,
    shipped_at          TIMESTAMP,
    delivered_at        TIMESTAMP,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_parcels_transaction ON parcels(transaction_id);
CREATE INDEX idx_parcels_sender ON parcels(sender_id);
CREATE INDEX idx_parcels_receiver ON parcels(receiver_id);

-- ============================================================
-- 13. REVIEWS
-- Sub3 Profile: Review overlay with tabs - recommend, exchange, donate
-- Shows: reviewer name, type, category, time ago, star rating, comment, heart
-- ============================================================
CREATE TABLE reviews (
    id                  SERIAL PRIMARY KEY,
    transaction_id      INTEGER NOT NULL REFERENCES transactions(id),
    reviewer_id         INTEGER NOT NULL REFERENCES users(id),
    reviewed_user_id    INTEGER NOT NULL REFERENCES users(id),
    rating              INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_type         VARCHAR(20) NOT NULL DEFAULT 'exchange',  -- 'recommend', 'exchange', 'donate' (Sub3 tabs)
    category            VARCHAR(50),             -- Sub3: category label on review (e.g. "Board Games")
    comment             TEXT,
    like_count          INTEGER DEFAULT 0,       -- Sub3: heart icon on reviews
    is_visible          BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(transaction_id, reviewer_id)
);

CREATE INDEX idx_reviews_reviewed_user ON reviews(reviewed_user_id);
CREATE INDEX idx_reviews_reviewer ON reviews(reviewer_id);
CREATE INDEX idx_reviews_type ON reviews(review_type);

-- ============================================================
-- 14. REVIEW LIKES
-- Sub3: Heart icon on each review
-- ============================================================
CREATE TABLE review_likes (
    id              SERIAL PRIMARY KEY,
    review_id       INTEGER NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(review_id, user_id)
);

-- ============================================================
-- 15. CONVERSATIONS
-- Sub3 Message screen: chat list with avatar, name, preview, time
-- ============================================================
CREATE TABLE conversations (
    id              SERIAL PRIMARY KEY,
    item_id         INTEGER REFERENCES items(id),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_conversations_item ON conversations(item_id);

-- ============================================================
-- 16. CONVERSATION PARTICIPANTS
-- ============================================================
CREATE TABLE conversation_participants (
    id                  SERIAL PRIMARY KEY,
    conversation_id     INTEGER NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    user_id             INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    last_read_at        TIMESTAMP,
    joined_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(conversation_id, user_id)
);

CREATE INDEX idx_conv_participants_user ON conversation_participants(user_id);

-- ============================================================
-- 17. MESSAGES
-- Sub3 Chat screen: text messages with image sharing, voice,
-- right-click actions (Undo, Edit, Delete), Mark as read
-- ============================================================
CREATE TABLE messages (
    id                  SERIAL PRIMARY KEY,
    conversation_id     INTEGER NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    sender_id           INTEGER NOT NULL REFERENCES users(id),
    content             TEXT,
    message_type        VARCHAR(20) DEFAULT 'text',  -- 'text', 'image', 'voice', 'system' (Sub3)
    is_read             BOOLEAN DEFAULT FALSE,
    is_edited           BOOLEAN DEFAULT FALSE,       -- Sub3: Edit action on messages
    is_deleted          BOOLEAN DEFAULT FALSE,        -- Sub3: Delete action (soft delete)
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_messages_conversation ON messages(conversation_id);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_created ON messages(created_at);

-- ============================================================
-- 18. MESSAGE ATTACHMENTS
-- Sub3 Chat: +, photo, gallery, emoji, voice attachment options
-- ============================================================
CREATE TABLE message_attachments (
    id              SERIAL PRIMARY KEY,
    message_id      INTEGER NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    attachment_type VARCHAR(20) NOT NULL,  -- 'image', 'voice', 'file'
    file_url        VARCHAR(500) NOT NULL,
    file_name       VARCHAR(255),
    file_size       INTEGER,               -- bytes
    duration        INTEGER,               -- seconds (for voice messages)
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_message_attachments_message ON message_attachments(message_id);

-- ============================================================
-- 19. COMMENTS
-- Sub3 Post Detail: comment section with nested replies
-- "20 comments", each with avatar, username, text, time, location,
-- Reply link, "View 3 Replies" for nested threads
-- Input: emoji, @mention, image, link
-- ============================================================
CREATE TABLE comments (
    id              SERIAL PRIMARY KEY,
    item_id         INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(id),
    parent_id       INTEGER REFERENCES comments(id) ON DELETE CASCADE,  -- NULL = top-level, set = nested reply
    content         TEXT NOT NULL,
    location        VARCHAR(255),           -- Sub3: location shown on comments
    like_count      INTEGER DEFAULT 0,
    reply_count     INTEGER DEFAULT 0,      -- Sub3: "View 3 Replies"
    is_deleted      BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_comments_item ON comments(item_id);
CREATE INDEX idx_comments_user ON comments(user_id);
CREATE INDEX idx_comments_parent ON comments(parent_id);
CREATE INDEX idx_comments_created ON comments(created_at);

-- ============================================================
-- 20. COMMENT LIKES
-- Sub3: heart/like on individual comments
-- ============================================================
CREATE TABLE comment_likes (
    id              SERIAL PRIMARY KEY,
    comment_id      INTEGER NOT NULL REFERENCES comments(id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(comment_id, user_id)
);

-- ============================================================
-- 21. LIKES (Heart icon)
-- Sub3 Post Detail: heart icon with count (15)
-- Sub3 Message screen: like count at top
-- ============================================================
CREATE TABLE likes (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    item_id         INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, item_id)
);

CREATE INDEX idx_likes_user ON likes(user_id);
CREATE INDEX idx_likes_item ON likes(item_id);

-- ============================================================
-- 22. BOOKMARKS (Star/Shortlist icon)
-- Sub3 Post Detail: star/bookmark icon with count (5)
-- Sub3 Profile: "Shortlist" tab
-- Separate from likes - star icon vs heart icon
-- ============================================================
CREATE TABLE bookmarks (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    item_id         INTEGER NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, item_id)
);

CREATE INDEX idx_bookmarks_user ON bookmarks(user_id);
CREATE INDEX idx_bookmarks_item ON bookmarks(item_id);

-- ============================================================
-- 23. NOTIFICATIONS
-- ============================================================
CREATE TABLE notifications (
    id                  SERIAL PRIMARY KEY,
    user_id             INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type                VARCHAR(50) NOT NULL,  -- 'swap_request', 'message', 'review', 'system', 'transaction_update', 'follow', 'comment', 'like'
    title               VARCHAR(200) NOT NULL,
    body                TEXT,
    reference_type      VARCHAR(50),
    reference_id        INTEGER,
    is_read             BOOLEAN DEFAULT FALSE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(user_id, is_read);
CREATE INDEX idx_notifications_created ON notifications(created_at DESC);

-- ============================================================
-- 24. NOTIFICATION SETTINGS
-- Sub1 Persona 4 Alex: notification control preferences
-- ============================================================
CREATE TABLE notification_settings (
    id                      SERIAL PRIMARY KEY,
    user_id                 INTEGER NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    swap_requests_enabled   BOOLEAN DEFAULT TRUE,
    messages_enabled        BOOLEAN DEFAULT TRUE,
    reviews_enabled         BOOLEAN DEFAULT TRUE,
    transaction_updates_enabled BOOLEAN DEFAULT TRUE,
    system_updates_enabled  BOOLEAN DEFAULT TRUE,
    marketing_enabled       BOOLEAN DEFAULT FALSE,
    email_notifications     BOOLEAN DEFAULT TRUE,
    push_notifications      BOOLEAN DEFAULT TRUE,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 25. REPORTS
-- Safety Dashboard: report users/items
-- ============================================================
CREATE TABLE reports (
    id                  SERIAL PRIMARY KEY,
    reporter_id         INTEGER NOT NULL REFERENCES users(id),
    reported_user_id    INTEGER REFERENCES users(id),
    reported_item_id    INTEGER REFERENCES items(id),
    reason              VARCHAR(50) NOT NULL,
    description         TEXT NOT NULL,
    status              VARCHAR(20) DEFAULT 'pending',
    admin_notes         TEXT,
    resolved_at         TIMESTAMP,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_reports_reporter ON reports(reporter_id);
CREATE INDEX idx_reports_reported_user ON reports(reported_user_id);
CREATE INDEX idx_reports_status ON reports(status);

-- ============================================================
-- 26. SEARCH HISTORY
-- Sub3 Home: historical search with delete option,
-- "Guess you want" suggestions
-- ============================================================
CREATE TABLE search_history (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    query           VARCHAR(255) NOT NULL,
    category_id     INTEGER REFERENCES categories(id),
    result_count    INTEGER DEFAULT 0,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_search_history_user ON search_history(user_id);
CREATE INDEX idx_search_history_created ON search_history(created_at DESC);

-- ============================================================
-- 27. SAVED SEARCHES
-- Users can save search filters for quick access
-- ============================================================
CREATE TABLE saved_searches (
    id              SERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name            VARCHAR(100) NOT NULL,
    query           VARCHAR(255),
    category_id     INTEGER REFERENCES categories(id),
    condition_filter VARCHAR(20),
    type_filter     VARCHAR(20),
    max_distance_km INTEGER,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_saved_searches_user ON saved_searches(user_id);
