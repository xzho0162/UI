# ToySwap Database - Entity Relationship Diagram (v2)

## Overview

This database supports the ToySwap Toy & Game Swapping/Donation platform, designed based on FIT5152 Sub1 (User Analysis), Sub2 (Low-Fidelity), Sub3 (High-Fidelity Prototype), and Sub4 (Usability Improvements).

**Total: 27 tables**

## Table Relationships Summary

| Relationship | Type | Source (Sub) | Description |
|---|---|---|---|
| users → items | 1:N | Sub3 Profile Posts | A user can list many items |
| users → user_addresses | 1:N | Sub1 | Multiple exchange locations |
| users → user_verifications | 1:N | Sub3 Profile Verified badge | Verification badges |
| users → user_follows | N:M | Sub3 Profile Followers/Following | Follow system |
| categories → categories | 1:N (self) | Sub3 Category Screen | Hierarchical sub-categories |
| categories → items | 1:N | Sub3 Add Post | Each item belongs to one category |
| items → item_images | 1:N | Sub3 Add Post gallery | Multiple images per item |
| items → item_tags → tags | N:M | Sub3 Add Post Tags | Tags on items |
| items → transactions | 1:N | Sub3 Profile Exchange tab | Item in multiple transactions |
| items → comments | 1:N | Sub3 Post Detail comments | Comments on posts |
| comments → comments | 1:N (self) | Sub3 "View 3 Replies" | Nested reply threads |
| comments → comment_likes | 1:N | Sub3 heart on comments | Like individual comments |
| users → transactions | 1:N | Sub3 Exchange tab | As requester or owner |
| transactions → reviews | 1:N | Sub3 Profile Review overlay | Up to 2 reviews per transaction |
| transactions → parcels | 1:1 | Sub3 Profile Parcels tab | Shipping tracking |
| reviews → review_likes | 1:N | Sub3 heart on reviews | Like individual reviews |
| users → credit_transactions | 1:N | Sub3 Profile Credit tab | Credit/points history |
| conversations → messages | 1:N | Sub3 Chat screen | Messages in conversation |
| conversations → conversation_participants | 1:N | Sub3 Message screen | Users in chat |
| messages → message_attachments | 1:N | Sub3 Chat photo/voice | Attachments on messages |
| users → likes → items | N:M | Sub3 Post Detail heart (15) | Heart/like items |
| users → bookmarks → items | N:M | Sub3 Post Detail star (5) / Profile Shortlist | Star/bookmark items |
| users → notifications | 1:N | Sub3 | System notifications |
| users → notification_settings | 1:1 | Sub1 Persona 4 Alex | Notification preferences |
| users → reports | 1:N | Sub2 Safety Dashboard | Safety reports |
| users → search_history | 1:N | Sub3 Home search history | Search history with delete |
| users → saved_searches | 1:N | Sub1 | Saved search filters |

## Schema Mapping to Sub3 Screens

### Home Screen (Browse Feed)
- `items` → item cards with category tag, type (Swap/Donate), last updated
- `item_images` → primary image on card
- `categories` → category label (GAME, BOOK)
- `search_history` → "Guess you want" suggestions + historical searches with delete
- `users` → avatar on item cards

### Profile Screen
- `users.level` → "Lv.5" display
- `users.follower_count / following_count` → Followers / Following counts
- `user_verifications` → "Verified" badge
- `credit_transactions` → Credit tab content
- `transactions` → Exchange tab content
- `bookmarks` → Shortlist tab content
- `parcels` → Parcels tab content
- `items` (filtered by user_id) → Posts section
- `reviews` → Review overlay with tabs: recommend, exchange, donate
- `review_likes` → Heart icon on each review

### Message Screen
- `conversations` + `conversation_participants` → chat list
- `messages` → preview text, time
- `likes` (count) → like count at top
- `user_follows` (count) → followers count at top

### Chat Screen
- `messages` → text messages with edit/delete support
- `message_attachments` → photo, gallery, voice attachments
- `messages.is_edited` → Edit action
- `messages.is_deleted` → Delete action (soft delete)

### Add Post Screen
- `items.type` → Swap/Donate dropdown selector
- `items.title` → Item Name field
- `items.condition` → Brand New, Like New, Good, Used, Needs Repair
- `items.exchange_preference` → Pickup Available, Drop-off Preferred, Both
- `items.category_id` → Category (Suggested)
- `item_tags` → Tags dropdown
- `item_images` → Image gallery from Quick Fill
- `items.description` → Auto contents + rich text (#, @, Tt formatting)
- `items.completion_pct` → "20% Completion" progress bar

### Post Detail Screen
- `items` → title, description, location, updated time
- `item_images` → image display
- `users` → poster avatar + Follow button
- `bookmarks` → bookmark/star icon
- `comments` → comment section ("20 comments")
- `comments.parent_id` → nested replies ("View 3 Replies")
- `comments.location` → location on each comment
- `comment_likes` → heart on comments
- `likes` → heart icon count (15)
- `bookmarks` → star icon count (5)
- `items.comment_count` → comment count (20)

### Category Screen
- `categories` (parent_id IS NULL) → main grid of 12 categories
- `categories` (parent_id IS NOT NULL) → sub-categories
- `search_history` → Recent Visited tab
- `items` (sorted by created_at) → View All Toys (NEW ALL) tab
- `items` (sorted by like_count) → Hot Post tab

## Key Design Decisions

1. **User Level System** (Sub3): `users.level` field tracks user progression (Lv.1 to Lv.5+). Level increases based on completed swaps, donations, and reviews.

2. **Dual Interaction: Likes vs Bookmarks** (Sub3): Two separate tables - `likes` (heart icon, count=15) and `bookmarks` (star icon, count=5, Profile Shortlist tab). These serve different purposes: likes = social engagement, bookmarks = personal save list.

3. **Nested Comments** (Sub3): `comments.parent_id` self-reference enables threaded replies shown as "View 3 Replies" in the Post Detail screen. Each comment has location display.

4. **Credit System** (Sub3): `credit_transactions` logs all credit operations (earn/spend) for the Profile Credit tab. `users.credit_balance` stores current balance.

5. **Parcel Tracking** (Sub3): `parcels` table supports the Profile Parcels tab with carrier and tracking info for mail-based exchanges.

6. **Message Editing** (Sub3): `messages.is_edited` and `messages.is_deleted` support the right-click actions (Undo, Edit, Delete) visible in the Chat screen.

7. **Review Types** (Sub3): `reviews.review_type` maps to the three tabs in the Profile Review overlay: 'recommend', 'exchange', 'donate'. Reviews also show category labels.

8. **Search History** (Sub3): `search_history` powers the Home screen's historical search display with delete capability and "Guess you want" suggestions.

9. **Tag System** (Sub3): `tags` + `item_tags` many-to-many supports the Add Post Tags dropdown with "Suggested" tags.

10. **Categories** (Sub3): 12 main categories matching the exact Category Screen grid, with hierarchical sub-categories via self-referencing `parent_id`.

11. **Updated Condition Values** (Sub3): 'brand_new', 'like_new', 'good', 'used', 'needs_repair' matching the Add Post dropdown.

12. **Updated Preference Values** (Sub3): 'pickup', 'dropoff', 'both' matching the Add Post Preference selector.
