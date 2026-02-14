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

## How to Use This Repo

1.  **Fork this repository.**
2.  **Copy the System Prompts** from `/prompts` into your AI tools (Claude Projects, OpenAI Custom GPTs, or Cursor Rules).
3.  **Adjust the `design_dna.md`** to match your personal brand aesthetic.
4.  **Run the `ollama_modelfile`** to set up your cost-saving local intern.

## The Core Philosophy

- **Architect First:** Never let the "Builder" (GPT) write code without a spec from the "Architect" (Claude).
- **Context is King:** Use the "Librarian" (Gemini) for any task involving >100k tokens of documentation.
- **Local for Speed:** Use the "Intern" (Local LLM) for loops that don't require high reasoning, saving API costs.
