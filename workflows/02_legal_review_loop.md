# Legal Review Loop

> Automate compliance checking using the "Librarian" agent to scan code against your compliance documentation before merging

## Overview

The Legal Review Loop ensures that all code changes are reviewed for compliance with legal, regulatory, and organizational requirements before they are merged into production. This workflow leverages the **Librarian** agent (Gemini) to perform automated compliance scans against your organization's compliance documentation.

## Agent Role

| Agent         | Model  | Primary Function                                                  |
| ------------- | ------ | ----------------------------------------------------------------- |
| **Librarian** | Gemini | Document analysis, compliance verification, policy interpretation |

---

## Prerequisites

### Required Documentation

Before implementing the Legal Review Loop, ensure you have these compliance documents organized:

```
compliance-docs/
├── README.md                          # Overview of compliance framework
├── policies/
│   ├── data-privacy-policy.md        # GDPR, CCPA, data handling
│   ├── security-policy.md            # Security standards and practices
│   ├── accessibility-policy.md       # WCAG, ADA compliance
│   └── code-of-conduct.md            # Ethical coding standards
├── regulations/
│   ├── gdpr-requirements.md          # GDPR-specific requirements
│   ├── hipaa-requirements.md         # HIPAA (if applicable)
│   ├── sox-requirements.md           # SOX (if applicable)
│   └── industry-specific.md          # Industry regulations
├── standards/
│   ├── coding-standards.md           # Language-specific standards
│   ├── api-standards.md              # API design and security
│   ├── database-standards.md         # Data storage rules
│   └── third-party-integrations.md   # Vendor compliance
└── checklists/
    ├── pre-merge-checklist.md        # Required checks before merge
    ├── security-checklist.md         # Security verification
    └── privacy-checklist.md          # Privacy verification
```

### Compliance Documentation Setup

**Step 1**: Create your compliance documentation repository

```bash
mkdir -p compliance-docs/{policies,regulations,standards,checklists}
```

**Step 2**: Document your requirements

- Work with legal team to codify policies
- Convert regulatory requirements into actionable guidelines
- Define specific rules for common scenarios

**Step 3**: Maintain version control

```bash
cd compliance-docs
git init
git add .
git commit -m "Initial compliance documentation"
```

---

## Workflow Steps

### Step 1: Prepare Code Changes for Review

**Human Action Required**

Before requesting a compliance review:

1. **Complete Development**
   - Feature implementation finished
   - All tests passing
   - Code review completed by peers

2. **Create Compliance Context Document**

```markdown
## Compliance Review Request

**PR/Branch**: [link or name]
**Feature**: [brief description]
**Author**: [name]
**Date**: [YYYY-MM-DD]

### Changes Summary

[Describe what changed at a high level]

### Files Modified

- path/to/file1.ts - [description of changes]
- path/to/file2.ts - [description of changes]
- ...

### Data Handling

- [ ] Collects personally identifiable information (PII)
- [ ] Processes payment information
- [ ] Stores health-related data
- [ ] Implements authentication/authorization
- [ ] Makes third-party API calls
- [ ] Logs user activity

### Compliance Areas to Review

- [ ] Data Privacy (GDPR, CCPA)
- [ ] Security Standards
- [ ] Accessibility (WCAG)
- [ ] Industry Regulations (HIPAA, SOX, etc.)
- [ ] Export Controls
- [ ] Open Source Licensing

### Specific Questions/Concerns

[Any areas you're uncertain about]
```

---

### Step 2: Upload Code & Context to Librarian

**Human Action Required**

1. **Gather Required Files**
   - All modified source code files
   - Relevant compliance documentation
   - Compliance Context Document

2. **Initiate Librarian Session**

   Open a conversation with your **Librarian** agent (Gemini) and upload files:

   **File Upload Process:**

   ```
   Upload Group 1: Code Changes
   - [file1.ts]
   - [file2.ts]
   - [file3.ts]
   - [etc.]

   Upload Group 2: Compliance Documentation
   - compliance-docs/policies/data-privacy-policy.md
   - compliance-docs/policies/security-policy.md
   - compliance-docs/regulations/gdpr-requirements.md
   - compliance-docs/checklists/pre-merge-checklist.md
   - [other relevant compliance docs]

   Upload Group 3: Context
   - compliance-context-document.md
   ```

   > **Note**: Upload limits vary by model. If you have many files, prioritize:
   >
   > 1. Files with data handling logic
   > 2. Files with user input processing
   > 3. Files with third-party integrations
   > 4. Most relevant compliance policies

