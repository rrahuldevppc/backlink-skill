# QA / live-link validation

A link only counts once it has been verified **logged out**. Team-reported
"done" is not evidence.

Always check from a logged-out context — a plain HTTP fetch, or an isolated
browser. Never the user's own Chrome; it is signed in and will show you a page
the public cannot see.

## The four gates

**Gate 1 — Access.** Does the page load for the public?

| Verdict | Trigger |
|---|---|
| `404_NOT_FOUND` | HTTP 404 / 410 |
| `LOGIN_WALL` | login or sign-up wall, 401 |
| `INVALID_URL` | malformed URL, dead domain, other HTTP error |

A bare HTTP 403 is often bot-blocking (Cloudflare), not a real login wall.
Re-check those in a browser; only a 403 that *also* shows a login wall to a
logged-out human is a genuine `LOGIN_WALL`.

**Gate 2 — Link presence.** Is our target URL actually linked on the page?

- `LINK_FOUND` — a real anchor pointing at the target
- `MENTION_ONLY` — the URL appears as plain text, unlinked → verdict
  `TARGET_URL_MISSING`, reason "URL is text, not a link"
- `TARGET_URL_MISSING` — not there at all

Record `rel` (dofollow / nofollow). **Nofollow is reported, never a failure** —
most directory links are nofollow by design and still carry value.

Redirects are followed. If the final page contains the target, it passes; note
"redirected" in the reason.

**Gate 3 — Content completeness.** Score the page against what that listing type
should contain (description present and intact, image loaded, categories set,
not a stub). Below ~70% → `CONTENT_INCOMPLETE` with the score in the reason.

**Gate 4 — NAP.** For business listings only: does the business address appear
on the public page? If not → `ADDRESS_MISSING`.

## Index check (information only)

Run a `site:<live URL>` query. A matching organic result → indexed YES; empty →
NO. Throttle to 1–2 requests/second.

**Index status never fails a row.** New links routinely take 1–2 weeks.

## Verdict taxonomy

| Category | Verdict |
|---|---|
| ACCESS | `404_NOT_FOUND`, `LOGIN_WALL`, `INVALID_URL` |
| LINK | `TARGET_URL_MISSING` |
| CONTENT | `CONTENT_INCOMPLETE` |
| LISTING | `ADDRESS_MISSING` |
| OK | `SUCCESS` |

One row = one verdict. Info fields (rel, indexed) never change it.

## Writeback

Per row: verdict · category · one-line reason · rel · content score · indexed ·
checked-at timestamp. Append one run-log row: date · rows checked · success ·
each failure count · success rate · index rate.

## Issues list

For every actionable failure (`TARGET_URL_MISSING`, `404_NOT_FOUND`,
`INVALID_URL`, confirmed `LOGIN_WALL`), append a row to an `Issues` tab with the
fix needed — "add the link", "make the text a hyperlink", "rebuild the page",
"wrong live URL logged", "check public visibility". `PENDING_APPROVAL` rows are
not issues yet.

Then report counts per category, success rate and index rate in chat.

**Dry run**: do everything except the writeback and show the would-be verdicts.
