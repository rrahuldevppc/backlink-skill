# Site selection

How a shortlist gets built. Bad site selection wastes the whole batch — a link
on a site Google does not index is worth exactly zero.

## Source

The `Site DB` tab of the Control sheet. Typical columns:

Site · URL · Category · Bucket · DA · Spam % · **Auto Rating** · Login Type ·
Submission URL · Proven Live · Last Used · Notes · **G-Index**

## Auto Rating legend

| Rating | Meaning |
|---|---|
| 🟢 `AUTO-FULL` | After login, Claude completes it 100% |
| 🟡 `PARTIAL` / `OTP` / `VERIFY` / `APPROVAL` | Claude fills, human finishes or the site moderates |
| 🔴 `PITCH-ONLY` | Media site — a PR pitch, not a listing |
| 🔴 `HUMAN-POST` | Community — Claude drafts, human posts |
| 🔴 `HUMAN-ONLY` / `LOW-DA` / `DEAD` | Excluded from auto batches |
| ⚪ `UNTESTED` | Never attempted |

`(est)` means the rating is a guess. After the first real attempt, replace it
with what actually happened and drop the `(est)`.

## G-Index (does Google pick up this site's new pages?)

| Verdict | Rule |
|---|---|
| 🟢 `ACTIVE` | Fresh pages indexed in the last 30 days — **build here first** |
| 🟢 `MAJOR` | Famous platform, check skipped |
| 🟡 `SLOW` | Indexed, but nothing fresh in 30d — usable, slow |
| 🟠 `THIN` | 1–2 pages indexed — bottom of the list only |
| 🔴 `NOT-INDEXED` | **Exclude.** Zero benefit. |
| ⚪ `NO-URL` | Add the URL, then re-check |

Re-run the index check monthly.

## Ranking order

1. Exclude every site already used for **this client** (Dispatch history +
   category data tab). Normalize to root domain first — city subdomains like
   `city-state.example-classifieds.com` count as the same root domain.
2. Exclude 🔴 ratings and 🔴 NOT-INDEXED.
3. Then rank:
   - 🟢 AUTO-FULL + 🟢 ACTIVE
   - 🟢 AUTO-FULL + 🟡 SLOW
   - ⚪ UNTESTED but `Proven Live = YES` for another client
   - 🟡 ratings, flagged so the human knows they'll need to finish
   - 🟠 THIN last
4. Prefer geo and niche relevance. A country-specific directory for a business
   in another country appears only at the bottom, marked
   `OPTIONAL — geo mismatch`.
5. Sites flagged from a competitor gap analysis, and missing Tier-1/2 citation
   directories, rank at the top — still subject to the rules above.

## If nothing qualifies

Say so, and say what is blocking: all used / all 🔴 / metrics missing / all
NOT-INDEXED. **Never relax the filters silently.**

## After every batch

Update the attempted sites' `Auto Rating` from what actually happened, plus
`Last Used`, `Proven Live`, and any quirk in Notes. The Site DB is the most
valuable asset in this system — every batch should leave it more accurate than
it found it.
