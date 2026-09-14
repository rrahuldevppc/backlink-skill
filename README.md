# Backlink Skill

A single Claude skill that runs the whole off-page backlink loop:

```
shortlist sites → write content packs → you log in → Claude fills + submits
→ live URLs into the sheet → logged-out QA → next batch
```

Install it once and your Claude session knows the entire process — site
selection rules, pack writing, form filling, the status state machine, QA gates,
and all five off-page tiers.

---

## Install (about 5 minutes)

**1. Clone and install**

```bash
git clone https://github.com/rrahuldevppc/backlink-skill.git
cd backlink-skill && bash install.sh
```

This copies the skill into `~/.claude/skills/` and creates `config.yml`.

**2. Fill in `config.yml`**

Your team lead gives you the Control sheet ID and the Sheets connector account.
Nothing works until these are filled in — the skill refuses to guess.

**3. Get the sheets shared with you**

Ask your team lead to share the Control spreadsheet with your Google account,
and connect Google Sheets in Claude.

**4. Install the Claude in Chrome extension**

All form filling happens there.

**5. Test**

Open a new Claude session and say `dispatch banao`. If the wizard starts asking
which client, you're set up.

---

## Daily flow

| You say | What happens |
|---|---|
| `dispatch banao` | Wizard: which client → which category → how many sites → shows a ranked shortlist. Say **go** and it writes the batch + packs |
| *(you log in)* | Open the batch's sites, do signup / OTP / CAPTCHA yourself. Passwords go only in your sheet's own columns |
| `batch #N ready` | Claude fills and submits in your logged-in tabs, captures live URLs, updates the sheet |
| `backlink validator chalao` | Every live URL checked logged-out, verdicts written back |
| `metrics dikhao` | Links per hour, success rate, per-client totals |

---

## The boundary

| Claude does | You do |
|---|---|
| Picks sites, ranked | Account signup |
| Writes the packs | Passwords |
| Fills forms, submits | CAPTCHA |
| Captures live URLs | Phone / SMS OTP |
| Updates the sheet + playbooks | Finish anything marked `BLOCKED` |
| Runs QA | — |

**Claude never creates accounts, never touches passwords, never solves CAPTCHA.**
That is policy and a ban-risk decision — a burned account costs far more than a
saved minute.

---

## What's in here

```
skills/backlink-builder/
├── SKILL.md                          the batch loop, lifecycle, rules
└── references/
    ├── directory-submission.md       filling and submitting a listing form
    ├── site-selection.md             ratings, index status, ranking order
    ├── content-packs.md              what goes in a pack, uniqueness rules
    ├── validation.md                 the four QA gates and verdicts
    ├── tiers.md                      all five off-page tiers
    └── playbook-template.md          recording a site's process

playbooks/                            one file per site, grows as you work
config.example.yml                    sheet IDs, tabs, forbidden ranges
install.sh
```

---

## Rules worth posting on a wall

1. One site, one client, one time.
2. Facts come from the client's own site or the registry. Nothing invented.
3. Descriptions unique per site — never paste the same paragraph twice.
4. No fake reviews, ever. Profile only on review sites.
5. Communities: Claude drafts, **you** post in your own voice.
6. Passwords live in your sheet's own columns. Never in a chat.
7. The public listing URL goes in the sheet — a dashboard URL fails QA.
8. A site demanding payment or showing malware warnings → skip and flag it.

---

## Updating the skill

Edit under `skills/`, re-run `bash install.sh`, commit and push. Everyone else
runs `git pull && bash install.sh`. Never edit `~/.claude/skills/` directly — it
gets overwritten on the next install.

---

## Note on data

This repo contains **process only**. No spreadsheet IDs, no client names, no
site database, no credentials. Everything account-specific lives in your own
`config.yml`, which is gitignored.

MIT licensed.
