# Where Did I Put It? — Complete Product Specification

## 1. Product Overview

**Product Name:** Where Did I Put It?

**Core Idea:**  
A visual memory app that helps users remember where they placed physical belongings.

The user takes a photo of an item, gives it a name/category, and optionally records where it was placed. The app builds a visual memory of the user's belongings so they can later ask:

- Where did I put my passport?
- Where are my keys?
- Where did I keep my headphones?
- Where is the charger?
- Where did I put the documents?
- Where did I keep the spare cable?

The product should feel less like a traditional inventory app and more like a **personal visual memory assistant**.

### Core Product Promise

> **"Never forget where you put something again."**

---

# 2. Product Philosophy

The app should solve one simple problem extremely well:

**User forgets where something is → app helps them remember it immediately.**

The experience should be:

1. Capture
2. Remember
3. Find

The user should not be forced to manually maintain a complicated inventory.

The product should gradually become more useful as the user adds more items and locations.

---

# 3. Target Users

### Primary Users

- People who frequently misplace things
- Students
- Families
- People with many gadgets/accessories
- People who store important documents
- People who travel frequently
- People managing household items

### Useful Scenarios

#### Scenario 1 — Keys

User puts keys in a drawer.

They open the app:

> Add Item → Keys → Photo → "Entrance Drawer"

Later:

> Search: Keys

Result:

> 🔑 Keys  
> Last remembered: Entrance Drawer  
> Added: Today

---

#### Scenario 2 — Passport

User stores passport in a cupboard.

Later:

> "Where is my passport?"

App shows:

> 📘 Passport  
> 📍 Bedroom Cupboard  
> 📸 Saved photo  
> 🕒 Last updated: 12 Aug

---

#### Scenario 3 — Charger

User has several chargers.

They can save:

- iPhone charger
- Laptop charger
- USB-C cable
- Power bank

Each item has its own visual record.

---

# 4. Main Product Features

## 4.1 Visual Item Capture

The primary action is:

> **+ Add Item**

User can:

- Take a photo
- Select from gallery
- Give item a name
- Select category
- Select location
- Add optional notes

Example:

```text
Photo:
[ Charger ]

Name:
MacBook Charger

Category:
Electronics

Location:
Desk Drawer

Notes:
White charger, 67W
```

---

# 4.2 AI Item Recognition

AI can optionally analyze the photo.

Example:

User photographs a black wallet.

AI suggests:

> **Possible item:** Wallet

User confirms:

> [Use Wallet]

The user can edit the name.

AI should never silently create incorrect records.

### AI Suggestions

Possible:

- Object type
- Category
- Color
- Basic description
- Useful tags

Example:

```text
Detected:

Object: Headphones
Color: Black
Category: Electronics
```

---

# 4.3 Location Memory

Every item should have a remembered location.

Locations can be hierarchical:

```text
Home
 ├── Bedroom
 │    ├── Wardrobe
 │    └── Bedside Drawer
 │
 ├── Office
 │    ├── Desk
 │    └── Cabinet
 │
 └── Kitchen
      ├── Drawer
      └── Cabinet
```

This makes locations more useful than simply storing a text field.

---

# 4.4 Quick Location Selection

When adding an item, location selection should be extremely fast.

Example:

```text
Where did you put it?

🏠 Home
🛏 Bedroom
🗄 Drawer
🖥 Desk
📦 Storage
➕ Add new location
```

Recently used locations should appear first.

---

# 4.5 Search

Search should be one of the most important features.

User can search:

- Item name
- Category
- Location
- Tags
- Notes

Examples:

```text
passport
charger
keys
documents
bedroom
black
```

Search results should appear instantly.

---

# 4.6 Natural Language Search

Future feature.

Instead of typing exact names, user can ask:

> "Where is my black charger?"

or:

> "Show me the documents I saved."

or:

> "What did I put in the bedroom drawer?"

The app searches the user's saved item data.

This can initially be implemented with local keyword matching and later enhanced with AI.

---

# 4.7 Item Detail Page

Every item gets a dedicated detail screen.

Example:

