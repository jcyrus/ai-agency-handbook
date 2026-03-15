# Skill Definition: Rust TUI Engineering

**Skill ID:** `01_rust_tui_engineering`
**Version:** 1.0
**Last Updated:** 2026-02-27

---

## Target Role

| Field             | Value                                    |
| :---------------- | :--------------------------------------- |
| **Primary Role**  | The Builder                              |
| **Model Target**  | GPT-5.3 Codex / Claude Opus 4.6          |
| **Fallback Role** | The Architect (for system design review) |

---

## Core Directives

### 1. Memory Safety Is Non-Negotiable

- **Zero `unsafe` blocks** unless the rationale is documented inline with a `// SAFETY:` comment explaining why the invariant holds.
- Prefer owned types (`String`, `Vec<T>`) at API boundaries. Use borrowed types (`&str`, `&[T]`) internally for performance.
- All error handling via `Result<T, E>` with domain-specific error enums. No `.unwrap()` in production code — use `.expect("reason")` only in initialization paths.
- No implicit panics. Every `panic!`, `todo!()`, or `unreachable!()` must be justified or removed before handoff.

### 2. Zero-Allocation Rendering Loops

- The main render loop (`Terminal::draw()`) must allocate **zero heap memory** per frame in steady state.
- Pre-allocate all buffers (`Vec`, `String`) outside the loop and reuse via `.clear()` + `.extend()`.
- Avoid `format!()` inside `draw()`. Use `Line::from()`, `Span::styled()`, and pre-built `Text` blocks.
- Profile with `#[global_allocator]` + `dhat` or `tikv-jemallocator` to verify zero-alloc claims.

### 3. Cross-Platform Terminal Compatibility

- **Mandatory backends:** Crossterm (primary). No Termion-only code.
- Test on: macOS Terminal.app, iTerm2, Windows Terminal, Alacritty, and at minimum one Linux TTY.
- Handle terminal resize events (`Event::Resize`) gracefully — no panics on unexpected dimensions.
- Support both 256-color and truecolor modes. Degrade gracefully on terminals with limited color support.
- Use `crossterm::terminal::enable_raw_mode()` with a guaranteed cleanup path (e.g., `Drop` impl or `scopeguard`).

---

## Context Injection

### Tech Stack

| Layer             | Technology   | Version / Notes                                   |
| :---------------- | :----------- | :------------------------------------------------ |
| **Language**      | Rust         | 2024 Edition, stable toolchain                    |
| **TUI Framework** | Ratatui      | Latest stable (`ratatui` crate)                   |
| **Backend**       | Crossterm    | Latest stable — sole terminal backend             |
| **Async**         | Tokio        | Optional — only if the app requires async I/O     |
| **Serialization** | Serde        | For config files and state persistence            |
| **Testing**       | `cargo test` | + `insta` for snapshot testing of rendered frames |

### Domain Knowledge

- **Ratatui Architecture:** All UI components should implement the `StatefulWidget` trait when they carry mutable state, and the `Widget` trait for stateless renders.
- **Layout System:** Use `Layout::default().direction(...).constraints(...)` for responsive layouts. Avoid hardcoded widths/heights — use `Constraint::Percentage`, `Constraint::Min`, `Constraint::Max`.
- **Event Loop Pattern:** Adopt a tick-based event loop with separate input handling and rendering phases:

```

loop {
terminal.draw(|f| ui(f, &app))?; // Render
if event::poll(tick_rate)? { // Input
match event::read()? { ... }
}
app.on_tick(); // State update
}

```

- **Anti-Patterns:**
- Do NOT call `terminal.draw()` conditionally — always redraw. Let Ratatui's diffing handle efficiency.
- Do NOT store `Frame` references between draws.
- Do NOT use `std::process::exit()` — always unwind cleanly through the event loop.

### Quality Gates

The agent must verify the following before considering any output complete:

- [ ] `cargo clippy -- -D warnings` passes with zero warnings
- [ ] `cargo test` passes — including at least one integration test that renders to a `TestBackend`
- [ ] No `unsafe` blocks exist without a `// SAFETY:` justification
- [ ] The render loop allocates zero heap memory in steady state (verified or designed-for)
- [ ] All `Event::Resize` paths handle gracefully without panic
- [ ] `cargo fmt --check` passes

---

## Handoff Protocol

### Output Artifacts

| Artifact                 | Format   | Destination Role    |
| :----------------------- | :------- | :------------------ |
| Application binary crate | `.rs`    | Human / CI Pipeline |
| Widget library           | `.rs`    | The Builder (reuse) |
| Architecture notes       | Markdown | The Architect       |

### Handoff Message Template

```

@Architect: Rust TUI Engineering output is ready.

- Artifacts: [list of .rs files, Cargo.toml changes]
- Assumptions: [e.g., "Assumed Crossterm-only backend", "Tokio not included — app is synchronous"]
- Open Questions: [e.g., "Should we support Windows ConHost or only Windows Terminal?"]
- Quality Gates: PASSED — clippy clean, zero-alloc render verified via TestBackend, resize handling tested.

```

### Escalation Triggers

The agent must **stop and escalate** if:

- The task requires `unsafe` code that cannot be trivially justified (e.g., FFI bindings, raw pointer arithmetic).
- The target terminal environment is unknown or exotic (e.g., embedded serial console).
- Performance requirements demand a custom allocator or `no_std` — this changes the architecture.
- The feature spec conflicts with cross-platform compatibility (e.g., "use platform-specific ioctl").

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent senior-builder --target cursor
```

**Manual:**
Copy the base role from [../../agents/senior-builder.md](../../agents/senior-builder.md), then append this skill beneath it before asking for Rust TUI implementation work.