---

### Step 3: Request Initial Compliance Scan

**Human Action Required**

Use this prompt template with the Librarian:

```
I need a compliance review of the uploaded code changes against our compliance documentation.

Please review the code changes described in the Compliance Context Document against all uploaded compliance policies and regulations.

For this initial scan, please:

1. **Identify Compliance Areas**: List all compliance domains relevant to these changes
2. **Flag Potential Issues**: Highlight any code patterns that may violate our policies
3. **Assess Risk Level**: Categorize findings as Critical, High, Medium, or Low
4. **Quick Overview**: Provide a summary of compliance status

Format your response as a Preliminary Compliance Report.

After this initial scan, I'll request a Deep Scan if needed.
```

**Expected Output from Librarian**

```markdown
## Preliminary Compliance Report

### Compliance Areas Identified

- Data Privacy (GDPR, CCPA)
- Security Standards
- [other relevant areas]

### Findings Summary

- Critical: [count]
- High: [count]
- Medium: [count]
- Low: [count]

### Quick Review

[Brief overview of compliance status]

### Recommended Next Steps

- [ ] Deep Scan required
- [ ] Specific policy review needed
- [ ] Legal team consultation recommended
```

**Decision Point** ⚡

- **No Issues**: Proceed to Step 6 (Final Approval)
- **Minor Issues (Low/Medium)**: Review and address, then re-scan
- **Significant Issues (High/Critical)**: Proceed to Step 4 (Deep Scan)

---

### Step 4: Trigger Deep Scan (If Needed)

**Human Action Required**

If the preliminary scan flagged High or Critical issues, request a Deep Scan:

```
Please perform a DEEP SCAN of the flagged compliance issues.

For each issue identified in the preliminary report:

1. **Exact Location**: File name, line numbers, and code snippet
2. **Policy Violation**: Specific policy/regulation violated (quote relevant section)
3. **Risk Analysis**: Why this is a concern and potential impact
4. **Remediation Steps**: Specific code changes required to achieve compliance
5. **Examples**: Provide compliant code examples if possible
6. **References**: Link to specific sections in our compliance docs

Additionally, check for:
- Hidden compliance risks not immediately obvious
- Cascading effects on other systems
- Edge cases that might cause compliance issues
- Missing compliance controls (encryption, logging, consent, etc.)

Format your response as a Deep Scan Compliance Report.
```

**Expected Output from Librarian**

````markdown
## Deep Scan Compliance Report

### Critical Issues

#### Issue #1: [Title]

**Location**: `src/api/user-data.ts`, lines 45-67
**Policy Violated**: Data Privacy Policy, Section 3.2 - "User Consent Required"

**Code Snippet**:

```typescript
// Line 45-67
[problematic code]
```
````

**Violation Details**:
[Explanation of why this violates policy]

**Risk Impact**:

- Legal Risk: [High/Medium/Low]
- Financial Risk: [potential fines]
- Reputational Risk: [impact assessment]

**Remediation Required**:

```typescript
// Compliant implementation:
[corrected code example]
```

**Verification Steps**:

1. [Step to verify fix]
2. [Step to verify fix]

---

[Repeat for each issue]

### Recommendations

[Additional compliance improvements]

### Compliance Certification

- [ ] All Critical issues addressed
- [ ] All High issues addressed
- [ ] Acceptable risk profile for Medium/Low issues

````

---

### Step 5: Address Compliance Issues

**Human Action Required**

1. **Review Deep Scan Report**
   - Understand each flagged issue
   - Consult with legal team if needed
   - Determine remediation priority

2. **Implement Fixes**
   - Address all Critical and High issues (non-negotiable)
   - Consider addressing Medium issues
   - Document any accepted Low risks

3. **Update Code**
   ```bash
   # Create compliance fix commit
   git checkout [feature-branch]
   # Make required changes
   git add [modified-files]
   git commit -m "fix: address compliance issues from legal review"
````

4. **Re-Scan (Verification Loop)**

   Return to Step 3 with updated code:

   ```
   I have addressed the compliance issues identified in the Deep Scan Report.

   Updated files:
   [Upload modified files]

   Please verify that all flagged compliance issues have been properly resolved.
   Provide a Compliance Verification Report.
   ```

**Expected Output from Librarian**

```markdown
## Compliance Verification Report

### Issues Resolved ✓

- Issue #1: [Title] - RESOLVED
- Issue #2: [Title] - RESOLVED
- ...

### Issues Remaining ⚠️

- Issue #X: [Title] - [Status]

### New Issues Introduced

