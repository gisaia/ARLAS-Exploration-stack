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
2. Check that tags/versions exist on `https://github.com/gisaia/ARLAS-Exploration-stack` and inspect `conf/versions.env`.
3. Compare git diffs, commits, PRs, and closed issues for the main stack and all subprojects:
   - For `aias`, keep a very detailed track of driver changes (STAC, S3, CSK, Superview, COG, etc.).
   - If a subproject has no version bump, explicitly mark "No changes".
   - For Kubernetes/Helm, inspect the full git diff of `k8s/charts/arlas-stack/values.yaml` between `[PREVIOUS_VERSION]` and `[LATEST_VERSION]` and list **ALL** changed variables (added, modified, or removed). If an added node contains sub-variables, group them under that node. For every entry, inspect comments (`# -- ...`), chart `README.md`, or Helm templates to provide an accurate description of its role and its default value (plus previous value if modified).
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
*(List ALL added, modified, or removed variables in `k8s/charts/arlas-stack/values.yaml`. Group sub-variables under their parent node when a new node is added. Every entry must state its role and default value.)*
- **`<variable.path>`** *(Added / Modified / Removed)*: <Description of the variable or node's role>. Default: `<default_value>` *(if modified, include `<old_value>` → `<new_value>`)*.
  - Sub-variables (if a new node was added):
    - **`<sub_var>`**: <Role>. Default: `<default_value>`.

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

[See changes](https://github.com/gisaia/ARLAS-Exploration-stack/compare/[PREVIOUS_VERSION]...[LATEST_VERSION]).

[Artifacthub ARLAS AIAS](https://artifacthub.io/packages/helm/arlas-stack/arlas-aias/[LATEST_VERSION])
```
