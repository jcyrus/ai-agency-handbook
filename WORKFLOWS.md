# Workflows: Manual Specialist vs. Automated Team

> Choose the right execution model for every task — from single-agent precision work to fully orchestrated multi-agent pipelines.

---

## Table of Contents

- [Overview](#overview)
- [Workflow A: Manual Specialist](#workflow-a-manual-specialist)
- [Workflow B: Automated Team (OpenCode)](#workflow-b-automated-team-opencode)
- [Choosing the Right Workflow](#choosing-the-right-workflow)
- [Kill Switch & Safety Controls](#kill-switch--safety-controls)
- [Cost Management](#cost-management)
- [Quick Reference](#quick-reference)

---

## Overview

This handbook supports two distinct execution models. They are not mutually exclusive — experienced practitioners blend them depending on task complexity, risk tolerance, and budget.

| Dimension            | Manual Specialist                                 | Automated Team (OpenCode)                         |
| -------------------- | ------------------------------------------------- | ------------------------------------------------- |
| **Execution**        | Human routes tasks between agents one at a time   | Agent loop executes multi-step plans autonomously |
| **Control**          | Full human control at every handoff               | Human-in-the-loop with configurable guardrails    |
| **Best For**         | High-stakes architecture, compliance, design      | Repetitive implementation, testing, refactoring   |
| **Token Cost**       | Pay per conversation (direct API or subscription) | Optimized via GitHub Copilot authentication       |
| **Setup Complexity** | Low — just copy system prompts                    | Medium — requires OpenCode CLI + config           |

---

## Workflow A: Manual Specialist

This is the workflow described in detail across the existing workflow documents:

- [Feature Handoff Workflow](workflows/01_feature_handoff.md) — Architect → Designer → Builder
- [Legal Review Loop](workflows/02_legal_review_loop.md) — Librarian compliance scanning

### How It Works

```text
┌──────────┐        ┌──────────┐        ┌──────────┐        ┌──────────┐
│  Human   │───────▶│ Architect│───────▶│ Designer │───────▶│ Builder  │
│ (You)    │◀───────│ (Claude) │◀───────│(Moonchild)│◀──────│  (GPT)   │
└──────────┘  review └──────────┘  review └──────────┘ review └──────────┘
     │                                                            │
     │              ┌──────────┐                                  │
     └─────────────▶│ Librarian│◀─────────────────────────────────┘
        compliance  │ (Gemini) │  pre-merge scan
                    └──────────┘
```

### When to Use Manual Specialist

- **Architecture decisions** that affect long-term system design
- **Compliance-sensitive work** requiring audit trails
- **Design exploration** where creative iteration matters
- **Client-facing deliverables** that need human polish
- **First-time tasks** where you're still defining the process

### Step-by-Step

1. **Define the task** in a structured feature request (see [Feature Handoff](workflows/01_feature_handoff.md))
2. **Open a conversation** with the appropriate specialist agent
3. **Paste the relevant system prompt** from [`prompts/`](prompts/) into the model's system instructions
4. **Provide context** — feature request, specs, or code
5. **Review the output** before passing it to the next agent
6. **Repeat** for each agent in the chain
7. **Run compliance scan** via the Librarian before merging

> **Key principle**: You are the router. Nothing moves to the next agent without your explicit approval.

---

## Workflow B: Automated Team (OpenCode)

[OpenCode](https://github.com/opencode-ai/opencode) is a terminal-native AI agent runner that can execute multi-step coding tasks autonomously — reading files, writing code, running tests, and iterating on failures — all within your local development environment.

### Why OpenCode?

| Benefit                    | Details                                                                                                             |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **GitHub Copilot Auth**    | Use `opencode /connect` to authenticate via your existing GitHub Copilot subscription — no separate API keys needed |
| **Token Cost Savings**     | Copilot's flat-rate subscription absorbs token costs that would otherwise accumulate across multiple API providers  |
| **Terminal-Native**        | Runs in your terminal alongside your existing dev tools                                                             |
| **Human-in-the-Loop**      | Configurable step limits and manual approval gates                                                                  |
| **Multi-Provider Support** | Can also connect to Anthropic, OpenAI, Google, or Ollama directly                                                   |

### Setup

#### 1. Install OpenCode

```bash
# macOS / Linux
curl -fsSL https://opencode.ai/install.sh | sh

# Or via Go
go install github.com/opencode-ai/opencode@latest
```

#### 2. Authenticate via GitHub Copilot

This is the recommended approach for cost optimization:

```bash
opencode /connect
```

Follow the browser-based OAuth flow. Once connected, OpenCode routes requests through your Copilot subscription — no per-token billing.

> **Note**: If you prefer direct API access, you can set provider-specific keys in your environment instead:
>
> ```bash
> export ANTHROPIC_API_KEY="sk-..."
> export OPENAI_API_KEY="sk-..."
> ```

#### 3. Add the Configuration File

Copy the provided [`config/opencode.json`](config/opencode.json) into your project root:

```bash
cp path/to/ai-agency-handbook/config/opencode.json ./opencode.json
```

See the [config file documentation](#configuration-reference) below for details.

#### 4. Run OpenCode

```bash
# Start interactive session
opencode

# Or run a specific task
opencode "Write unit tests for src/auth/login.ts"
```

### How the Automated Workflow Runs

```text
┌──────────────────────────────────────────────────────────┐
│                     OpenCode Agent Loop                   │
│                                                          │
│   ┌─────────┐    ┌──────────┐    ┌─────────┐            │
│   │  Read   │───▶│  Plan    │───▶│  Write  │            │
│   │  Files  │    │  Changes │    │  Code   │            │
│   └─────────┘    └──────────┘    └────┬────┘            │
│                                       │                  │
│                                  ┌────▼────┐            │
│                       ┌──────────│  Run    │            │
│                       │  fail    │  Tests  │            │
│                       │          └────┬────┘            │
│                       │               │ pass            │
│                  ┌────▼────┐    ┌────▼────┐            │
│                  │  Fix    │    │  Done   │            │
│                  │  Errors │    │  ✓      │            │
│                  └─────────┘    └─────────┘            │
│                                                          │
│   ⚠️  Max Steps: 10 (configurable)                      │
│   ⚠️  Auto-Fix: OFF (human must approve fixes)          │
└──────────────────────────────────────────────────────────┘
```

### When to Use the Automated Team

- **Unit test generation** across multiple files
- **Refactoring** with automated verification
- **Boilerplate scaffolding** (CRUD endpoints, models, migrations)
- **Bug fixes** with clear reproduction steps
- **Documentation generation** from existing code
- **Dependency updates** with test verification

### Step-by-Step

1. **Ensure your system prompt context is set**
   - For implementation tasks, the Builder personality applies
   - For test generation, the Intern personality applies (see [`prompts/04_intern_haiku.md`](prompts/04_intern_haiku.md))

2. **Start OpenCode in your project directory**

   ```bash
   cd your-project
   opencode
   ```

3. **Issue a clear, scoped task**

   ```
   Write unit tests for all exported functions in src/utils/validation.ts.
   Use vitest. Aim for >90% branch coverage. Do not modify the source file.
   ```

4. **Monitor the agent loop**
   - Watch each step in the terminal
   - The agent will stop at `max_steps` (default: 10)
   - If `auto_fix` is `false`, the agent will pause and ask before applying fixes

5. **Review and approve changes**

   ```bash
   git diff                    # Review what changed
   npm test                    # Verify tests pass
   git add -p                  # Stage selectively
   git commit -m "test: add validation utility tests (via OpenCode)"
   ```

6. **Run compliance check if needed**
   - Follow [Legal Review Loop](workflows/02_legal_review_loop.md) for sensitive changes

---

## Choosing the Right Workflow

```text
                        Is the task well-defined
                        with clear inputs/outputs?
                                │
                    ┌───────────┴───────────┐
                    │ NO                    │ YES
                    ▼                       ▼
            Manual Specialist         Does it involve
            (explore, design,         architecture or
             architect first)         compliance decisions?
                                          │
                                ┌─────────┴─────────┐
                                │ YES               │ NO
                                ▼                   ▼
                        Manual Specialist     Automated Team
                        (Architect +          (OpenCode)
                         Librarian)
```

### Decision Matrix

| Task Type                | Recommended Workflow | Agents Involved                        |
| ------------------------ | -------------------- | -------------------------------------- |
| New feature architecture | Manual Specialist    | Architect → Designer → Builder         |
| UI/UX design exploration | Manual Specialist    | Designer                               |
| Compliance review        | Manual Specialist    | Librarian                              |
| Unit test generation     | Automated Team       | Intern / Builder                       |
| Code refactoring         | Automated Team       | Builder                                |
| Bug fix (clear repro)    | Automated Team       | Builder                                |
| API endpoint scaffolding | Automated Team       | Builder                                |
| Security audit           | Manual Specialist    | Architect + Librarian                  |
| Documentation generation | Automated Team       | Builder / Intern                       |
| Performance optimization | Manual → Automated   | Architect (plan) → Builder (implement) |

---

## Kill Switch & Safety Controls

### ⚡ Emergency Stop: `Ctrl+C`

If an agent loop is running in your terminal and producing unwanted changes, **press `Ctrl+C` immediately** to terminate the process.

```text
┌─────────────────────────────────────────────────┐
│                                                 │
│   🛑  KILL SWITCH: Press Ctrl+C at any time    │
│       to stop an agent loop mid-execution.      │
│                                                 │
│   The agent will halt. No further file writes   │
│   will occur. Review and revert if needed:      │
│                                                 │
│   $ git checkout -- .     # revert all changes  │
│   $ git stash             # stash for review    │
│                                                 │
└─────────────────────────────────────────────────┘
```

### Additional Safety Measures

| Control             | How to Enable                              | Purpose                                     |
| ------------------- | ------------------------------------------ | ------------------------------------------- |
| **Step Limit**      | `"max_steps": 10` in `opencode.json`       | Prevents infinite loops                     |
| **Auto-Fix Off**    | `"auto_fix": false` in `opencode.json`     | Agent pauses before applying fixes          |
| **Git Branching**   | Always run on a feature branch             | Easy to revert entire session               |
| **Dry Run**         | Ask agent to "plan but do not write files" | Preview actions before execution            |
| **File Exclusions** | Add patterns to `.opencodeignore`          | Prevent agent from touching sensitive files |
| **Ctrl+C**          | Terminal keyboard shortcut                 | Immediate process termination               |

### Recovery After Kill Switch

```bash
# See what the agent changed
git status
git diff

# Option A: Keep some changes
git add -p                    # Interactive staging
git checkout -- [files]       # Discard specific files

# Option B: Revert everything
git checkout -- .

# Option C: Stash for later review
git stash push -m "interrupted agent session"
```

---

## Cost Management

### Token Cost Comparison

| Method                            | Cost Model                | Best For                         |
| --------------------------------- | ------------------------- | -------------------------------- |
| **GitHub Copilot (via OpenCode)** | Flat monthly subscription | High-volume implementation tasks |
| **Direct API (Anthropic/OpenAI)** | Per-token billing         | Targeted, high-reasoning tasks   |
| **Ollama (Local)**                | Free (hardware cost only) | Offline work, simple tasks       |
| **Copilot + Local Hybrid**        | Subscription + free       | Maximum cost efficiency          |

### Cost Optimization Strategy

```text
Task Complexity    ──────────────────────────────────▶

Low                    Medium                    High
│                        │                         │
▼                        ▼                         ▼
┌──────────┐      ┌──────────────┐      ┌─────────────────┐
│  Local   │      │   Copilot    │      │   Direct API    │
│  Ollama  │      │ (via OpenCode│      │  (Claude Opus,  │
│  or      │      │  /connect)   │      │   Gemini Pro)   │
│  Haiku   │      │              │      │                 │
└──────────┘      └──────────────┘      └─────────────────┘
  git msgs          unit tests            architecture
  formatting        refactoring           compliance
  simple fixes      scaffolding           design
```

1. **Use the Intern** ([`prompts/04_intern_haiku.md`](prompts/04_intern_haiku.md) or [`config/ollama_modelfile`](config/ollama_modelfile)) for low-complexity tasks
2. **Use Copilot auth** (`opencode /connect`) for medium-complexity implementation work
3. **Reserve direct API calls** for Architect and Librarian tasks that need maximum reasoning or large context windows

---

## Configuration Reference

### `opencode.json`

See [`config/opencode.json`](config/opencode.json) for the template configuration. Key settings:

| Setting     | Default | Description                                              |
| ----------- | ------- | -------------------------------------------------------- |
| `max_steps` | `10`    | Maximum agent loop iterations before forced stop         |
| `auto_fix`  | `false` | If `true`, agent auto-applies fixes without asking       |
| `provider`  | varies  | AI provider (`copilot`, `anthropic`, `openai`, `ollama`) |
| `model`     | varies  | Model identifier for the provider                        |

---

## Quick Reference

```text
MANUAL SPECIALIST (high-control, high-reasoning)
═══════════════════════════════════════════════
1. Copy system prompt from prompts/ into your AI tool
2. Provide context (feature request, code, compliance docs)
3. Review output at every handoff
4. Route to next specialist manually

AUTOMATED TEAM (high-speed, scoped tasks)
═══════════════════════════════════════════════
1. opencode /connect              ← authenticate via Copilot
2. cd your-project                ← navigate to project
3. opencode "your task here"      ← issue scoped instruction
4. Ctrl+C if anything goes wrong  ← KILL SWITCH
5. git diff && git add -p         ← review before committing
```

---

## Related Documents

- [Feature Handoff Workflow](workflows/01_feature_handoff.md) — Manual Specialist detailed steps
- [Legal Review Loop](workflows/02_legal_review_loop.md) — Compliance scanning process
- [System Architect Prompt](prompts/01_system_architect.md) — Architect agent configuration
- [Design DNA Prompt](prompts/02_design_dna.md) — Designer agent configuration
- [Compliance Researcher Prompt](prompts/03_compliance_researcher.md) — Librarian agent configuration
- [Intern Prompt](prompts/04_intern_haiku.md) — Intern agent configuration
- [OpenCode Config](config/opencode.json) — Automated team configuration
- [Contributing Guide](CONTRIBUTING.md) — How to add new agents and workflows

---

**Last Updated**: February 2026
**Maintained by**: [@jcyrus](https://github.com/jcyrus)