[Any new compliance concerns from the fixes]

### Compliance Status

- [ ] Ready for merge
- [ ] Requires additional fixes
- [ ] Requires legal team review
```

**Iteration**: Repeat Step 5 until Compliance Status = "Ready for merge"

---

### Step 6: Final Compliance Approval

**Human Action Required**

Once all issues are resolved, request final sign-off:

```
Please provide a final compliance certification for this code change.

Generate a Compliance Certificate that includes:
1. Summary of all compliance areas reviewed
2. Confirmation that all policies have been satisfied
3. Any residual risks and their acceptance status
4. Recommendations for ongoing monitoring
5. Certification statement

This will be attached to the PR for audit trail purposes.
```

**Expected Output from Librarian**

```markdown
## Compliance Certificate

**PR/Branch**: [identifier]
**Review Date**: [YYYY-MM-DD]
**Reviewer**: Librarian (Gemini)
**Human Approver**: [Your name]

### Compliance Areas Reviewed

- ✓ Data Privacy (GDPR, CCPA)
- ✓ Security Standards
- ✓ Accessibility (WCAG AA)
- ✓ [Other applicable areas]

### Review Summary

All code changes have been reviewed against the organization's compliance
documentation. All Critical and High-priority issues have been resolved.

### Resolved Issues

- [Count] Critical issues resolved
- [Count] High issues resolved
- [Count] Medium issues resolved

### Accepted Residual Risks

- [Risk description]: Low priority, accepted
- [Risk description]: Low priority, accepted

### Recommendations

[Ongoing monitoring or future improvements]

### Certification

This code change has been reviewed for compliance and is approved for
merger into the codebase, subject to standard code review and testing
procedures.

**Certification ID**: [Generate unique ID]
**Timestamp**: [ISO 8601 timestamp]
```

---

### Step 7: Document & Merge

**Human Action Required**

1. **Attach Compliance Certificate to PR**

   Add the Compliance Certificate to your pull request:

   ```markdown
   ## Compliance Review

   [Paste Compliance Certificate]

   **Compliance Checklist**:

   - [x] Legal review completed
   - [x] All Critical issues resolved
   - [x] All High issues resolved
   - [x] Compliance certificate generated
   - [x] Certificate ID: [ID]
   ```

2. **Final PR Approval**
   - Obtain required code review approvals
   - Ensure all CI/CD checks pass
   - Verify compliance certificate is attached

3. **Merge to Main**

   ```bash
   # Merge via PR or command line
   git checkout main
   git merge feature-branch --no-ff
   git push origin main
   ```

4. **Archive Compliance Documentation**

   Store compliance certificate for audit trail:

   ```
   compliance-audit-trail/
   ├── 2026/
   │   ├── 02/
   │   │   ├── pr-123-compliance-cert.md
   │   │   ├── pr-124-compliance-cert.md
   ```

---

## Compliance Review Checklist

Use this checklist for every code change before merging:

### Pre-Review

- [ ] All development and testing complete
- [ ] Peer code review completed
- [ ] Compliance Context Document created
- [ ] Relevant compliance docs identified

### Review Process

- [ ] Code uploaded to Librarian
- [ ] Compliance docs uploaded to Librarian
- [ ] Initial scan completed
- [ ] Deep scan performed (if needed)
- [ ] All Critical issues resolved
- [ ] All High issues resolved
- [ ] Medium/Low issues addressed or accepted

### Post-Review

- [ ] Compliance Certificate generated
- [ ] Certificate attached to PR
- [ ] Certificate archived for audit trail
- [ ] PR approved and merged

---

## Best Practices

### Do's ✓

- **Review Early**: Run compliance checks before final code review
- **Be Comprehensive**: Upload all relevant code and compliance docs
- **Document Decisions**: Record why you accepted any residual risks
- **Maintain Compliance Docs**: Keep policies current and accessible
- **Archive Certificates**: Maintain audit trail for all reviews
- **Educate Team**: Share compliance learnings with development team

### Don'ts ✗

- **Don't Skip Reviews**: Even "small" changes can have compliance implications
- **Don't Ignore Low-Risk Issues**: They can compound over time
- **Don't Modify Certificates**: Never alter Librarian output without note
- **Don't Rush**: Compliance violations can be costly
- **Don't Work in Isolation**: Involve legal team for complex issues
- **Don't Forget to Update**: Keep compliance docs synchronized with policy changes

---

## Triggering Deep Scan

### When to Request Deep Scan

Always request a Deep Scan if:

- ✓ Preliminary scan flags Critical or High issues
- ✓ Code handles PII, payment data, or health information
- ✓ Changes affect authentication or authorization
- ✓ New third-party integrations are added
- ✓ Data crosses geographic boundaries
- ✓ User consent or opt-out mechanisms are modified
- ✓ Logging or monitoring of user activity changes

### Deep Scan Optimization

For large codebases, optimize Deep Scan by:

1. **Scope Limitation**: Focus on files that actually changed
2. **Risk Prioritization**: Scan high-risk areas first
3. **Incremental Review**: Review feature slices as they're completed
4. **Parallel Review**: Multiple team members can review different compliance areas

---

## Compliance Documentation Maintenance

### Quarterly Review

Every quarter, update compliance documentation:

- [ ] Review all policies against current regulations
- [ ] Update technical standards and best practices
- [ ] Incorporate lessons learned from compliance reviews
- [ ] Add new compliance scenarios encountered
- [ ] Remove or deprecate outdated requirements

### Version Control

Track compliance documentation changes:

```bash
# Tag compliance doc releases
cd compliance-docs
git tag -a v2026.Q1 -m "Q1 2026 compliance update"
git push origin v2026.Q1
```

### Accessibility

Ensure compliance docs are:

- Written in clear, unambiguous language
- Searchable and well-organized
- Include practical code examples
- Link to authoritative sources (laws, regulations)
- Versioned with effective dates

---

## Troubleshooting

| Issue                               | Solution                                                                |
| ----------------------------------- | ----------------------------------------------------------------------- |
| **Librarian flags false positives** | Refine compliance documentation with more specific rules and exceptions |
| **Upload limits exceeded**          | Prioritize most critical files; consider reviewing in batches           |
| **Ambiguous policy interpretation** | Consult legal team; update compliance docs with clarification           |
| **Deep Scan takes too long**        | Break into smaller scopes; review incrementally during development      |
| **Compliance docs outdated**        | Schedule quarterly review; assign compliance doc owner                  |

---

## Integration with CI/CD

### Automated Compliance Checks

Consider integrating automated compliance tools:

```yaml
# .github/workflows/compliance-check.yml
name: Compliance Check

