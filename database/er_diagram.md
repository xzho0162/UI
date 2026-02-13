# ToySwap Database - Entity Relationship Diagram

## Overview

This database supports the ToySwap Toy & Game Swapping/Donation platform, designed based on the FIT5152 UI prototype requirements.

## Entity Relationship Diagram (Text)

```
┌─────────────────┐       ┌──────────────────────┐       ┌─────────────────┐
│     users        │       │    user_addresses     │       │user_verifications│
│─────────────────│       │──────────────────────│       │─────────────────│
│ PK id            │──┐    │ PK id                │       │ PK id            │
│    email          │  ├───│ FK user_id           │       │ FK user_id ──────│
│    password_hash  │  │   │    label              │       │    type          │
│    username       │  │   │    address_line1      │       │    status        │
│    first_name     │  │   │    city, state        │       │    verified_at   │
│    last_name      │  │   │    postcode           │       └─────────────────┘
│    avatar_url     │  │   │    latitude/longitude │
│    phone          │  │   │    is_default         │
│    trust_score    │  │   └──────────────────────┘
│    total_swaps    │  │
│    total_donations│  │   ┌──────────────────────┐
│    is_*_verified  │  │   │     categories        │
│    created_at     │  │   │──────────────────────│
└─────────────────┘  │   │ PK id                │◄──┐
                      │   │    name               │   │
                      │   │    description         │   │
                      │   │    icon                │   │
                      │   │ FK parent_id ─────────│───┘ (self-referencing)
                      │   │    sort_order          │
                      │   └──────────────────────┘
                      │            │
                      │            │
                      │   ┌──────────────────────┐       ┌─────────────────┐
                      │   │       items            │       │   item_images    │
                      │   │──────────────────────│       │─────────────────│
                      ├───│ FK user_id            │       │ PK id            │
                      │   │ PK id                │──────│ FK item_id       │
                      │   │    title              │       │    image_url     │
                      │   │    description        │       │    is_primary    │
                      │   │ FK category_id        │       │    sort_order    │
                      │   │    condition           │       └─────────────────┘
                      │   │    age_range_min/max   │
                      │   │    type (swap/donate)  │
                      │   │    price_estimate      │
                      │   │    exchange_preference │
                      │   │    status              │
                      │   │    completion_pct      │
                      │   │    view_count          │
                      │   │    like_count          │
                      │   └──────────────────────┘
                      │            │
                      │            │
                      │   ┌──────────────────────┐       ┌─────────────────┐
                      │   │    transactions        │       │     reviews      │
                      │   │──────────────────────│       │─────────────────│
                      ├───│ FK from_user_id       │       │ PK id            │
                      ├───│ FK to_user_id         │       │ FK transaction_id│
                      │   │ PK id                │──────│ FK reviewer_id   │
                      │   │    type               │       │ FK reviewed_user │
                      │   │ FK item_id            │       │    rating (1-5)  │
                      │   │ FK offered_item_id    │       │    comment       │
                      │   │    status              │       └─────────────────┘
                      │   │    message             │
                      │   │    meeting_location    │
                      │   │    meeting_time        │
                      │   │    completed_at        │
                      │   └──────────────────────┘
                      │
                      │   ┌──────────────────────┐       ┌─────────────────┐
                      │   │   conversations        │       │    messages      │
                      │   │──────────────────────│       │─────────────────│
                      │   │ PK id                │──────│ PK id            │
                      │   │ FK item_id            │       │ FK conversation  │
                      │   │    created_at          │       │ FK sender_id     │
                      │   └──────────────────────┘       │    content       │
                      │            │                      │    message_type  │
                      │   ┌──────────────────────┐       │    is_read       │
                      │   │ conversation_         │       └─────────────────┘
                      │   │   participants        │
                      │   │──────────────────────│
                      ├───│ FK user_id            │
                      │   │ FK conversation_id    │
                      │   │    last_read_at        │
                      │   └──────────────────────┘
                      │
                      │   ┌──────────────────────┐
                      │   │       likes            │
                      │   │──────────────────────│
                      ├───│ FK user_id            │
                      │   │ FK item_id            │
                      │   │    created_at          │
                      │   └──────────────────────┘
                      │
                      │   ┌──────────────────────┐
                      │   │   notifications        │
                      │   │──────────────────────│
                      ├───│ FK user_id            │
                      │   │ PK id                │
                      │   │    type               │
                      │   │    title, body         │
                      │   │    reference_type/id   │
                      │   │    is_read             │
                      │   └──────────────────────┘
                      │
                      │   ┌──────────────────────┐
                      │   │notification_settings   │
                      │   │──────────────────────│
                      ├───│ FK user_id (UNIQUE)   │
                      │   │    swap_requests       │
                      │   │    messages            │
                      │   │    reviews             │
                      │   │    system/marketing    │
                      │   │    email/push          │
                      │   └──────────────────────┘
                      │
                      │   ┌──────────────────────┐
                      │   │      reports           │
                      │   │──────────────────────│
                      ├───│ FK reporter_id        │
                      │   │ FK reported_user_id   │
                      │   │ FK reported_item_id   │
                      │   │    reason              │
                      │   │    description         │
                      │   │    status              │
                      │   └──────────────────────┘
                      │
                      │   ┌──────────────────────┐
                      │   │   saved_searches       │
                      │   │──────────────────────│
                      └───│ FK user_id            │
                          │ FK category_id        │
                          │    name, query         │
                          │    filters             │
                          └──────────────────────┘
```

