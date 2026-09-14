---
name: backlink-builder
description: End-to-end backlink production — pick sites from the site database, generate ready-to-paste content packs, fill and submit listing forms in the team's logged-in Chrome tabs, capture live URLs into the tracking sheet, and QA every link logged-out. Covers all five off-page tiers (directories/citations, web 2.0, doc & infographic distribution, video, outreach). Use when the user says "dispatch banao", "batch chalao", "backlink banao", "directory submission", "content pack banao", "backlink validator chalao", or asks to build/verify off-page links.
---

# Backlink Builder

One skill for the whole off-page loop:

**shortlist → pack → team logs in → fill + submit → live URL to sheet → QA → next batch**

A batch is one client × one category × N sites (default 10).

## 0. First run — load config

Read `config.yml` from the repo root (created by `install.sh` from
`config.example.yml`). It holds the sheets account, the Control sheet ID, tab
names, forbidden credential ranges and batch defaults.

If `config.yml` is missing or any value is still `REPLACE_ME`, **stop** and tell
the user exactly which field to fill. Never guess a sheet ID and never fall back
to a different spreadsheet.

## 1. Division of labour — the hard boundary

| Claude does | The human does |
|---|---|
| Pick sites from the Site DB, ranked | Account signup |
| Write the content pack (paste-ready) | Enter the password |
| Fill every form field, pick category, upload image | Solve CAPTCHA |
| Click submit | Enter phone/SMS OTP |
| Capture the public live URL | Finish anything Claude marked BLOCKED |
| Write the sheet rows, metrics, playbooks | — |
| Run QA on every live URL | — |

**Claude never** creates accounts, types or reads passwords, or solves/bypasses
CAPTCHA. This is policy *and* a ban-risk decision — a burned account costs more
than a saved minute. Do not offer to automate these steps.

Email verification is the one grey area: if a mail connector is configured for a
shared team inbox, Claude may open the confirmation mail and click the verify
link. Never a personal inbox.

**Forbidden ranges** from `config.yml` are radioactive. Never read, write, or
quote them — even if they appear in a tool response. Per-client tabs that hold
credentials are never opened at all.

## 2. Wizard (bare invocation)

When invoked with no arguments ("dispatch banao"), ask — don't assume:

1. **Which client/product?** — options come from the registry tab. Unknown name
   → offer to add a registry row first, never invent one.
2. **Which category?** — see the tier table in `references/tiers.md`.
3. **How many sites?** — default from config (10).

Then build the shortlist per `references/site-selection.md`, **show it with
ratings and wait for an explicit "go"** before writing any Dispatch rows. The
user can swap sites by name.

## 3. Batch lifecycle

1. **Dispatch prep** — read the registry row fresh (keywords change often; never
   cache them from a previous batch). Build the shortlist. Generate packs per
   `references/content-packs.md`. Write Dispatch rows as `AWAITING_LOGIN`.
2. **Notify** — post the numbered site list + submission URLs to the configured
   channel, or print it in chat for the user to forward: *"Batch #N — in sites
   pe login karke 'batch #N ready' bolo."*
3. **Wait for "batch #N ready"** — mark rows `READY`, stamp Login-done-at.
4. **Fill + submit** — one tab at a time, per `references/directory-submission.md`.
5. **Sheet update** — Dispatch row per site + the category's data tab. Append one
   `Metrics` row for the batch.
6. **QA** — run the checks in `references/validation.md` on the batch's live URLs.
7. **Next batch** — prep batch #N+1 immediately so the team's login work and
   Claude's submit work run in parallel.

### Status state machine

```
QUEUED → AWAITING_LOGIN → READY → SUBMITTED ─────────→ VALIDATED
                                ├─ BLOCKED             (after QA passes)
                                ├─ PENDING_APPROVAL
                                ├─ AWAITING_EMAIL_VERIFY
                                └─ OUTCOME_UNKNOWN
```

- `BLOCKED` — CAPTCHA / payment / OTP hit mid-flow. Record the reason in Notes.
- `PENDING_APPROVAL` — the site moderates listings. Normal. Wait.
- `OUTCOME_UNKNOWN` — submit clicked, result unclear. **Never blind-retry.**
  Check the site's dashboard, the public page, and the inbox first. A duplicate
  listing is worse than a delayed one.

## 4. Execution rules (browser)

All form work happens through the Claude in Chrome tools
(`mcp__claude-in-chrome__*`). Load them in ONE call:

```
select:mcp__claude-in-chrome__tabs_context_mcp,mcp__claude-in-chrome__navigate,mcp__claude-in-chrome__read_page,mcp__claude-in-chrome__find,mcp__claude-in-chrome__form_input,mcp__claude-in-chrome__computer,mcp__claude-in-chrome__tabs_create_mcp
```

Call `tabs_context_mcp` first — the directory and the tracking sheet are usually
already open and signed in. Never drive the host OS with raw clicks.

- **Verification-first preflight** — before typing anything, open the form
  read-only and surface the earliest CAPTCHA/OTP/payment wall. Walls found up
  front go to the human queue in one sweep instead of interrupting mid-fill.
- **Idempotency check** — skip any site whose (root domain × client) already has
  a SUBMITTED / LIVE / PENDING row anywhere in Dispatch history.
- **Playbook first** — if `playbooks/<domain>.md` exists, follow it instead of
  re-discovering the form.
- **Scope** — a "go" covers exactly that batch's enumerated fill+submit actions,
  including category picks and a standard terms checkbox. Anything beyond —
  payment, phone verify, unexpected permissions — pauses that site.

## 5. Playbooks (process memory)

After every submit on a site, success or blocked, write or update
`playbooks/<domain>.md` using `references/playbook-template.md`: the steps that
actually worked, pack-field → form-field mapping, the site's category
vocabulary, image requirements, where the live URL appears, approval delay, and
what blocked where. Stamp `Last verified: <date>`.

Next time that site comes up, read the playbook and fill directly. Commit and
push playbooks — one member's learning becomes the whole team's.

**Playbooks hold process only.** Never credentials, never client content.

## 6. Content rules (non-negotiable)

- Every fact in a pack comes from the registry or the client's own live website.
  Fetch the site once per run. **Never invent** services, awards, reviews,
  founding dates, credentials or staff.
- If the registry row is incomplete, stop for that client and say which field is
  missing. Skip the site rather than guess a NAP.
- **Descriptions must be unique per site.** Reusing the same paragraph across
  directories is the single biggest duplicate-content footprint.
- **Never write or solicit fake reviews.** On review sites we create the company
  profile only; reviews come from real users.
- **Communities** (Reddit, Hacker News, LinkedIn, Indie Hackers) — Claude
  produces a draft only. The human posts it from their own account in their own
  voice. Never auto-post.
- **Tech media** (TechCrunch-class) are PR pitches, not listings. Route them out
  of the batch.
- Pack content is clean English — it gets pasted onto public pages. Hinglish is
  fine in team-facing notes.

## 7. Reporting

After every batch, report in chat: submitted / blocked (with reasons) /
pending-approval counts, total minutes, links per hour, and the next batch
number. On request, weekly totals per client and per category with the validated
success rate.

## References

| File | Read it when |
|---|---|
| `references/directory-submission.md` | Filling and submitting any listing form |
| `references/site-selection.md` | Building a shortlist / ranking sites |
| `references/content-packs.md` | Writing the pack for a site |
| `references/validation.md` | Running QA on live URLs |
| `references/tiers.md` | Choosing a category / planning beyond directories |
| `references/playbook-template.md` | Recording a site's process after a submit |
