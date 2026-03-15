# Google Stitch Migration Notes

This brief captures the current content surfaces that will need redesign when the handbook moves into a Google Stitch-driven UI system. It is a planning document only and does not introduce UI code.

## Current Layouts That Need Redesign

### Root README landing page

- Needs a clearer entry hierarchy for handbook sections, install commands, and GitBook publishing
- Should evolve from a dense repository overview into a product-style landing page with strong section cards

### Agent directory

- Needs a browsable index with division filters, use-case grouping, and clearer onboarding guidance
- Should support scanning by role, not just by filename

### Handbook section pages

- Need a consistent pattern for overview, quick start, primary content, and related links
- Should visually separate executable commands from reference-only guidance

### Workflow pages

- Need diagram-friendly layouts with clearer stage transitions and escalation checkpoints
- Should emphasize approvals, decision points, and output artifacts

## Recommended Stitch Prompt Templates

### Landing page prompt

```text
Design a GitBook-compatible landing page for an AI agency handbook using Google's Material You design language.
Create a hero section, a 4-card section overview, a quick-start command strip, and a contribution CTA.
Optimize for desktop reading, tablet browsing, and narrow mobile screens.
```

### Agent directory prompt

```text
Design an index page for 10 AI agent personas in Material You style.
Include filter chips by division, compact cards with identity and mission summaries, and a visible install action for each agent.
Prioritize scanability and documentation readability over dashboard density.
```

### Workflow page prompt

```text
Design a documentation page for a multi-step AI workflow in Material You style.
Use numbered stages, decision callouts, and compact artifact summaries.
Include responsive behavior that turns wide diagrams into stacked mobile cards.
```

### Handbook chapter prompt

```text
Design a documentation chapter template in Material You style.
Include an intro summary, quick-start command card, standards section, and related resources sidebar.
Balance editorial readability with technical clarity.
```

## Material You Color Tokens

- Primary: `#0B57D0`
- On Primary: `#FFFFFF`
- Secondary: `#386A20`
- Tertiary: `#7B1FA2`
- Surface: `#F8F9FA`
- Surface Container: `#EEF2F6`
- Surface Variant: `#DDE3EA`
- Outline: `#6B7280`
- Error: `#B3261E`
- On Surface: `#1F1F1F`

## Typography Guidelines

- Use Google Sans for headings and navigational emphasis when licensing allows the target surface to support it
- Use Roboto for body copy, tables, and code-adjacent UI labels
- Keep chapter titles in a strong display scale, but use compact section headings to preserve handbook density
- Preserve generous line-height for documentation paragraphs and avoid display styling inside code blocks

## Migration Guidance

- Replace glassmorphism-heavy page framing with Material You surface layering and tonal separation
- Keep command blocks visually prominent, but avoid dashboard chrome that competes with the written guidance
- Preserve a neutral documentation background and use color for navigation, emphasis, and status instead of full-page theming
- Build components that map cleanly to GitBook content blocks so the visual system does not depend on bespoke layout code
