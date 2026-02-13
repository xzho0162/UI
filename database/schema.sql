-- ============================================================
-- ToySwap Database Schema
-- Toy & Game Swapping/Donation Platform
-- Based on FIT5152 UI Prototype Requirements
-- ============================================================

-- Drop tables if they exist (in reverse dependency order)
DROP TABLE IF EXISTS saved_searches;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS notification_settings;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS conversation_participants;
DROP TABLE IF EXISTS conversations;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS item_images;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS user_verifications;
DROP TABLE IF EXISTS user_addresses;
DROP TABLE IF EXISTS users;

-- ============================================================
-- 1. USERS
-- Core user accounts with trust scoring and verification status
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
    trust_score     DECIMAL(3,2) DEFAULT 0.00,  -- 0.00 to 5.00
    total_swaps     INTEGER DEFAULT 0,
    total_donations INTEGER DEFAULT 0,
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
    label           VARCHAR(50) NOT NULL,  -- e.g. "Home", "Work", "Park"
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
-- Verification badges (email, phone, identity, in-person swaps)
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
-- 4. CATEGORIES
-- Hierarchical toy/game categories
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
-- 5. ITEMS
-- Toy/game listings posted by users for swap or donation
-- Required fields: title, description, category, condition, type, age_range, at least 1 image
-- (7 required fields as indicated in Sub4 "3/7 required fields filled")
-- ============================================================
CREATE TABLE items (
    id                  SERIAL PRIMARY KEY,
    user_id             INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title               VARCHAR(200) NOT NULL,
    description         TEXT NOT NULL,
    category_id         INTEGER NOT NULL REFERENCES categories(id),
    condition           VARCHAR(20) NOT NULL,  -- 'new', 'like_new', 'good', 'fair', 'poor'
    age_range_min       INTEGER,               -- minimum recommended age
    age_range_max       INTEGER,               -- maximum recommended age
    type                VARCHAR(20) NOT NULL,  -- 'swap', 'donate', 'both'
    price_estimate      DECIMAL(10,2),         -- suggested value for swap reference
    exchange_preference VARCHAR(20) DEFAULT 'both', -- 'in_person', 'mail', 'both'
    status              VARCHAR(20) DEFAULT 'draft', -- 'draft', 'active', 'reserved', 'completed', 'archived'
    completion_pct      INTEGER DEFAULT 0,     -- profile completion percentage (0-100)
    view_count          INTEGER DEFAULT 0,
    like_count          INTEGER DEFAULT 0,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_items_user ON items(user_id);
CREATE INDEX idx_items_category ON items(category_id);
CREATE INDEX idx_items_status ON items(status);
CREATE INDEX idx_items_type ON items(type);
CREATE INDEX idx_items_created ON items(created_at DESC);

-- ============================================================
-- 6. ITEM IMAGES
-- Multiple images per item listing
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
-- 7. TRANSACTIONS
-- Records of swaps and donations between users
-- ============================================================
CREATE TABLE transactions (
    id                  SERIAL PRIMARY KEY,
    type                VARCHAR(20) NOT NULL,  -- 'swap', 'donation'
    item_id             INTEGER NOT NULL REFERENCES items(id),
    from_user_id        INTEGER NOT NULL REFERENCES users(id),
    to_user_id          INTEGER NOT NULL REFERENCES users(id),
    offered_item_id     INTEGER REFERENCES items(id),  -- for swaps: item offered in return
    status              VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'accepted', 'rejected', 'in_progress', 'completed', 'cancelled'
    message             TEXT,                           -- initial message from requester
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
-- 8. REVIEWS
-- Post-transaction reviews for trust building
-- ============================================================
CREATE TABLE reviews (
    id                  SERIAL PRIMARY KEY,
    transaction_id      INTEGER NOT NULL REFERENCES transactions(id),
    reviewer_id         INTEGER NOT NULL REFERENCES users(id),
    reviewed_user_id    INTEGER NOT NULL REFERENCES users(id),
    rating              INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment             TEXT,
    is_visible          BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(transaction_id, reviewer_id)  -- one review per user per transaction
);

CREATE INDEX idx_reviews_reviewed_user ON reviews(reviewed_user_id);
CREATE INDEX idx_reviews_reviewer ON reviews(reviewer_id);

-- ============================================================
-- 9. CONVERSATIONS
-- Chat threads between users about items
-- ============================================================
CREATE TABLE conversations (
    id              SERIAL PRIMARY KEY,
    item_id         INTEGER REFERENCES items(id),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_conversations_item ON conversations(item_id);

-- ============================================================
-- 10. CONVERSATION PARTICIPANTS
-- Users participating in a conversation
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
-- 11. MESSAGES
-- Individual chat messages within conversations
-- ============================================================
CREATE TABLE messages (
    id                  SERIAL PRIMARY KEY,
    conversation_id     INTEGER NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    sender_id           INTEGER NOT NULL REFERENCES users(id),
    content             TEXT NOT NULL,
    message_type        VARCHAR(20) DEFAULT 'text',  -- 'text', 'image', 'system'
    is_read             BOOLEAN DEFAULT FALSE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_messages_conversation ON messages(conversation_id);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_created ON messages(created_at);

-- ============================================================
-- 12. LIKES (Favorites)
-- Users can like/favorite items (unified heart icon per Sub4)
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
-- 13. NOTIFICATIONS
-- System notifications for users
-- ============================================================
CREATE TABLE notifications (
    id                  SERIAL PRIMARY KEY,
    user_id             INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type                VARCHAR(50) NOT NULL,  -- 'swap_request', 'message', 'review', 'system', 'transaction_update'
    title               VARCHAR(200) NOT NULL,
    body                TEXT,
    reference_type      VARCHAR(50),           -- 'transaction', 'item', 'message', 'review'
    reference_id        INTEGER,               -- ID of the referenced entity
    is_read             BOOLEAN DEFAULT FALSE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(user_id, is_read);
CREATE INDEX idx_notifications_created ON notifications(created_at DESC);

-- ============================================================
-- 14. NOTIFICATION SETTINGS
-- Per-user notification preferences (per Persona 4 Alex's requirement)
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
-- 15. REPORTS
-- Safety reports for users/items (Safety Dashboard feature)
-- ============================================================
CREATE TABLE reports (
    id                  SERIAL PRIMARY KEY,
    reporter_id         INTEGER NOT NULL REFERENCES users(id),
    reported_user_id    INTEGER REFERENCES users(id),
    reported_item_id    INTEGER REFERENCES items(id),
    reason              VARCHAR(50) NOT NULL,  -- 'fraud', 'inappropriate', 'spam', 'safety', 'other'
    description         TEXT NOT NULL,
    status              VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'reviewing', 'resolved', 'dismissed'
    admin_notes         TEXT,
    resolved_at         TIMESTAMP,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_reports_reporter ON reports(reporter_id);
CREATE INDEX idx_reports_reported_user ON reports(reported_user_id);
CREATE INDEX idx_reports_status ON reports(status);

-- ============================================================
-- 16. SAVED SEARCHES
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
