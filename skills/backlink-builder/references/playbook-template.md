# Playbook template

Copy this to `playbooks/<domain>.md` after the first submit on a site.

```markdown
# Playbook: <domain>

Last verified: <dd-mm-yyyy> · Auto Rating: <🟢/🟡> · Avg time: <sec>

## Entry
- Submission URL (logged in): <url>
- Login type: email account / OTP / social

## Steps that actually worked
1. <e.g. "Dashboard → Add Listing button, top right">
2. <step>
3. Submit button label: <label> · Confirmation shown: <what appears>

## Field mapping (pack → form)
| Pack field | Form field label | Notes |
|---|---|---|
| Business name | <label> | <char limit> |
| Category | <label> | exact vocabulary used: <site's category names> |
| Short description | <label> | <limit> |
| Long description | <label> | rich text / plain |
| Address | <label> | one field, or separate city/state/pin |
| Website | <label> | needs https:// + trailing slash? |
| Image | <label> | <size / format required> |

## Where the live URL appears
<e.g. "redirects to the public listing after submit" / "My Listings → View">

## Quirks and blocks
- <e.g. "CAPTCHA appears at submit — human needed at step 3">
- <e.g. "approval queue ~24h — mark PENDING_APPROVAL">
- <e.g. "ad vignette covers the submit button — close it first">
```

**Process only.** Never credentials. Never client content.

Commit and push playbooks — one person's discovery becomes everyone's speed.
