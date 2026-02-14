# The Fractional CTO's AI Playbook 🚀

This repository documents a role-based AI workforce architecture designed for high-output engineering teams.

Instead of treating AI as a generic chat window, this playbook treats models as specialized employees with distinct roles, permissions, and hand-off protocols. This setup is optimized for **Fractional CTOs** or **Senior Engineers** managing multiple projects (SaaS, Mobile, Open Source) simultaneously.

## The 2026 "Staff" Roster

| Role                | Internal Title  | Recommended Model   | Best Used For                                         |
| :------------------ | :-------------- | :------------------ | :---------------------------------------------------- |
| **Chief of Staff**  | `The Architect` | **Claude Opus 4.6** | Strategy, PRDs, System Design, "Adaptive Thinking"    |
| **Lead Designer**   | `The Visionary` | **Moonchild AI**    | High-Fidelity UI, Glassmorphism, Figma Tokens         |
| **Senior Eng**      | `The Builder`   | **GPT-5.3 Codex**   | Terminal execution, Refactoring, CI/CD                |
| **Researcher**      | `The Librarian` | **Gemini 3 Pro**    | 2M+ Token Context, Legal Compliance, Log Analysis     |
| **Intern(Offline)** | `The Runner`    | **Qwen 2.5 (14B)**  | Local (Offline) Unit tests, git messages, small fixes |
| **Intern(Online)**  | `The Runner`    | **Claude Haiku**    | High-speed tasks via Copilot/API                      |

## Repository Structure

```
config/
  opencode.json          ← OpenCode provider & plugin config
  oh-my-opencode.json    ← Agent-to-model orchestration map
  ollama_modelfile       ← Local Qwen 2.5 Coder (offline intern)
prompts/
  01_system_architect.md ← The Architect (Claude Opus 4.6)
  02_design_dna.md       ← The Visionary (Moonchild AI)
  03_compliance_researcher.md ← The Librarian (Gemini 3 Pro)
  04_intern_haiku.md     ← The Intern (Claude Haiku)
  05_senior_builder.md   ← The Builder (GPT-5.3 Codex)
workflows/
  01_feature_handoff.md  ← Architect → Designer → Builder pipeline
  02_legal_review_loop.md ← Librarian compliance scanning
templates/
  architecture_spec.md   ← ASD template (Architect output)
  design_spec.md         ← DSD template (Designer output)
  implementation_brief.md ← Brief template (Builder input)
```

## How to Use This Repo

### Option A: Manual Specialist (Copy & Paste Prompts)

1. **Fork this repository.**
2. **Copy the System Prompts** from `/prompts` into your AI tools (Claude Projects, OpenAI Custom GPTs, or Cursor Rules).
3. **Adjust the `design_dna.md`** to match your personal brand aesthetic.
4. **Run the `ollama_modelfile`** to set up your cost-saving local intern.

### Option B: Automated Team (OpenCode + oh-my-opencode)

1. **Install OpenCode**: `curl -fsSL https://opencode.ai/install.sh | sh`
2. **Install oh-my-opencode**: `bunx oh-my-opencode install`
   - Select your providers (Claude, Copilot, Gemini, etc.)
   - This sets up `~/.config/opencode/` with global auth and plugins
3. **Copy the config files** into your project root:
   ```bash
   cp config/opencode.json ./opencode.json
   cp config/oh-my-opencode.json ./oh-my-opencode.json
   ```
4. **Authenticate**: `opencode auth login` → select your provider
5. **Run**: `opencode "your task here"`

> See [WORKFLOWS.md](WORKFLOWS.md) for detailed setup and usage of both approaches.

## The Core Philosophy

- **Architect First:** Never let the "Builder" (GPT) write code without a spec from the "Architect" (Claude).
- **Context is King:** Use the "Librarian" (Gemini) for any task involving >100k tokens of documentation.
- **Local for Speed:** Use the "Intern" (Local LLM) for loops that don't require high reasoning, saving API costs.
