# Feature Handoff Workflow

> Architect → Designer → Builder — a three-agent pipeline for feature development.

## Quick Start

```bash
# Install the three pipeline agents
bash scripts/install-agent.sh --agent system-architect --target cursor
bash scripts/install-agent.sh --agent design-visionary  --target cursor
bash scripts/install-agent.sh --agent senior-builder    --target cursor
```

Or grab the role pages directly: [Architect](../agents/system-architect.md) · [Designer](../agents/design-visionary.md) · [Builder](../agents/senior-builder.md)

## Pipeline Overview

| Phase       | Agent     | Produces                                  |
| ----------- | --------- | ----------------------------------------- |
| 1 — Analyze | Architect | Architecture Specification Document (ASD) |
| 2 — Design  | Designer  | Design Specification Document (DSD)       |
| 3 — Build   | Builder   | Implementation + tests                    |

---

## Step 1: Write the Feature Request

Document the request before engaging any agent:

- **Feature name** and business objective
- **User story**: _As a [user], I want [goal], so that [benefit]_
- **Success criteria** (measurable)
- **Constraints**: timeline, budget, tech limitations
- **References**: links, mockups, competitor examples

Save this in your project docs or issue tracker.

---

## Step 2: Architect Analysis

Open a conversation with the **Architect** and paste your feature request. Ask for:

1. Technical requirements breakdown
2. Architecture recommendations & data models
3. API design (if applicable)
4. Integration points with existing systems
5. Risk assessment with mitigations
6. Complexity estimate (S/M/L/XL)

Output should follow the [Architecture Spec template](../handbook/templates/architecture-spec.md).

**Review checkpoint** — confirm the ASD aligns with business goals and constraints before proceeding.

---

## Step 3: Designer Specification

Open a conversation with the **Designer**. Provide the feature request _and_ the approved ASD. Ask for:

1. User flows and wireframes
2. Component specifications and interaction patterns
3. Accessibility plan (WCAG AA)
4. Responsive breakpoints
5. Error states and edge cases

Output should follow the [Design Spec template](../handbook/templates/design-spec.md).

**Review checkpoint** — confirm UX supports the user story and is feasible within timeline.

---

## Step 4: Implementation Brief

Consolidate approved ASD + DSD into an [Implementation Brief](../handbook/templates/implementation-brief.md):

- Feature overview (1-2 paragraphs)
- Technical requirements (from ASD)
- Design requirements (from DSD)
- Acceptance criteria checklist
- Files to modify/create
- Dependencies & testing requirements

---

## Step 5: Builder Implementation

Provide the Implementation Brief to the **Builder**. The Builder should:

- Produce clean, tested code matching the design specs
- Break work into logical commits
- Flag deviations, ambiguities, or introduced tech debt
- Include unit tests, integration tests where applicable, and doc updates

---

## Step 6: Review & Merge

1. **Code review** — quality, security, adherence to standards
2. **Test** — automated suite + manual verification of critical paths
3. **Compliance** — run the [Legal Review Loop](./legal-review-loop.md) before merge
4. **Integrate** — feature branch → PR → merge
5. **Document** — update README, API docs, changelog as needed

---

## Step 7: Deploy & Monitor

1. Deploy to staging → smoke tests → UAT → stakeholder sign-off
2. Deploy to production (feature flag if gradual rollout)
3. Monitor error rates, performance, and user feedback for 24-48 hours

---

## Handoff Checklists

### Architect → Designer

- [ ] ASD completed and approved
- [ ] Risks documented · data models defined · API contracts specified

### Designer → Builder

- [ ] DSD completed and approved
- [ ] Components, flows, accessibility, and error states specified
- [ ] Implementation Brief consolidated

### Builder → Deployment

- [ ] Code complete · tests passing (>80% coverage)
- [ ] Docs updated · compliance review passed · staging verified

---

## Workflow Variations

**Fast-track** (< 1 day effort): Combine Architect + Designer into one conversation; skip full DSD if no significant UI changes.

**Multi-week features**: Break into vertical slices; run the full pipeline per slice.

---

## Troubleshooting

| Issue                              | Resolution                                               |
| ---------------------------------- | -------------------------------------------------------- |
| Architect and Designer disagree    | Human arbitrates — weigh technical feasibility vs. UX    |
| Builder can't implement the design | Loop back to Designer for a feasible alternative         |
| Specs are ambiguous                | Pause; clarify with the relevant agent before continuing |
| Timeline pressure                  | Re-scope with Architect; consider MVP or phased delivery |
