# Skill Definition: Glassmorphism UI Engineering

**Skill ID:** `02_glassmorphism_ui`
**Version:** 1.0
**Last Updated:** 2026-02-27

---

## Target Role

| Field             | Value                                                 |
| :---------------- | :---------------------------------------------------- |
| **Primary Role**  | The Visionary                                         |
| **Model Target**  | Google Stitch / Gemini 3 Pro                          |
| **Fallback Role** | The Builder (for implementation in Next.js / Flutter) |

---

## Core Directives

### 1. OLED-First Dark Aesthetic

- **Primary background:** Pure OLED black `#000000`. No dark grays (`#1a1a1a`, `#121212`). Black means black.
- **Secondary surfaces:** Maximum `#050510` (Midnight Blue) for layered depth — never lighter.
- **Text hierarchy:** Primary text `#FFFFFF` at 95% opacity. Secondary text at 60% opacity. Tertiary/disabled at 35% opacity.
- **Rationale:** OLED screens turn off pixels at `#000000`, saving power and producing true infinite contrast. Every deviation from pure black must be intentional and justified.

### 2. Glassmorphism Execution Standards

- **Blur:** All glass surfaces must use `backdrop-filter: blur(24px)` minimum. Never below `16px`.
- **Surface opacity:** Glass cards use white at 8–12% opacity (`bg-white/8` to `bg-white/12` in Tailwind, `Colors.white.withOpacity(0.1)` in Flutter).
- **Border treatment:** 1px inner stroke at `border-white/10`. No hard borders. No box shadows in lieu of glass — the blur IS the depth cue.
- **Layering:** Maximum 3 glass layers deep. Each successive layer increases blur by `+8px` and decreases opacity by `-2%` to maintain readability.
- **Fallback:** For browsers/devices that do not support `backdrop-filter`, fall back to a solid `bg-black/90` surface. Use `@supports` in CSS.

### 3. Neon Accent System

- **Primary accent:** Neon Mint `#00FF94` — used for CTAs, active states, and success indicators.
- **Secondary accent:** Electric Violet `#8B5CF6` — used for links, hover states, and informational highlights.
- **Danger accent:** Hot Coral `#FF3B5C` — reserved for errors, destructive actions, and critical warnings.
- **Glow implementation:** Accents must include a glow effect via `box-shadow: 0 0 20px rgba(accent, 0.3)` or equivalent. No flat neon — the glow is what sells the aesthetic.
- **Usage cap:** Neon accents should cover ≤15% of any viewport. Overuse kills the effect.

### 4. Motion & Transitions

- **Default transition:** `transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1)` (Material ease-out).
- **Hover states:** Scale `1.02x` + inner glow intensification. No abrupt color swaps.
- **Page transitions:** Fade-in at `200ms` minimum. Consider `framer-motion` (Next.js) or Flutter's `Hero` widget for cross-route animations.
- **Reduced motion:** Respect `prefers-reduced-motion: reduce`. Disable all non-essential animations. Glow effects may remain static.

---

## Context Injection

### Tech Stack — Next.js Implementation

| Layer          | Technology     | Notes                                       |
| :------------- | :------------- | :------------------------------------------ |
| **Framework**  | Next.js 15+    | App Router, React Server Components         |
| **Styling**    | Tailwind CSS 4 | With `backdrop-filter` plugin enabled       |
| **Components** | shadcn/ui      | Rethemed to glassmorphic tokens below       |
| **Animation**  | Framer Motion  | For page transitions and micro-interactions |
| **Fonts**      | Inter / SF Pro | Via `next/font`, tight tracking on headings |

#### Tailwind Token Reference

```css
/* tailwind.config — extend theme */
colors: {
  glass: {
    surface: 'rgba(255, 255, 255, 0.08)',
    border: 'rgba(255, 255, 255, 0.10)',
    hover: 'rgba(255, 255, 255, 0.12)',
  },
  neon: {
    mint: '#00FF94',
    violet: '#8B5CF6',
    coral: '#FF3B5C',
  },
  oled: {
    black: '#000000',
    midnight: '#050510',
  },
}
```

