# Directory / listing submission

How to fill and submit one listing form in a logged-in tab. This is the Tier-1
workhorse — most batches are this.

## Before you type anything

1. `tabs_context_mcp` — the directory and the tracking sheet are usually already
   open and signed in. Reuse those tabs; don't open duplicates.
2. Confirm the **account shown is the expected one** ("You are currently signed
   in as …"). Wrong account → stop and tell the user.
3. If the page says *"You are editing an existing listing"*, click **Create a
   new Listing** — unless the intent really is an edit.
4. Check `playbooks/<domain>.md`. If it exists, follow it and skip discovery.
5. **Preflight**: `read_page` the empty form and note where the CAPTCHA /
   phone-verify / payment step sits. Report all of a batch's walls together.

## Inputs required

Ask for anything missing, one item at a time. Never invent:

- Site name and URL
- Public contact email
- Country / region
- Description paragraph (~60–90 words) — from the pack, or drafted from the
  client's own homepage. Factual, no hype, naming what the site actually covers.
- Which directory
- The tracking sheet (from `config.yml`)

## Fill

Use `form_input` where possible; fall back to `computer` clicks for custom
dropdowns and searchable selects (type the value, then pick from the list).

Typical field map — adapt per site, record the real one in the playbook:

| Pack field | Common form label |
|---|---|
| Business / listing name | Listing Name, Title, Business Name |
| Country | Location, Listing Region (searchable dropdown) |
| Contact email | Contact Email/URL |
| Category | Listing Category — tick the closest box |
| Short description | Tagline, Summary |
| Long description | Description |
| Website | Website — **full URL with `https://` and trailing slash** |
| Phone / logo / cover / video | Leave blank unless supplied |

Then tick **Terms and Conditions**.

## Submit

1. **Preview first** where the site offers it. Read the preview and confirm the
   description, website link and email all rendered correctly.
2. Submit.
3. **Capture the live URL from the address bar** after the redirect — not from a
   hover tooltip, not from a dashboard link. The public listing URL is the only
   one that passes QA.
4. Close any ad overlay or vignette (use its `Close` link) before reading the
   page. These directories are ad-heavy and iframes will sit on top of buttons —
   close them rather than clicking through.

## Log

Write the live URL to the Dispatch row and to the category's data tab. Prefer
the Sheets connector over typing into a browser tab — fewer steps, no risk of
landing in the wrong cell.

If the listing is queued for moderation, write `PENDING_APPROVAL` and the
submitted-at time instead of a live URL, and say so in the report.

## Then

Write or update `playbooks/<domain>.md` (see `playbook-template.md`) before
moving to the next site. This is what makes batch 2 three times faster than
batch 1.

## Gotchas

- Never submit the same site for the same client twice — check Dispatch history
  first.
- Reuse the same *brand facts* across directories, but never the same
  *description text*.
- A site demanding payment, showing malware warnings or adult ads → skip, mark
  it in the Site DB notes, and tell the user.
