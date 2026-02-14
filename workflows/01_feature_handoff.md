# Feature Handoff Workflow

> A systematic approach to passing feature development through your AI specialist team: Architect → Designer → Builder

## Overview

This workflow ensures that feature requirements are properly analyzed, designed, and implemented through a multi-agent development pipeline. Each AI specialist plays a distinct role in the feature development lifecycle.

## Agent Roles

| Agent         | Model     | Primary Function                                              |
| ------------- | --------- | ------------------------------------------------------------- |
| **Architect** | Claude    | System design, technical requirements, architecture decisions |
| **Designer**  | Moonchild | UI/UX design, interaction patterns, visual specifications     |
| **Builder**   | GPT       | Code implementation, testing, deployment                      |

---

## Workflow Steps

### Step 1: Initial Feature Request

**Human Action Required**

Document the feature request with the following information:

```markdown
## Feature Request

**Feature Name**: [Name]
**Business Objective**: [Why we're building this]
**User Story**: As a [user type], I want [goal], so that [benefit]
**Success Criteria**: [Measurable outcomes]
**Constraints**: [Timeline, budget, technical limitations]
**Reference Materials**: [Links, mockups, competitor examples]
```

Save this to your project documentation or issue tracker.

---

### Step 2: Architect Analysis (Claude)

**Human Action Required**

1. Open a conversation with your **Architect** agent (Claude)
2. Provide the feature request document
3. Use this prompt template:

```
I need you to analyze this feature request from a system architecture perspective.

[Paste Feature Request]

Please provide:
1. Technical requirements breakdown
2. System architecture recommendations
3. Data model considerations
4. API design (if applicable)
5. Integration points with existing systems
6. Technical risks and mitigation strategies
7. Estimated complexity (T-shirt size: S/M/L/XL)

Format your response as an Architecture Specification Document.
```

**Expected Output from Architect**

- Architecture Specification Document (ASD)
- Technical requirements list
- System diagrams (if complex)
- Risk assessment
- Recommended tech stack components

**Human Review Checkpoint** ✓

Review the Architecture Specification Document:

- Does it align with business objectives?
- Are technical risks acceptable?
- Is the proposed approach feasible within constraints?

If approved, proceed to Step 3. If not, iterate with the Architect.

---

### Step 3: Designer Specification (Moonchild)

**Human Action Required**

1. Open a conversation with your **Designer** agent (Moonchild)
2. Provide both the original feature request AND the Architecture Specification Document
3. Use this prompt template:

```
I need you to design the user experience and interface for this feature.

**Feature Request:**
[Paste Feature Request]

**Architecture Specification:**
[Paste relevant sections from ASD, especially user-facing components]

Please provide:
1. User flow diagrams
2. Wireframes or UI specifications
3. Interaction patterns and micro-interactions
4. Accessibility considerations (WCAG AA compliance)
5. Responsive design requirements (mobile, tablet, desktop)
6. Design system components to use or create
7. Error states and edge cases

Format your response as a Design Specification Document.
```

**Expected Output from Designer**

- Design Specification Document (DSD)
- User flow diagrams
- Component specifications
- Style guide references
- Interaction patterns
- Accessibility checklist

**Human Review Checkpoint** ✓

Review the Design Specification Document:

- Does the UX support the user story effectively?
- Is the design consistent with existing design system?
- Are accessibility requirements addressed?
- Is the design feasible to implement within timeline?

If approved, proceed to Step 4. If not, iterate with the Designer.

---

### Step 4: Implementation Brief Preparation

**Human Action Required**

Consolidate the approved specifications into an Implementation Brief:

```markdown
## Implementation Brief

### Feature Overview

[1-2 paragraph summary]

### Technical Requirements

[From Architecture Specification Document]

- Requirement 1
- Requirement 2
- ...

### Design Requirements

[From Design Specification Document]

- Component 1: [specifications]
- Component 2: [specifications]
- ...

### Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3
- [ ] All unit tests pass
- [ ] Accessibility requirements met
- [ ] Performance benchmarks achieved
- [ ] Documentation updated

### Files to Modify/Create

[List of expected file changes based on architecture review]

### Dependencies

[External libraries, APIs, or systems required]

### Testing Requirements

- Unit tests: [specific scenarios]
- Integration tests: [specific flows]
- E2E tests: [critical user paths]
```

Save this Implementation Brief for the Builder phase.

---

### Step 5: Builder Implementation (GPT)

**Human Action Required**

1. Open a conversation with your **Builder** agent (GPT)
2. Provide the Implementation Brief
3. Use this prompt template:

```
I need you to implement this feature according to the specifications.

[Paste Implementation Brief]

Please follow these guidelines:
1. Write clean, well-documented code following our coding standards
2. Include comprehensive unit tests
3. Consider edge cases and error handling
4. Ensure accessibility compliance
5. Follow the design specifications exactly
6. Use TypeScript for type safety (if applicable)
7. Implement proper logging and observability

Start with a high-level implementation plan, then proceed with the code.
```

**Expected Output from Builder**

- Implementation plan
- Code files (full implementations)
- Unit tests
- Integration tests (if applicable)
- Documentation updates
- Migration scripts (if needed)

**Implementation Checkpoints**

During implementation, the Builder should:

1. Break work into logical commits
2. Request clarification if specifications are ambiguous
3. Flag any deviations from the original design
4. Highlight any technical debt introduced
5. Suggest optimizations or improvements

---

### Step 6: Human Review & Integration

**Human Action Required**

1. **Code Review**
   - Review all generated code for quality and correctness
   - Ensure adherence to team coding standards
   - Verify security best practices are followed
   - Check for performance implications

2. **Testing**
   - Run all automated tests
   - Perform manual testing of critical paths
   - Test edge cases and error scenarios
   - Verify accessibility with screen reader
   - Test across required browsers/devices

3. **Compliance Check** (See [Legal Review Loop](./02_legal_review_loop.md))
   - Run compliance scan before merging
   - Address any flagged issues

4. **Integration**

   ```bash
   # Create feature branch
   git checkout -b feature/[feature-name]

   # Add generated code
   git add [files]
   git commit -m "feat: [feature description]"

   # Push and create PR
   git push origin feature/[feature-name]
   ```

5. **Documentation**
   - Update README if needed
   - Add API documentation
   - Update changelog
   - Create user-facing documentation

---

### Step 7: Deployment & Monitoring

**Human Action Required**

1. **Staging Deployment**
   - Deploy to staging environment
   - Run smoke tests
   - Perform UAT (User Acceptance Testing)
   - Get stakeholder sign-off

2. **Production Deployment**
   - Follow standard deployment procedure
   - Enable feature flag (if using gradual rollout)
   - Monitor error rates and performance metrics

3. **Post-Deployment**
   - Monitor for 24-48 hours
   - Track usage analytics
   - Gather user feedback
   - Document lessons learned

---

## Best Practices

### Do's ✓

- **Be Specific**: Provide detailed context to each agent
- **Iterate**: Don't hesitate to refine specifications with agents
- **Document Everything**: Maintain a clear paper trail of decisions
- **Review Critically**: AI output should be reviewed, not blindly accepted
- **Test Thoroughly**: Automated tests + manual verification
- **Communicate**: Keep stakeholders informed at each milestone

### Don'ts ✗

- **Don't Skip Steps**: Each phase builds on the previous
- **Don't Assume**: Always verify AI output against requirements
- **Don't Rush**: Proper planning prevents implementation issues
- **Don't Ignore Warnings**: If an agent flags a risk, investigate
- **Don't Forget Compliance**: Security and legal review before merge
- **Don't Deploy Without Testing**: Always test in staging first

---

## Handoff Checklist

Use this checklist to ensure smooth transitions between phases:

### Architect → Designer Handoff

- [ ] Architecture Specification Document completed
- [ ] Technical risks documented and accepted
- [ ] Data models defined
- [ ] API contracts specified
- [ ] Integration points identified

### Designer → Builder Handoff

- [ ] Design Specification Document completed
- [ ] All UI components specified
- [ ] User flows documented
- [ ] Accessibility requirements defined
- [ ] Error states designed
- [ ] Implementation Brief consolidated

### Builder → Deployment

- [ ] Code implementation complete
- [ ] Unit tests passing (>80% coverage)
- [ ] Integration tests passing
- [ ] Documentation updated
- [ ] Compliance review passed
- [ ] Performance benchmarks met
- [ ] Staging deployment successful

---

## Troubleshooting Common Issues

| Issue                                           | Solution                                                                                 |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Architect and Designer disagree on approach** | Human arbitration required; consider technical constraints vs. user experience tradeoffs |
| **Builder can't implement design as specified** | Loop back to Designer for alternative approach that's technically feasible               |
| **Specifications are ambiguous**                | Pause implementation; clarify with relevant agent before proceeding                      |
| **Timeline issues**                             | Re-scope with Architect; consider MVP approach or phased delivery                        |
| **Technical debt introduced**                   | Document in ADR; create follow-up tasks for refactoring                                  |

---

## Workflow Variations

### Fast-Track (Simple Features)

For small features (< 1 day effort):

- Combine Steps 2-3: Single conversation with Architect for both technical and basic UX guidance
- Skip Designer phase if no significant UI changes
- Proceed directly to Builder implementation

### Complex Features (Multi-Week)

For large features:

- Break into smaller vertical slices
- Run complete workflow for each slice
- Schedule regular sync meetings between phases
- Consider creating a feature specification document that evolves through all phases

---

## Templates & Resources

### Architecture Specification Document Template

See: `templates/architecture_spec.md`

### Design Specification Document Template

See: `templates/design_spec.md`

### Implementation Brief Template

See: `templates/implementation_brief.md`

---

## Metrics to Track

Monitor these metrics to optimize your workflow:

- **Cycle Time**: Time from feature request to production
- **Rework Rate**: How often you need to go back to previous phases
- **Defect Rate**: Bugs found post-deployment
- **AI Accuracy**: % of AI-generated content that passes human review unchanged
- **Test Coverage**: Automated test coverage of new code

---

## Feedback Loop

After each feature deployment:

1. **Retrospective**: What went well? What could improve?
2. **Agent Refinement**: Update system prompts based on learnings
3. **Workflow Optimization**: Adjust steps for better efficiency
4. **Documentation Updates**: Keep this workflow current

---

## Support

For questions about this workflow or to suggest improvements, see [CONTRIBUTING.md](../CONTRIBUTING.md).