#### Component Pattern (Next.js + Tailwind)

```tsx
<div className="relative rounded-2xl border border-white/10 bg-white/8 p-6 backdrop-blur-[24px]">
  <h2 className="text-lg font-semibold tracking-tight text-white/95">
    Card Title
  </h2>
  <p className="mt-2 text-sm text-white/60">Supporting text.</p>
  <button className="mt-4 rounded-lg bg-neon-mint px-4 py-2 text-sm font-medium text-black shadow-[0_0_20px_rgba(0,255,148,0.3)] transition-all duration-300 hover:scale-[1.02] hover:shadow-[0_0_30px_rgba(0,255,148,0.5)]">
    Action
  </button>
</div>
```

### Tech Stack — Flutter Implementation

| Layer         | Technology       | Notes                                         |
| :------------ | :--------------- | :-------------------------------------------- |
| **Framework** | Flutter 3.x      | Material 3 base, overridden with glass tokens |
| **State**     | Riverpod / Bloc  | Provider-based state management               |
| **Animation** | Built-in         | `AnimatedContainer`, `Hero`, `FadeTransition` |
| **Blur**      | `BackdropFilter` | `dart:ui` — `ImageFilter.blur(sigmaX: 24)`    |

#### Component Pattern (Flutter)

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Card Title', style: TextStyle(color: Colors.white.withOpacity(0.95))),
          const SizedBox(height: 8),
          Text('Supporting text.', style: TextStyle(color: Colors.white.withOpacity(0.60))),
        ],
      ),
    ),
  ),
)
```

### Quality Gates

- [ ] All surfaces on `#000000` background — no dark grays leaking through
- [ ] `backdrop-filter: blur()` is present on every glass surface (`@supports` fallback in place)
- [ ] Neon accents include glow `box-shadow` — no flat colors on interactive elements
- [ ] `prefers-reduced-motion` media query disables non-essential animations
- [ ] Lighthouse Accessibility score ≥ 90 (contrast ratios validated against OLED black)
- [ ] Glass layering does not exceed 3 levels deep
- [ ] Mobile responsiveness verified — blur performance acceptable on mid-range devices

---

## Handoff Protocol

### Output Artifacts

| Artifact              | Format               | Destination Role |
| :-------------------- | :------------------- | :--------------- |
| Tailwind theme config | `tailwind.config.ts` | The Builder      |
| Design tokens (Figma) | JSON                 | The Visionary    |
| Component library     | `.tsx` / `.dart`     | The Builder      |
| Interaction spec      | Markdown             | The Architect    |

### Handoff Message Template

```
@Builder: Glassmorphism UI output is ready.
- Artifacts: [Tailwind config, component files, Figma token JSON]
- Assumptions: ["Browser supports backdrop-filter", "OLED target displays", "Dark mode only — no light theme variant"]
- Open Questions: ["Should we provide a high-contrast accessibility mode?", "Blur performance budget on mobile?"]
- Quality Gates: PASSED — OLED black verified, glow effects present, reduced-motion respected.
```

### Escalation Triggers

The agent must **stop and escalate** if:

- The target platform does not support `backdrop-filter` (e.g., certain WebViews, older Android system browsers) — alternative design strategy needed.
- Accessibility audit reveals contrast ratios below WCAG AA on glass surfaces — fundamental aesthetic conflict requires human decision.
- Client or stakeholder requests a light mode variant — this is an architectural decision, not a skin swap.
- Performance profiling shows blur causing >16ms frame times on target devices.

## Quick Start

**Automated (recommended):**

```bash
bash scripts/install-agent.sh --agent design-visionary --target cursor
```

**Manual:**
Copy the base role from [../../agents/design-visionary.md](../../agents/design-visionary.md), then append this skill when you need a glassmorphism-focused design pass.
