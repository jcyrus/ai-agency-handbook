# AI Agency Handbook

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
[![Deploy to GitBook](https://img.shields.io/badge/Deploy-GitBook-3884FF?logo=gitbook&logoColor=white)](https://www.gitbook.com/)

The AI Agency Handbook is a role-based operating manual for running AI agents like a coordinated team instead of a generic chat surface. It documents the why, the handoff model, and the runnable setup needed to install agents, standardize outputs, and publish the handbook in GitBook.

## What's In This Handbook

| Section                          | Description                                                       | Who it's for                           |
| -------------------------------- | ----------------------------------------------------------------- | -------------------------------------- |
| [Handbook](handbook/README.md)   | Core philosophy, reusable skills, and handoff templates           | CTOs, technical leads, staff engineers |
| [Agents](agents/README.md)       | Ten installable agent personas with clear roles and rules         | Developers, founders, AI operators     |
| [Workflows](workflows/README.md) | Multi-agent orchestration guides for delivery and compliance      | Teams adopting structured AI workflows |
| [Scripts](scripts/README.md)     | Shell automation for install, scaffolding, and GitBook validation | Maintainers, contributors, tool owners |
| [Assets](assets/README.md)       | Migration notes and supporting design briefs                      | Design and documentation maintainers   |

## 2026 Staff Roster

| Role             | Internal Title     | Recommended Model | Best Used For                                                     |
| ---------------- | ------------------ | ----------------- | ----------------------------------------------------------------- |
| Chief of Staff   | The Architect      | Claude Opus 4.6   | Strategy, PRDs, system design                                     |
| Lead Designer    | The Visionary      | Google Stitch     | High-fidelity UI direction, design systems, prompt-driven layouts |
| Senior Engineer  | The Builder        | GPT-5.3 Codex     | Implementation, refactoring, verification                         |
| Researcher       | The Librarian      | Gemini 3 Pro      | Large-context analysis, legal compliance, deep scans              |
| Intern (Offline) | The Offline Intern | Qwen 2.5 (14B)    | Local tests, commit messages, small fixes                         |
| Intern (Online)  | The Intern         | Claude Haiku      | Fast scoped tasks through Copilot or API                          |

## Quick Start

```bash
bash scripts/install-agent.sh --agent system-architect --target cursor
```

```bash
bash scripts/install-all-agents.sh --target cursor
```

```bash
bash scripts/new-agent.sh --name "My Agent" --division "Engineering"
```

## Deploy To GitBook

1. Open GitBook and choose the GitHub import flow.
2. Select this repository and keep the content root at `./`.
3. GitBook will use `.gitbook.yaml`, `README.md`, and `SUMMARY.md` automatically.

Run the validation step before publishing:

```bash
bash scripts/validate-links.sh
```

## Contributing

Use `scripts/new-agent.sh` to scaffold a new agent page, then update any related handbook, workflow, or script references before opening a pull request. Full contribution guidance lives in [CONTRIBUTING.md](CONTRIBUTING.md).

## Core Philosophy

- Architect first. Do not let implementation agents invent system design under delivery pressure.
- Context is leverage. Use the Librarian when the problem depends on large source material or precise policy review.
- Match the task to the smallest capable agent. Save deeper reasoning for architecture, review, and compliance.