on: [pull_request]

jobs:
  compliance:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Static Analysis
        run: |
          # Run automated compliance scanners
          npm run compliance:scan
      - name: Flag for Manual Review
        if: failure()
        run: |
          echo "⚠️ Compliance issues detected - manual Librarian review required"
```

### Manual Review Trigger

Add PR comment trigger:

```
/compliance-review
```

This signals that Librarian review has been completed and certificate is attached.

---

## Metrics to Track

Monitor these compliance review metrics:

- **Review Cycle Time**: Time from review request to certification
- **Issue Detection Rate**: % of PRs with compliance issues
- **Issue Severity Distribution**: Critical/High/Medium/Low breakdown
- **False Positive Rate**: Issues flagged incorrectly
- **Remediation Time**: Time to fix flagged issues
- **Policy Coverage**: % of policies actively enforced

---

## Support & Escalation

### When to Escalate to Legal Team

Escalate if:

- Compliance violation could result in regulatory penalties
- Ambiguous policy interpretation affects major feature
- New regulatory requirement needs to be incorporated
- Cross-border data transfer implications
- Customer contract compliance questions

### Contact

For questions about this workflow or compliance documentation, see [CONTRIBUTING.md](../CONTRIBUTING.md).

---

## Appendix: Sample Compliance Policies

### Data Privacy Policy Example

````markdown
## User Consent Requirements

**Policy**: All collection of personally identifiable information (PII)
must include explicit user consent.

**Technical Implementation**:

- Display clear consent language before data collection
- Store consent timestamp and version of privacy policy
- Provide mechanism to withdraw consent
- Delete data within 30 days of consent withdrawal

**Code Pattern (Compliant)**:

```typescript
async function collectUserEmail(email: string, userId: string) {
  // Verify consent was obtained
  const consent = await getConsent(userId, "email_collection");
  if (!consent || !consent.isValid()) {
    throw new Error("User consent required");
  }

  // Log consent for audit trail
  await logConsentAction(userId, "email_collected", consent.version);

  // Proceed with data collection
  await saveEmail(userId, email);
}
```
````

**Non-Compliant Pattern**:

```typescript
// ❌ Missing consent check
async function collectUserEmail(email: string, userId: string) {
  await saveEmail(userId, email);
}
```

```

---

**Last Updated**: February 2026
**Version**: 1.0
**Maintained by**: [Your Organization]
```
