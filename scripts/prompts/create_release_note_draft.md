---
name: arlas-release-notes
description: Draft release notes for ARLAS Exploration Stack versions.
version: 0.1.0
author: Sylvain Gaudan, Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [arlas, release-notes, exploration-stack, changelog]
---

# ARLAS Exploration Stack Release Notes Skill

Draft comprehensive, user-facing Release Notes in Markdown for the **ARLAS Exploration Stack** comparing `[PREVIOUS_VERSION]` against `[LATEST_VERSION]`.

## Target Repositories & Dependency Mapping

1. **Main Stack Repository**:
   - `https://github.com/gisaia/ARLAS-Exploration-stack`
2. **Subproject Repositories**:
   Determine the exact tag/version used for each subproject by inspecting `conf/versions.env` between `[PREVIOUS_VERSION]` and `[LATEST_VERSION]`:
   - `https://github.com/gisaia/ARLAS-wui`
   - `https://github.com/gisaia/ARLAS-wui-hub`
   - `https://github.com/gisaia/ARLAS-wui-builder`
   - `https://github.com/gisaia/ARLAS-server`
   - `https://github.com/gisaia/ARLAS-persistence`
   - `https://github.com/gisaia/ARLAS-permissions`
   - `https://github.com/gisaia/aias`

## Procedure

1. Ask or confirm `[PREVIOUS_VERSION]` and `[LATEST_VERSION]`.
2. Check that tags/versions exist on `https://github.com/gisaia/ARLAS-Exploration-stack` and inspect `conf/versions.env` between `[PREVIOUS_VERSION]` and `[LATEST_VERSION]`:
   - `ARLAS-Exploration-stack` and `aias` tags have no `v` prefix (`29.0.0`, `0.23.0`), whereas `ARLAS-wui`, `ARLAS-wui-hub`, `ARLAS-wui-builder`, `ARLAS-server`, `ARLAS-persistence`, and `ARLAS-permissions` git tags require a `v` prefix (`v<version>` from `conf/versions.env`). Always prepend `v` for those repos so `git log` and GitHub compare URLs resolve.
3. Compare git diffs, commits, PRs, and closed issues for the main stack and all subprojects:
   - For repos cloned locally, inspect `git log <prev>..<latest>` and diffs directly; for remote-only or stale repos, download `https://api.github.com/repos/gisaia/<repo>/compare/<prev>...<latest>` and `/pulls?state=closed&per_page=50` to scratch JSON files via `curl -sL` and parse with `execute_code`.
   - Filter PRs strictly against the commits returned by `compare/<prev>...<latest>` — listing recent closed PRs without filtering pulls post-release or prior-patch changes into the wrong release notes.
   - For `aias`, inspect code diffs and keep a very detailed, verbose track of driver, security, model, and service changes (STAC, S3, CSK, Superview, COG enrichment, AIRS, APROC, AGATE, FAM WUI, CVEs).
   - If a subproject has no version bump, explicitly mark "No changes".
   - For Kubernetes/Helm, never rely on raw terminal `git diff` alone on large charts (output truncates): in `execute_code`, load both `[PREVIOUS_VERSION]` and `[LATEST_VERSION]` `k8s/charts/arlas-stack/values.yaml` with `yaml.safe_load`, flatten to dotted paths, and compute exact added, modified, and removed keys. Group sub-variables under their parent node when a new node is added, and cross-reference `# --` comments, chart `README.md`, and `k8s/charts/arlas-stack/templates/` so every entry states its role and default value (plus `<old_value>` → `<new_value>` if modified).
4. Identify breaking changes or configuration migrations.
5. Categorize items into:
   - `### 🚀 Features`
   - `### ⚡ Improvements`
   - `### 🐛 Bug Fixes`
   - `### ⚠️ Breaking Changes & Deprecations`
6. Format links:
   - Issue/PR: `[#<issue_number>](<issue_url>) - <Short description>`
   - Commit: `[`<short_hash>`](<commit_url>) - <Short description>`
## Output Template

Generate release notes adhering strictly to this markdown structure:

```markdown
# ARLAS Exploration Stack [LATEST_VERSION] Release Notes

## 📌 In a nutshell
*(Highlight the top 3–5 most impactful changes across the entire stack)*
- **[Component]**: Brief highlight summary.

---

## 🎨 ARLAS WUI (WUI, Hub, Builder)
*(Group changes across ARLAS-wui, ARLAS-wui-hub, and ARLAS-wui-builder)*
### 🚀 Features
- ...
### ⚡ Improvements
- ...
### 🐛 Bug Fixes
- ...

---

## ⚙️ ARLAS Backend (Server, Persistence, Permissions)
*(Group changes across ARLAS-server, ARLAS-persistence, and ARLAS-permissions)*
### 🚀 Features
- ...
### ⚡ Improvements
- ...
### 🐛 Bug Fixes
- ...

---

## 🤖 AIAS
*(Group by driver/plugin category if multiple drivers are affected, e.g., STAC Driver, S3 Driver, Ingest, etc. Keep detailed track of all driver modifications)*
### 🚀 Features
- ...
### ⚡ Improvements
- ...
### 🐛 Bug Fixes
- ...

---

## 🐳 Specific to Docker Compose Stack
*(Changes strictly affecting Docker Compose files, environment variables, or local setups)*
- ...

---

## ☸️ Specific to Kubernetes / Helm Stack
*(Changes strictly affecting Helm charts, Kubernetes manifests, or cluster deployments)*
- ...

### `k8s/charts/arlas-stack/values.yaml` Variable Changes
*(List ALL added, modified, or removed variables in `k8s/charts/arlas-stack/values.yaml`. Use icons instead of text labels for change types: ➕ = Added, ✏️ = Modified, 🗑️ = Removed. Group sub-variables under their parent node when a new node is added. Every entry must state its role and default value.)*
- ➕ **`<variable.path>`**: <Description of the variable or node's role>. Default: `<default_value>`.
  - Sub-variables (if a new node was added):
    - **`<sub_var>`**: <Role>. Default: `<default_value>`.
- ✏️ **`<variable.path>`**: <Description of the variable's role>. Default: `<old_value>` → `<new_value>`.
- 🗑️ **`<variable.path>`**: <Description of the removed variable's previous role>. Previous default: `<old_value>`.

---

## 📦 Dependency Versions Summary
| Component | Previous Version ([PREVIOUS_VERSION]) | New Version ([LATEST_VERSION]) |
| :--- | :--- | :--- |
| ARLAS-server | `vX.Y.Z` | `vX.Y.Z` |
| ARLAS-wui | `vX.Y.Z` | `vX.Y.Z` |
| ARLAS-wui-hub | `vX.Y.Z` | `vX.Y.Z` |
| ARLAS-wui-builder | `vX.Y.Z` | `vX.Y.Z` |
| ARLAS-persistence | `vX.Y.Z` | `vX.Y.Z` |
| ARLAS-permissions | `vX.Y.Z` | `vX.Y.Z` |
| AIAS | `vX.Y.Z` | `vX.Y.Z` |

*(Also note any bumped IAM or infrastructure component versions from `conf/versions.env`, such as `ARLAS-wui-iam`, `ARLAS-iam-server`, Elasticsearch, or object storage.)*

[See changes](https://github.com/gisaia/ARLAS-Exploration-stack/compare/[PREVIOUS_VERSION]...[LATEST_VERSION]).

[Artifacthub ARLAS AIAS](https://artifacthub.io/packages/helm/arlas-stack/arlas-aias/[LATEST_VERSION])
```