```text
← Item

        [ LARGE PHOTO ]

MacBook Charger

📍 Desk Drawer
🏷 Electronics

Last Updated
17 Aug 2026 — 4:32 PM

Notes
White 67W charger

History
• Added to Desk Drawer
• Location changed from Bedroom
```

Actions:

- Edit
- Move
- Add photo
- Archive
- Delete
- Share

---

# 4.8 Move Item

Items move.

Example:

```text
MacBook Charger

Current:
Desk Drawer

[ Move Item ]

Where did you put it?

Bedroom
Office
Bag
Other
```

The old location should be stored in history.

---

# 4.9 Item History

Maintain a lightweight history.

Example:

```text
MacBook Charger

17 Aug
📍 Desk Drawer

12 Aug
📍 Office Cabinet

05 Aug
📍 Backpack
```

This creates an important feature:

> **"Where did I last keep it?"**

---

# 4.10 Categories

Default categories:

- 🔑 Keys
- 📱 Electronics
- 📄 Documents
- 💳 Cards
- 🎒 Bags
- 👕 Clothing
- 🧰 Tools
- 💊 Personal
- 🏠 Household
- 💍 Accessories
- 📦 Other

Users can create custom categories.

---

# 4.11 Favorites

Users can mark important items as favorites.

Examples:

- Passport
- ID documents
- Car keys
- Laptop charger
- Important files

Favorites appear on the home screen.

---

# 4.12 Important Items

Allow users to mark items as:

> ⭐ Important

Important items can receive extra visibility and optional reminders.

---

# 4.13 Recently Added

Home screen should show:

> Recently Remembered

Example:

```text
MacBook Charger
Passport
Car Keys
USB Cable
```

---

# 4.14 Recently Updated

Show items whose location was recently changed.

---

# 4.15 Location View

Instead of searching by item, users can browse by location.

Example:

```text
🏠 Home

Bedroom
  12 items

Office
  8 items

Kitchen
  17 items

Storage
  23 items
```

Tap Bedroom:

```text
Bedroom

🔑 Keys
📘 Passport
🎧 Headphones
🔌 Charger
```

---

# 4.16 Smart Suggestions

The app can learn repeated patterns.

Example:

User repeatedly stores keys in:

> Entrance Drawer

App can suggest:

> "You usually keep your keys in Entrance Drawer."

This should be presented as a suggestion, not an automatic change.

---

# 4.17 Reminders

Optional reminders.

Examples:

> "Did you put your passport back after your trip?"

> "You marked this item as important."

Reminder system should be user-controlled.

Do not spam notifications.

---

# 5. Onboarding

Onboarding should be short.

Maximum:

**3–4 screens.**

## Screen 1 — Problem

Large visual:

Lost keys / searching drawer.

Text:

> **Forget where you put things?**

Subtext:

> Save a visual memory of your belongings and find them later.

Button:

> Get Started

---

## Screen 2 — How It Works

Three steps:

```text
📸 Capture
Take a photo

📍 Remember
Tell us where you put it

🔎 Find
Search whenever you forget
```

Button:

> Continue

---

## Screen 3 — Privacy

Because personal belongings can be sensitive.

Text:

> **Your memories belong to you.**

Explain:

- Photos are private
- Data stays on device by default
- Cloud backup is optional
- User controls deletion

Button:

> Continue

---

## Screen 4 — First Item

Do not send the user to an empty dashboard.

Immediately ask:

> **Let's remember your first thing.**

Button:

> 📸 Add My First Item

Suggested examples:

- Keys
- Wallet
- Charger
- Passport

This gets the user to the core value immediately.

---

# 6. Home Screen UX

The home screen should be extremely clean.

### Recommended layout

```text
Good morning 👋

Where did I put...

[ 🔎 Search your things ]

⭐ Important
[ Passport ] [ Car Keys ]

Recently Remembered
[ Charger ]
[ Headphones ]
[ Documents ]

📍 Locations
Home · 42
Office · 12

        + Add Item
```

The **Search** field and **Add Item** button should dominate the interface.

---

# 7. Bottom Navigation

