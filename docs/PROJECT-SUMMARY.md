# Project Summary — Toy & Game Swapping App

## 1. Project Background

**Team**: Venonat — Ruotong Tang, Shenghua Chen, Xiaoman Zhou, Yushu Wang

### What is this project?

A mobile application design project for a **Toy & Game Swapping App** — a community-driven platform where users can donate, swap, and discover toys or games. The project covers the full UX design lifecycle: user research, prototyping, accessibility implementation, and usability iteration.

### Why this project?

Many families accumulate unused toys and games that take up space but have no convenient way to pass them on. Existing solutions (marketplace apps, charity drop-offs) are often impersonal, complicated, or raise trust and safety concerns. This project addresses the gap by designing a platform that is:

- **Simple**: Minimal effort to list, swap, or donate items
- **Safe**: Verified profiles, trust scores, and transparent reviews
- **Community-driven**: In-app messaging, comments, and social verification

---

## 2. User Research — Questionnaire Survey

The project started with a **15-question online questionnaire** distributed via social media and personal networks (convenience sampling). **38 valid responses** were collected.

**Questionnaire link**: https://forms.gle/SmYFwo8EpwJjPLZa6

### Key Findings

| Finding | Data |
|---------|------|
| Respondents aged 18–34 | 81.5% (31/38) |
| High-frequency app users (7+ times/day) among 18–34 | ~74% |
| Financial situation: "manageable but careful budgeting" | 50% (19/38) |
| Currently store/keep unused toys (not circulating) | 57.9% (22/38) |
| Trust through clear safety policies | 71.1% (27/38) |
| Trust through verified accounts | 44.7% (17/38) |
| Trust through reviews/ratings | 44.7% (17/38) |
| App confidence: younger users (18–34) | 3.8/5 |
| App confidence: older users (35+) | 2.9/5 |

### Cross-Analysis Highlights

- **Age vs. app usage**: 74% of users aged 18–34 used apps 7+ times/day vs. 25% of those 35+.
- **Living situation vs. toy disposal**: 65% of respondents with children donated/swapped, while 70% of single-person households stored or discarded.
- **Experience vs. trust**: Experienced users focused on navigation; inexperienced users prioritized privacy concerns.
- **Age vs. toy preferences**: 18–24 preferred video/board games; 35+ preferred children's/educational toys.

### Identified User Groups

1. **Parents with young children (0–10 years)** — Declutter and save budget through swapping
2. **Donors who value social impact** — Prefer giving over discarding
3. **Trust-focused community members** — Need verified profiles and reviews before engaging

---

## 3. Design Process — Four Phases

### Phase 1: User Research & Data Gathering

**Deliverable**: [User Research & Data Gathering Report](../FIT5152-Sub1-Applied08-TeamVenonat.pdf)

- Designed and distributed a 15-question questionnaire
- Analyzed 38 responses with individual question insights and cross-analysis
- Identified data gaps and future research directions
- Developed **4 personas** based on survey data:
  - **Maria Chen** (53, mother) — Wants to donate easily, needs verified profiles for trust
  - **Emily Zhang** (26, working professional) — Needs intuitive, fast processes
  - **Emily Chen** (19, student) — Budget-conscious, needs clear safety signals
  - **Alex Joe** (25–34, single male) — Digitally savvy but cautious, values efficiency
- Each persona includes data-backed user stories and functional requirements

### Phase 2: Low-Fidelity Prototyping

**Deliverable**: [Low-Fidelity Prototyping Report](../FIT5152-Sub2-Applied08-xiaoman%20zhou.pdf)

- Translated user stories into wireframes and storyboards
- Created a Kanban board with acceptance criteria
- Designed 3 annotated wireframe screens:
  1. **Safety Dashboard** — Trust score, verification badges, report button (Norman: Signifiers; WCAG: Perceivable)
  2. **Quick Item Posting** — Camera/voice input, auto-fill, 3-step flow with undo (Norman: Perceived Affordances; WCAG: Operable)
  3. **Home Dashboard** — Quick actions, safety center access, consistent layout (Norman: Natural Mapping; WCAG: Understandable)

### Phase 3: High-Fidelity Prototype

**Deliverable**: [High-Fidelity Prototype & Report](../FIT5152-Sub3-Applied8-TeamVenonat.pdf)

- Built an interactive **Figma prototype** with 8 key screens:
  - Home, Profile, Messages, Chat, Add Post, Post Detail, Category, Detail Category
- Applied visual design principles: hierarchy, balance, proximity, common region, repetition
- Implemented **WCAG accessibility**:
  - **Perceivable** (1.4): Text spacing, non-text contrast
  - **Operable** (2.4/2.5): Focus visibility, single-tap navigation, adequate touch targets
  - **Understandable** (3.2): Predictable navigation, consistent layout on focus changes
- Conducted **individual heuristic evaluations** (each team member evaluated 3 heuristics with evidence, severity ratings, and recommendations)

### Phase 4: Usability Improvements

**Deliverable**: [Usability Improvements Report](../FIT5152-Sub4-Applied8-TeamVenonat.pdf)

Four key improvements were implemented based on heuristic evaluation findings:

| Improvement | Problem | Solution | Impact |
|-------------|---------|----------|--------|
| Completion status visibility | Users saw "20%" but didn't know what affected it | Added "3/7 required fields filled" microtext + asterisk markers | 30% faster post completion (60s to 40s) |
| Error feedback | No visible error messages for invalid actions | Implemented validation pop-ups | 20% reduction in troubleshooting time |
| Tap target accuracy | Low contrast and tight spacing caused slip errors | Increased touch targets to 44x44pt (Apple HIG / WCAG 2.5.5) | Lower error rate, higher activation rate |
| Icon consistency | "Like" used different icons (thumbs-up vs heart) across screens | Unified to one consistent icon | Reduced cognitive load, faster recognition |

---

## 4. Key Design Principles Applied

- **Norman's Design Principles**: Signifiers, Perceived Affordances, Natural Mapping, Discoverability
- **WCAG Accessibility**: Perceivable, Operable, Understandable
- **Shneiderman's 8 Golden Rules**: Consistency, Informative Feedback, Easy Reversal
- **Nielsen's Heuristics**: Visibility of System Status, Match with Real World, Consistency, Error Prevention
- **Gestalt Principles**: Proximity, Common Region
- **Visual Design**: Hierarchy, Balance, Repetition

---

## 5. Tools & Methods

- **Research**: Google Forms questionnaire, convenience sampling, cross-analysis
- **Design**: Figma (prototyping), Canva (personas)
- **Evaluation**: Heuristic evaluation (Nielsen's 10 heuristics), severity rating scale
- **Project management**: Kanban board, acceptance criteria
- **Accessibility**: WCAG 2.1 guidelines (AA/AAA compliance targets)

---

## 6. Figma Prototype Links

- **Final interactive prototype**: https://www.figma.com/proto/1C4yp80zseu3UbK01CHoKe/UI--prototype?t=IsubJN44C6uf4jGf-1
- **Design file (High-Fidelity)**: https://www.figma.com/design/1oGt3Zm8GdxVj8aVvOMEaR/FIT5152-Sub3-Applied8-TeamVenonat?node-id=0-1
