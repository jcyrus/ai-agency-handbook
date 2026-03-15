# Legal Review Loop

> Use the Librarian agent to scan code changes against your compliance docs before merge.

## Quick Start

```bash
bash scripts/install-agent.sh --agent compliance-researcher --target cursor
```

Or copy the role page directly: [Compliance Researcher](../agents/compliance-researcher.md)

## Overview

| Agent         | Model  | Function                                                          |
| ------------- | ------ | ----------------------------------------------------------------- |
| **Librarian** | Gemini | Document analysis, compliance verification, policy interpretation |

The Librarian cross-references code changes against your compliance corpus and produces a certification you attach to the PR for audit.

---

## Prerequisites

Organize compliance documentation in a structure like:

```
compliance-docs/
├── policies/          # data-privacy, security, accessibility, code-of-conduct
├── regulations/       # GDPR, HIPAA, SOX, industry-specific
├── standards/         # coding, API, database, third-party integrations
└── checklists/        # pre-merge, security, privacy
```

Work with your legal team to codify policies into actionable, version-controlled guidelines.

---

## Workflow

### 1. Prepare a Compliance Context Document

Before requesting review, ensure development is complete, tests pass, and peer review is done. Then create a brief context doc:

- PR/branch link, feature description, author, date
- High-level changes summary and list of modified files
- Data-handling flags (PII, payments, health data, auth, third-party APIs, user logging)
- Which compliance areas apply (privacy, security, accessibility, licensing, etc.)
- Any specific questions or concerns

### 2. Upload to the Librarian

Open a conversation with the **Librarian** (Gemini). Upload:

1. Modified source files (prioritize data-handling, auth, and integration code)
2. Relevant compliance docs from your corpus
3. The Compliance Context Document

### 3. Initial Compliance Scan

Ask the Librarian to review the code against the uploaded policies. Request:

- Compliance areas identified
- Findings categorized as Critical / High / Medium / Low
- Quick status overview
- Whether a Deep Scan is needed

**Decision point:**

| Result          | Action                    |
| --------------- | ------------------------- |
| No issues       | Skip to Step 6            |
| Low/Medium only | Fix, re-scan, then Step 6 |
| High/Critical   | Proceed to Step 4         |

### 4. Deep Scan

Request a deep scan when the initial pass flags High/Critical issues, or whenever code handles PII, payment data, health info, auth, cross-border transfers, or consent mechanisms.

For each issue the Librarian should provide:

- Exact file + line numbers + code snippet
- Specific policy section violated (quoted)
- Risk analysis and potential impact
- Concrete remediation steps with compliant code examples

### 5. Fix and Re-Scan

1. Address all Critical and High issues (non-negotiable). Consider Medium; document any accepted Low risks.
2. Commit fixes: `git commit -m "fix: address compliance issues from legal review"`
3. Re-upload modified files and ask the Librarian to verify. Repeat until status is clean.

### 6. Final Certification

Request a Compliance Certificate covering:

- Areas reviewed and confirmation that all policies are satisfied
- Resolved issue counts by severity
- Accepted residual risks
- Recommendations for ongoing monitoring
- Certification statement with unique ID and timestamp

### 7. Merge

1. Paste the Compliance Certificate into the PR description
2. Archive the certificate (e.g., `compliance-audit-trail/2026/03/pr-NNN.md`)
3. Obtain final approvals, confirm CI passes, and merge

---

## Pre-Merge Checklist

### Before review

- [ ] Development and testing complete
- [ ] Peer code review done
- [ ] Compliance Context Document created

### During review

- [ ] Initial scan completed
- [ ] Deep scan performed (if needed)
- [ ] All Critical/High issues resolved
- [ ] Medium/Low addressed or accepted

### After review

- [ ] Compliance Certificate generated and attached to PR
- [ ] Certificate archived for audit trail

---

## When to Trigger a Deep Scan

- Preliminary scan flags Critical or High issues
- Code handles PII, payment data, or health information
- Changes affect authentication or authorization
- New third-party integrations added
- Data crosses geographic boundaries
- User consent or logging mechanisms modified

---

## Troubleshooting

| Issue                           | Resolution                                                     |
| ------------------------------- | -------------------------------------------------------------- |
| False positives                 | Refine compliance docs with more specific rules and exceptions |
| Upload limits exceeded          | Prioritize highest-risk files; review in batches               |
| Ambiguous policy interpretation | Consult legal team; update compliance docs with clarification  |
| Compliance docs outdated        | Schedule quarterly review; assign a compliance doc owner       |

---

## Escalation

Escalate to the legal team when:

- A violation could result in regulatory penalties
- An ambiguous policy interpretation affects a major feature
- New regulatory requirements need to be incorporated
- Cross-border data transfer or customer contract questions arise

---

## Appendix: Compliant vs. Non-Compliant Pattern

**Compliant** — consent check before collecting PII:

```typescript
async function collectUserEmail(email: string, userId: string) {
  const consent = await getConsent(userId, "email_collection");
  if (!consent || !consent.isValid()) {
    throw new Error("User consent required");
  }
  await logConsentAction(userId, "email_collected", consent.version);
  await saveEmail(userId, email);
}
```

**Non-compliant** — missing consent check:

```typescript
async function collectUserEmail(email: string, userId: string) {
  await saveEmail(userId, email); // no consent verification
}
```