## Table Relationships Summary

| Relationship | Type | Description |
|---|---|---|
| users → items | 1:N | A user can list many items |
| users → user_addresses | 1:N | A user can have multiple addresses |
| users → user_verifications | 1:N | A user can have multiple verification badges |
| categories → categories | 1:N | Self-referencing for sub-categories |
| categories → items | 1:N | Each item belongs to one category |
| items → item_images | 1:N | An item can have multiple images |
| items → transactions | 1:N | An item can be part of multiple transactions |
| users → transactions | 1:N | As from_user (requester) or to_user (owner) |
| transactions → reviews | 1:N | Each transaction can have up to 2 reviews (one per user) |
| conversations → messages | 1:N | A conversation contains many messages |
| conversations → conversation_participants | 1:N | A conversation has multiple participants |
| users → likes → items | N:M | Many-to-many between users and items |
| users → notifications | 1:N | A user receives many notifications |
| users → notification_settings | 1:1 | Each user has one notification settings record |
| users → reports | 1:N | A user can file multiple reports |
| users → saved_searches | 1:N | A user can save multiple searches |

## Key Design Decisions

1. **Trust System**: `trust_score` on users is a computed average from reviews. `user_verifications` tracks individual verification badges (email, phone, identity) as shown in the Safety Dashboard wireframe.

2. **Unified Like Icon**: The `likes` table supports the unified heart icon (fixed in Sub4 usability improvement - standardized from thumbs-up/heart inconsistency).

3. **Item Completion Tracking**: `completion_pct` on items tracks the "3/7 required fields filled" progress bar from the Sub4 Add Post screen.

4. **Flexible Transactions**: The `transactions` table handles both swaps and donations. For swaps, `offered_item_id` references the item offered in return.

5. **Notification Control**: `notification_settings` table gives users fine-grained control over notification types and delivery channels (per Persona 4 Alex's requirement).

6. **Safety Dashboard**: `reports` table with status tracking supports the Safety Dashboard's "Report Issue" feature. Combined with `user_verifications` and `reviews`, this provides the trust infrastructure.

7. **Hierarchical Categories**: `categories` table uses a self-referencing `parent_id` for organizing toy types (e.g., "Board Games" → "Strategy Games", "Family Games").