Recommended:

```text
Home
Search
Locations
Favorites
Settings
```

Alternative:

```text
Home
Items
Locations
+
Settings
```

The central `+` action can be a floating action button.

---

# 8. Add Item Flow

## Step 1

User taps:

> +

## Step 2

Camera opens.

Options:

```text
📸 Take Photo
🖼 Choose from Gallery
```

## Step 3

AI analyzes image.

Example:

> We think this is a **charger**.

User can accept/edit.

## Step 4

Location:

> Where did you put it?

## Step 5

Optional:

> Add notes

## Step 6

Save:

> **Remembered ✓**

Small confirmation animation.

---

# 9. Visual Design Direction

The UI should feel:

- Modern
- Calm
- Premium
- Minimal
- Friendly
- Fast

Avoid:

- Overloaded dashboards
- Too many colors
- Excessive cards
- Complicated forms
- Excessive animations

### Visual language

Use:

- Large whitespace
- Rounded cards
- Large item photos
- Simple icons
- Clear typography
- Subtle shadows
- Smooth transitions

The product should feel like a **premium personal memory app**, not an inventory management system.

---

# 10. Color Direction

Recommended base:

- Off-white / light background
- Dark text
- One strong accent color

Optional dark mode.

Avoid using many accent colors.

Categories can have subtle icon colors but should not dominate the UI.

---

# 11. Important UX Principle

The app should always answer:

> **"Where is it?"**

within as few interactions as possible.

Ideal flow:

```text
Open app
 ↓
Search
 ↓
Item
 ↓
Location
```

Target:

**3 taps or less.**

---

# 12. Smart Search Experience

Search screen:

```text
Search your things

[ 🔎 passport ]

Results

📘 Passport
Bedroom Cupboard

📄 Visa Documents
Office Cabinet
```

Search should support fuzzy matching.

If user types:

> pass

It should find:

> Passport

If user types:

> black

It can find items tagged/described as black.

---

# 13. Empty States

Never show blank screens.

### No Items

> You haven't remembered anything yet.

> Start with something you often lose.

Button:

> Add Item

### No Search Results

> Couldn't find that.

Suggestions:

> Try:
> - keys
> - charger
> - passport
> - documents

---

# 14. Notifications

Keep notifications useful.

Examples:

### Reminder

> 📘 Don't forget your passport before your trip.

### Smart Reminder

> You usually keep your keys in the entrance drawer.

### Important Item

> ⭐ Your passport hasn't been updated in 6 months.

Notifications should be optional.

---

# 15. Gamification

Do not turn this into a game.

Light gamification only:

```text
You've remembered 27 things 🎉
```

Possible milestones:

- First Item
- 10 Items
- 50 Items
- 100 Items

Avoid aggressive streak mechanics.

The core value is utility.

---

# 16. AI Features

AI should support the core product rather than become the product.

## V1 AI

- Object recognition
- Category suggestion
- Basic description
- Tag suggestions

## V2 AI

- Natural language search
- Smart location suggestions
- Duplicate item detection
- Similar item detection

## V3 AI

User can ask:

> "Where is my black USB cable?"

> "What things are in my office drawer?"

> "Which important items are stored at home?"

The system converts the query into a structured search against the user's data.

---

# 17. Privacy & Security

This product can contain sensitive information.

Privacy should be a core product feature.

## Local First

Recommended:

```text
User
 ↓
Flutter App
 ↓
Local Database
 ↓
Encrypted local data
```

Cloud should be optional.

If cloud backup is implemented:

```text
Device
 ↓
Encrypted data
 ↓
Secure backend
```

Never assume that users want their personal belongings uploaded automatically.

---

# 18. Data Model

Core entities:

## Item

```text
id
name
description
categoryId
locationId
imagePath
isFavorite
isImportant
createdAt
updatedAt
archivedAt
```

## Location

```text
id
name
parentId
type
createdAt
updatedAt
```

Example:

```text
Home
 └── Bedroom
      └── Drawer
```

## Item History

```text
id
itemId
locationId
action
createdAt
```

Actions:

