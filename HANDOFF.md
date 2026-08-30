# Handoff — JustPlayExperimental 1.0

## What this project is
Brand new build: an internal dashboard (and eventually a landing page) for
"JustPlayExperimental 1.0." Starting completely from scratch — no code exists yet.

## Target repo (this is what you build into)
- **https://github.com/mansipeesapati08/JustPlayExperimental-1.0**
- Currently blank (no files, no commits).
- Public repo, deployed to a Netlify temporary domain (no custom domain yet).
- Two-repo plan: this repo is for the **dashboard**. The **landing page** will get
  its own separate repo later — don't merge them into one.

## Reference repo — READ ONLY, do not touch
- **github.com/Danish-FPL/GetMansiEmployed2K26YeahBuddy**
- The user has collaborator access to it, but it must **never be edited, committed
  to, or pushed to** from this project. Treat it strictly as visual/thematic/systemic
  inspiration — clone or view it to look at, screenshot it, copy ideas/patterns from
  it, nothing more.
- Its stack, for reference: no framework, no build step, plain vanilla HTML/CSS/JS.
  Netlify Functions (plain JS, in `netlify/functions/`) for backend logic. Supabase
  for the database. `netlify.toml` sets `publish = "."`, `command = ""`.
- It uses a 4-script deploy ladder worth mirroring here:
  - `save.sh` — commit locally only, free, nothing leaves the machine
  - `push.sh` — commit + push to GitHub, free, does **not** deploy. Refuses to run
    off the `main` branch, strips `.env` from staging as a guard, hard-stops if
    `.env` is ever tracked by git.
  - `deploy.sh` — deploy to Netlify only (no commit/push), costs Netlify build
    credits, asks for confirmation unless passed `-y`. Warns if there's
    uncommitted/unpushed work before deploying. Deploys a **sanitized publish
    directory** (built by a small script) rather than the repo root — the reference
    repo's own comments note it once leaked personal files/secrets by deploying root
    directly, so don't skip this guard when replicating the pattern.
  - `ship.sh` — the everyday command: `push.sh` + `deploy.sh` together.

## Workflow rules for this user (apply these exactly)
- Refer to committing + pushing as **"push and commit to GitHub."**
- **Never deploy to Netlify automatically.** Deploys only happen when the user
  explicitly says **"ship."** Regular pushes to GitHub must not trigger a Netlify
  deploy on their own — if Netlify's auto-deploy-on-push is ever enabled for this
  site, turn it off so nothing ships without the explicit command.

## Current machine state (as of this handoff)
- Git: installed.
- GitHub CLI (`gh`): installed and **authenticated** as `mansipeesapati08`
  (token scopes: gist, read:org, repo, workflow). `gh auth status` confirms this.
- Node.js / npm: **not installed yet.**
- Netlify CLI: **not installed yet** (needs Node/npm first — `npm install -g netlify-cli`,
  then `netlify login`, which is an interactive browser step the user has to do
  themselves).
- This local folder (`my-project`) is not yet a git clone of the new repo — decide
  whether to `git clone https://github.com/mansipeesapati08/JustPlayExperimental-1.0`
  here or work from a different folder.

## Suggested first steps in the new session
1. Confirm `gh auth status` still shows logged in.
2. Clone the blank repo locally (or init this folder and add it as `origin`).
3. Install Node.js + Netlify CLI, then have the user run `netlify login` themselves
   (interactive; can't be done by the agent).
4. `netlify init` (or `netlify link`) to connect the local folder to a new Netlify
   site on a temporary domain.
5. Scaffold `save.sh` / `push.sh` / `deploy.sh` / `ship.sh` following the pattern
   above, adjusted for this project (no Supabase/secrets setup unless the dashboard
   ends up needing a database).
6. Start building the dashboard structure from scratch.
