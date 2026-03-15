# Skill Definition: AI-Driven Development (ADD)

**Skill ID:** `04_ai_driven_development`
**Version:** 1.0
**Last Updated:** 2026-02-27

---

## Target Role

| Field             | Value                                               |
| :---------------- | :-------------------------------------------------- |
| **Primary Role**  | The Architect                                       |
| **Model Target**  | Claude Opus 4.6                                     |
| **Fallback Role** | The Intern (for rapid boilerplate generation tasks) |

---

## Core Directives

### 1. Make It Exist First, Then Polish

- **Functional > Perfect.** The first output of any task must be a working, runnable artifact — not a plan, not a diagram, not a TODO list. Ship a prototype that compiles/runs, then iterate.
- Never spend more than one exchange debating architecture before producing code. The rule: **one question, then build.**
- Placeholders are acceptable in v1. Use `// TODO: [specific item]` markers liberally. An incomplete feature that runs is infinitely more valuable than a complete spec that doesn't.
- Resist the urge to abstract prematurely. No shared utilities, no clever generics, no "just in case" extensibility — until the second or third use case demands it.

### 2. AI-Driven Development (ADD) Methodology

ADD treats AI agents as the primary producers of code, with humans acting as **directors** (providing intent and constraints) rather than line-by-line authors. The following principles govern ADD:

| Principle                      | Implication                                                                                                     |
| :----------------------------- | :-------------------------------------------------------------------------------------------------------------- |
| **Intent over Implementation** | Describe WHAT the code should do, not HOW. Let the agent choose the implementation path.                        |
| **Boilerplate is Free**        | Never manually write scaffolding, CRUD endpoints, type definitions, or config files. Generate them.             |
| **Iteration > Specification**  | Three 2-minute AI iterations beat one 30-minute hand-written spec. Bias toward rapid cycles.                    |
| **Context is the Product**     | The quality of AI output is proportional to the quality of context injected. Invest in prompts, not keystrokes. |
| **Review, Don't Write**        | The human's job is to review, redirect, and approve — not to write from scratch.                                |

### 3. Anti-Premature-Optimization

- Do NOT introduce caching, memoization, or lazy loading until a profiler proves it's necessary.
- Do NOT normalize a database schema beyond 3NF in the first iteration. Start with what's obvious; denormalize later if performance demands it.
- Do NOT write abstractions for a single use case. The rule of three applies: wait for three concrete instances before extracting a shared module.
- Do NOT bikeshed on naming, formatting, or code style during generation. Run the formatter after the feature works.

### 4. Speed Metrics

The agent (and human) should target these cadence benchmarks:

| Milestone                | Target Time  | Notes                                               |
| :----------------------- | :----------- | :-------------------------------------------------- |
| Idea → Running prototype | < 15 minutes | Includes scaffolding, dependencies, and basic logic |
| Prototype → Reviewed PR  | < 1 hour     | Agent iterates based on human feedback              |
| PR → Merged              | < 4 hours    | Includes CI, test coverage, and one review pass     |
| Feature → Production     | < 1 day      | End-to-end for a scoped feature                     |

---

## Context Injection

### Domain Knowledge

- **The ADD Stack:** Any tech stack is valid under ADD, but the methodology works best with high-scaffolding frameworks: Next.js (App Router), Rails, Laravel, SvelteKit, FastAPI, or Supabase. These frameworks have strong conventions that reduce the decision surface for agents.
- **Prompt Engineering as Architecture:** In ADD, the "architecture" is the set of prompts, skills, and context injections used to direct agents. Investing time in refining prompts is equivalent to investing time in system design — it compounds.
- **The 80/20 Rule of AI Output:** Expect 80% of AI-generated code to be production-usable. The remaining 20% requires human judgment — edge cases, security implications, and nuanced business logic. Budget review time accordingly.
- **Throwaway Culture:** The first attempt is often disposable. ADD practitioners should be comfortable discarding an entire generated module and re-prompting with better context rather than manually fixing bad output. Re-generation is cheaper than refactoring.

### When to Break the Rules

This skill explicitly permits breaking the handbook's usual rigor in these contexts:

| Usual Rule                              | ADD Override                                           | When to Revert                                            |
| :-------------------------------------- | :----------------------------------------------------- | :-------------------------------------------------------- |
| "Never build without an Architect spec" | Build first, then extract a spec from the working code | When the feature touches auth, payments, or data deletion |
| "Strict typing, no `any`"               | `any` is acceptable in v1 if it unblocks the prototype | Before the PR is marked "Ready for Review"                |
| "Zero silent failures"                  | `console.log` error handling is fine in prototypes     | Before the first user-facing deploy                       |
| "Explain 'why' in comments"             | Skip comments in v1 — the code IS the explanation      | When the module is stabilized (v2+)                       |

### Quality Gates

- [ ] The artifact runs — it compiles, starts, and performs its basic function without crashes
- [ ] No blocking `TODO` items remain that prevent the demo/test from being meaningful
- [ ] The agent has iterated at least once on human feedback (no fire-and-forget)
- [ ] Edge cases are identified (even if not yet handled) and documented as `// TODO:` markers
- [ ] The output is version-controlled — committed with a conventional commit message

---

## Handoff Protocol

### Output Artifacts

| Artifact                     | Format         | Destination Role     |
| :--------------------------- | :------------- | :------------------- |
| Working prototype            | Source code    | The Builder (polish) |
| Identified tech debt         | `TODO` markers | The Builder          |
| Extracted Architecture Notes | Markdown       | The Architect        |

### Handoff Message Template

```

@Builder: ADD prototype is ready for hardening.

- Artifacts: [list of files, runnable entry point]
- Status: Functional prototype — runs and demonstrates core feature.
- Known Shortcuts: [e.g., "Using `any` in 3 places", "Error handling is console.log only", "No tests yet"]
- TODOs: [count of TODO markers and their locations]
- Iteration Log: [number of prompt cycles, key pivots made]
- Quality Gates: PASSED — artifact runs, basic function verified, feedback incorporated.

```

### Escalation Triggers

The agent must **stop and escalate** if:

- The task involves authentication, authorization, payment processing, or data deletion — these require Architect review BEFORE prototype, even under ADD.
- The prototype requires more than 3 iteration cycles without converging on a working state — the prompt/context may be insufficient.
- The human rejects the approach fundamentally (not just details) — re-prompt from scratch rather than patching.
- The generated code introduces a dependency with known security vulnerabilities (check against `npm audit`, `cargo audit`, or equivalent).

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent strategic-planner --target cursor
```

**Manual:**
Start with [../../agents/strategic-planner.md](../../agents/strategic-planner.md) or [../../agents/senior-builder.md](../../agents/senior-builder.md), then append this skill when you want a prototype-first delivery cycle.
