# DSBA PR & Operations Portal
**Deutsche Schule der Borromäerinnen Alexandria — Abteilung für Öffentlichkeitsarbeit & Unternehmenskommunikation**

Concept & Operational Execution by: **Amir Wahby** — Public Relations Manager (DSBA)
Contact: p.r@dsb-alexandria.de | Tel: +20 101 35 35 436

---

## 1. Brand Tokens

| Token | Value | Usage |
|---|---|---|
| `primaryCrimson` | `#D32F2F` | App bar, primary buttons, active nav badge, key CTA |
| `accentGold` | `#FBC02D` | Notification dots, active tab underline, highlight chips |
| `neutralDark` | `#212121` | Body text, dark-mode surface, icon fills |
| `neutralLight` | `#F8F9FA` | Screen canvas, card backgrounds |
| Font | Inter / SF Pro / Roboto | Full RTL (Arabic) + LTR (German/English) support |

Six pillars mapped from the operational handbook are used as the taxonomy across every module (catalog, ticket categories, KPI groupings):
1. Public Relations & Partnerships (العلاقات العامة والشراكات)
2. Consular Affairs & Visas (المعاملات القنصلية والتأشيرات)
3. Logistics & Field Trips (التخطيط واللوجستيات للرحلات)
4. Digital Media & Corporate Identity (الإعلام الرقمي والهوية المؤسسية)
5. Event Management (إدارة الاحتفاليات والفعاليات الكبرى)
6. Printing Center & Operational Support (وحدة تصوير الأوراق والدعم التشغيلي)

---

## 2. Screen Map & Navigation Structure

```
DSBA PR Portal (Bottom Nav — 4 tabs)
│
├── 1. Home / Dashboard
│    ├── Greeting header + role badge (Staff / Faculty / PR Admin)
│    ├── Quick-action grid (New Request, Track Request, Chat, Catalog)
│    ├── "My Open Requests" horizontal carousel (status chips)
│    └── Announcements feed (from Digital Media module)
│
├── 2. Services Catalog (Module A)
│    ├── 6-Pillar grid (icon + title, tap → detail)
│    │     └── Pillar Detail Screen
│    │          ├── Sub-service list (e.g. VFS Global tracking, Flight booking)
│    │          ├── "Request this service" CTA → prefills Request Form
│    │          └── SLA / turnaround info chip
│    └── Search bar (bilingual AR/EN service search)
│
├── 3. Requests (Module B — Ticketing)
│    ├── Tab: Active | Completed | All
│    ├── Request List Item (ticket #, pillar tag, status pill, last update)
│    ├── + Floating Action Button → New Request Form
│    │     ├── Step 1: Select Pillar / Service type
│    │     ├── Step 2: Details form (dynamic fields per service)
│    │     ├── Step 3: Attachments (ID scans, forms, exam files for printing)
│    │     └── Step 4: Review & Submit
│    └── Request Detail Screen
│         ├── Status Tracker (stepper: Pending → In Progress → Completed)
│         ├── Assigned PR staff + contact
│         ├── Activity timeline / notes
│         └── "Open Chat" button → Chat Screen (scoped to this ticket)
│
├── 4. Chat (Module B — Messaging)
│    ├── Conversation list (per active ticket + general PR office line)
│    └── Chat Thread Screen (bubbles, attachments, read receipts, quick replies)
│
└── ⋮ More / Profile (Drawer or 5th tab depending on platform)
     ├── Executive Dashboard (Module C — role-gated: PR Admin / Leadership only)
     │    ├── KPI cards (printing jobs, trips organized, events, media requests)
     │    ├── Charts (weekly/monthly trend, requests by pillar)
     │    └── "Export Report" → PDF generator (weekly/monthly/annual)
     ├── Settings (Language toggle AR/EN, Notifications, Theme)
     └── About / Footer credit block (school emblem, PR office contact,
         "Concept & Operational Execution by: Amir Wahby")
```

### Navigation notes
- Bottom nav (implemented, 5 tabs): **Home · Catalog · Requests · Chat · More**. The Requests tab hosts the Active/Completed/All ticket list with a floating "New Request" action. The Executive Dashboard lives inside **More → Settings**, gated by `role.canViewDashboard` (only `pr_admin` / `leadership`).
- RTL/LTR: the entire nav shell mirrors automatically based on `Directionality` (Flutter) — Arabic is the default locale for staff-facing UI, German/English available in Settings.
- Deep link pattern: `dsba://requests/{ticketId}`, `dsba://catalog/{pillarId}` for push notification routing.

---

## 3. Role Model
| Role | Access |
|---|---|
| `faculty` / `staff` | Submit requests, track own tickets, chat, browse catalog |
| `pr_staff` | All of the above + view/assign/update all tickets, respond in chat |
| `pr_admin` (Amir Wahby's role) | All of the above + Executive Dashboard, report export, catalog editing |
| `leadership` (Schulleitung) | Read-only Executive Dashboard + report export |

---

## 4. Data Models (JSON Schemas)

See `/schemas` folder:
- `user.schema.json`
- `request.schema.json`
- `report.schema.json`
- `chat_message.schema.json`

---

## 5. Code Deliverables (Flutter)

```
lib/
├── main.dart                      # App entry, theme + routing
├── theme/app_theme.dart           # Color tokens, text theme, component themes
├── models/
│   ├── pr_request.dart
│   ├── app_user.dart
│   └── chat_message.dart
├── services/mock_data_service.dart# Mock/local data layer (swap for REST/Firebase)
├── screens/
│   ├── dashboard_screen.dart      # Module A/B/C entry, quick actions, open requests
│   ├── services_catalog_screen.dart
│   ├── requests_list_screen.dart  # Module B: Active/Completed/All ticket list + FAB
│   ├── request_form_screen.dart   # Module B: multi-step request creation
│   ├── request_tracker_screen.dart# Live status stepper
│   ├── chat_screen.dart           # Module B: direct messaging
│   ├── executive_dashboard_screen.dart # Module C: KPIs + PDF export sheet
│   ├── settings_screen.dart       # Role-gated dashboard entry + footer
│   └── about_footer_widget.dart   # Reusable credit footer (Module 3 requirement)
└── widgets/
    ├── pillar_card.dart
    ├── status_pill.dart
    └── kpi_card.dart

assets/
└── branding/
    └── dsba_logo.jpg              # Official emblem, used in AppBar + About footer
```

React Native equivalent mapping (if that stack is preferred instead of Flutter):
- `theme/app_theme.dart` → `theme/colors.ts` + `NativeBase`/`Tamagui` theme config
- Screens → React Navigation stack/tab screens under `src/screens/`
- `mock_data_service.dart` → `src/services/api.ts` (Axios/Fetch layer, same JSON contracts below)
- State: Riverpod/Bloc in Flutter ↔ Redux Toolkit/Zustand in RN — data models are stack-agnostic since they're plain JSON schemas.

Since only one stack can be shipped as working code here, **Flutter** is implemented in full below (Dart is strongly typed and maps 1:1 to the JSON schemas, and single-codebase iOS/Android fits a school's small dev budget). The JSON schemas are stack-agnostic so a React Native rebuild is a direct port.