- Created
- Moved
- Updated
- Archived

## Category

```text
id
name
icon
createdAt
```

## Reminder

```text
id
itemId
title
scheduledAt
isEnabled
```

---

# 19. Flutter Architecture

Recommended architecture:

```text
lib/
│
├── core/
│   ├── theme/
│   ├── routing/
│   ├── constants/
│   ├── errors/
│   └── utils/
│
├── features/
│   │
│   ├── onboarding/
│   ├── home/
│   ├── items/
│   ├── search/
│   ├── locations/
│   ├── favorites/
│   ├── reminders/
│   ├── ai/
│   └── settings/
│
├── data/
│   ├── database/
│   ├── repositories/
│   └── services/
│
└── main.dart
```

Use clean separation between:

- Presentation
- Domain
- Data

State management can use:

**Riverpod / Provider / GetX**

Prefer the state-management system already familiar to the developer.

---

# 20. Local Database

Recommended options:

### Drift / SQLite

Good for:

- Items
- Locations
- History
- Search
- Offline-first architecture

Photos should not be stored directly as large blobs in SQLite.

Store:

```text
imagePath
```

and keep image files in application storage.

---

# 21. Image Processing

Images should be optimized before storage.

Pipeline:

```text
Camera
 ↓
Resize
 ↓
Compress
 ↓
Store locally
 ↓
Generate thumbnail
```

Store:

- Original/optimized image where necessary
- Thumbnail for lists

This keeps the app fast and storage-efficient.

---

# 22. Search Architecture

For V1:

Use local database search.

Search fields:

- Name
- Description
- Category
- Location
- Tags

For larger datasets:

- Indexed search
- Fuzzy matching
- Full-text search

AI search can be layered later.

---

# 23. Monetization

The app should not become annoying because of ads.

## Free

- Basic item storage
- Basic search
- Locations
- Item history
- Basic AI suggestions

## Ads

Possible:

- Small banner on non-critical screens
- Occasional interstitial after completed workflows
- Rewarded ad for premium AI action

Avoid:

- Ads while searching
- Ads when opening an important item
- Full-screen ads on every action

## Pro

Possible:

- Unlimited items
- Advanced AI search
- Advanced recognition
- Cloud backup
- Encrypted sync
- Advanced reminders
- No ads
- Family/shared spaces

Possible pricing:

- Monthly subscription
- Yearly subscription
- Lifetime purchase

A lifetime option may work well for a utility-style app.

---

# 24. MVP

The first release should be small.

### MVP Features

- Onboarding
- Add item
- Camera/gallery
- Item name
- Category
- Location
- Item detail
- Search
- Favorites
- Move item
- Item history
- Local database
- Basic reminders
- Basic AI recognition

Do NOT initially build:

- Social features
- Family sharing
- Cloud sync
- Complex AI
- Advanced analytics

---

# 25. V1

Add:

- Better AI recognition
- Smart suggestions
- Location hierarchy
- Better search
- Duplicate detection
- Important item reminders
- Dark mode
- Backup/export

---

# 26. V2

Add:

- Natural language search
- Cloud sync
- Encrypted backup
- Family spaces
- Shared items
- Advanced AI
- Widgets
- Voice input

---

# 27. Future Features

Possible long-term features:

### Voice

> "Remember that I put my passport in the bedroom drawer."

### Widget

```text
Where is it?

[ 🔎 Search ]
```

### Quick Add

Android shortcut:

> Add Item

### Lock Screen / Quick Search

Fast access for urgent searches.

### Family

Shared household inventory.

### Travel Mode

Before travel:

> Passport ✓
> Tickets ✓
> Charger ✓
> Adapter ✓

### Packing Mode

Select trip → create temporary item checklist.

---

# 28. Key Product Differentiator

The app should NOT market itself as:

> "Inventory Management"

That sounds boring and complicated.

Market it as:

> **"A memory for your things."**

or:

> **"Remember where you put it."**

The emotional problem is:

> **"I know I put it somewhere... but where?"**

The app solves that moment.

---

# 29. ASO Direction

Potential Play Store keywords:

- where did I put it
- find my stuff
- remember where things are
- item tracker
- home inventory
- personal inventory
- remember things
- find belongings
- lost items
- organize belongings

### Possible Store Title

**Where Did I Put It? — Find Things**

### Short Description

> Remember where you put your things. Save photos, locations and notes and find them instantly.

---

# 30. App Store Screenshots

Recommended screenshot sequence:

### Screenshot 1

Headline:

> **Never forget where you put it again.**

Visual: beautiful item + location.

### Screenshot 2

> **Remember with a photo.**

Show Add Item.

### Screenshot 3

> **Find it in seconds.**

Show search.

### Screenshot 4

> **Know exactly where it is.**

Show location hierarchy.

### Screenshot 5

> **Your things. Your memory.**

Show item history.

### Screenshot 6

> **Private by design.**

Show privacy controls.

---

# 31. Success Metrics

Track:

### Activation

Percentage of users who add their first item.

### Core Usage

- Items added per user
- Searches per user
- Items viewed
- Items moved
- Locations created

### Retention

- Day 1
- Day 7
- Day 30

### Monetization

- Ad impressions
- Rewarded ad completion
- Pro conversion
- Lifetime purchase conversion

Most important metric:

> **How often does a user successfully find something they previously saved?**

---

# 32. Product Risks

## Risk 1 — User forgets to add items

Solution:

- Make adding extremely fast
- AI recognition
- Quick Add
- Widget
- Voice input

## Risk 2 — App feels like boring inventory software

Solution:

- Visual UI
- Large photos
- Minimal forms
- Natural language
- Fast search

## Risk 3 — Users don't return

Solution:

The app is naturally opened when they forget something.

Add:

- Important items
- Reminders
- Recently remembered
- Smart suggestions

Avoid unnecessary notification spam.

---

# 33. Development Strategy

Do not ask an AI coding agent:

> "Build the whole app."

Build sequentially:

### Phase 1

Project foundation + theme + navigation.

### Phase 2

Onboarding.

### Phase 3

Item creation.

### Phase 4

Local database.

### Phase 5

Locations.

### Phase 6

Search.

### Phase 7

Item history.

### Phase 8

AI recognition.

### Phase 9

Reminders.

### Phase 10

Monetization.

### Phase 11

Testing.

### Phase 12

Play Store release.

After each phase:

1. Run app
2. Test feature
3. Fix errors
4. Commit changes
5. Move to next phase

---

# 34. AI Development Strategy

AI can handle a large part of implementation.

Use AI for:

- Flutter code
- UI implementation
- Database schemas
- Repositories
- State management
- API integration
- AI integration
- Tests
- Refactoring
- Bug fixing
- Documentation

Human testing is especially important for:

- Camera
- Image storage
- Permissions
- Notifications
- Device storage
- Performance
- App lifecycle
- Android-specific behavior

---

# 35. Final Product Vision

The long-term vision is:

```text
             WHERE DID I PUT IT?
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
        ITEMS       LOCATIONS     SEARCH
          │            │            │
          └────────────┼────────────┘
                       ↓
                VISUAL MEMORY
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
        AI          HISTORY      REMINDERS
          │            │            │
          └────────────┼────────────┘
                       ↓
                PERSONAL MEMORY
```

The product should start simple:

> **"Save where you put your things."**

Then evolve into:

> **"A searchable visual memory of everything you own."**

---

# 36. MVP Definition of Done

The first production-ready version is complete when a user can:

1. Install the app.
2. Complete onboarding.
3. Add an item with a photo.
4. Name the item.
5. Assign a location.
6. Save it locally.
7. Search for it later.
8. Open its detail page.
9. See its current location.
10. Move it to another location.
11. See its location history.
12. Mark it important/favorite.
13. Receive an optional reminder.
14. Use the app without internet for core functionality.
15. Delete/export their data.

The core experience should feel:

> **Fast → Visual → Private → Simple → Useful.**

---

# 37. One-Line Product Definition

> **Where Did I Put It? is a private visual memory assistant that remembers where users keep their belongings so they can find anything later in seconds.**
