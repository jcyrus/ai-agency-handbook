# Contributing to AI Agency Handbook

Thank you for your interest in contributing to the **AI Agency Handbook**! This repository provides system prompts, workflows, and playbooks for running a fractional CTO practice with AI-augmented specialist agents.

We welcome contributions from the community—whether you're adding new specialist agents, improving existing workflows, or sharing your own AI-assisted practices.

---

## Table of Contents

- [How to Contribute](#how-to-contribute)
- [Adding a New Specialist Agent](#adding-a-new-specialist-agent)
- [Improving Existing Content](#improving-existing-content)
- [Code of Conduct](#code-of-conduct)
- [License](#license)

---

## How to Contribute

### 1. Fork the Repository

Click the "Fork" button at the top right of this repository to create your own copy.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR-USERNAME/ai-agency-handbook.git
cd ai-agency-handbook
```

### 3. Create a Feature Branch

```bash
git checkout -b feature/your-contribution-name
```

### 4. Make Your Changes

Follow the guidelines below depending on what you're contributing.

### 5. Test Your Changes

- Ensure all markdown files render correctly
- Verify links work properly
- Test any system prompts with the relevant AI model
- Check that examples are clear and executable

### 6. Commit Your Changes

```bash
git add .
git commit -m "feat: add [description of contribution]"
```

Use conventional commit messages:

- `feat:` - New feature or specialist agent
- `fix:` - Bug fix or correction
- `docs:` - Documentation improvement
- `refactor:` - Restructuring without functional changes
- `chore:` - Maintenance tasks

### 7. Push to Your Fork

```bash
git push origin feature/your-contribution-name
```

### 8. Submit a Pull Request

- Go to the original repository
- Click "New Pull Request"
- Select your fork and branch
- Fill out the PR template with details about your contribution
- Submit for review

---

## Adding a New Specialist Agent

One of the most valuable contributions is adding new **Specialist Agent** configurations to expand the capabilities of AI-assisted fractional CTO practices.

### What is a Specialist Agent?

A Specialist Agent is an AI model configured with a specific system prompt to handle a particular domain of technical leadership—such as DevOps, QA, Security, Data Engineering, etc.

### Current Specialist Agents

The repository currently includes prompts for:

- **System Architect** (Claude) - Architecture design and technical requirements
- **Design DNA** (Moonchild) - UI/UX design and interaction patterns
- **Compliance Researcher** (Gemini) - Legal and regulatory compliance

### How to Add a New Specialist Agent

#### Step 1: Identify the Specialty

Determine what specialized role your agent will fulfill:

- **DevOps Engineer**: Infrastructure, deployments, observability
- **QA Specialist**: Test strategy, automation, quality assurance
- **Security Auditor**: Security reviews, vulnerability assessment
- **Data Engineer**: Data pipelines, analytics, data governance
- **Performance Engineer**: Optimization, scalability, benchmarking
- **Technical Writer**: Documentation, API specs, developer guides
- **Platform Engineer**: Developer experience, tooling, infrastructure
- Other specialized roles relevant to technical leadership

#### Step 2: Create the System Prompt File

Create a new file in the `prompts/` directory:

```bash
touch prompts/[NN]_[specialty_name].md
```

**Naming Convention**:

- Use sequential numbering (e.g., `04_`, `05_`, etc.)
- Use lowercase with underscores
- Be descriptive but concise

**Example**: `prompts/04_devops_engineer.md`

#### Step 3: Use the System Prompt Template

Copy and customize this template:

```markdown
# [Specialty Name] - System Prompt

> AI Model Recommendation: [Claude / GPT / Gemini / Other]

---

## Role Definition

You are an expert **[Specialty Name]** supporting a fractional CTO practice. Your primary responsibility is to [brief description of the role's purpose].

---

## Core Competencies

You possess deep expertise in:

1. **[Competency Area 1]**
   - [Specific skill or knowledge area]
   - [Specific skill or knowledge area]
   - [Specific skill or knowledge area]

2. **[Competency Area 2]**
   - [Specific skill or knowledge area]
   - [Specific skill or knowledge area]

3. **[Competency Area 3]**
   - [Specific skill or knowledge area]
   - [Specific skill or knowledge area]

[Add 3-5 core competency areas relevant to this specialty]

---

## Responsibilities

Your key responsibilities include:

### Primary Tasks

- [Specific task this agent performs]
- [Specific task this agent performs]
- [Specific task this agent performs]

### Deliverables

You produce the following outputs:

- **[Deliverable Type 1]**: [Description and format]
- **[Deliverable Type 2]**: [Description and format]
- **[Deliverable Type 3]**: [Description and format]

### Quality Standards

All deliverables must meet these criteria:

- [ ] [Quality standard 1]
- [ ] [Quality standard 2]
- [ ] [Quality standard 3]
- [ ] [Quality standard 4]

---

## Interaction Guidelines

### Communication Style

- **[Characteristic]**: [Description]
- **[Characteristic]**: [Description]
- **[Characteristic]**: [Description]

[Example: "Concise: Provide clear, actionable recommendations without unnecessary detail"]

### Response Format

When asked to [common task], provide:

1. **[Section Name]**: [What to include]
2. **[Section Name]**: [What to include]
3. **[Section Name]**: [What to include]

### Decision-Making Framework

When making recommendations:

1. [Step in decision process]
2. [Step in decision process]
3. [Step in decision process]

---

## Constraints & Guardrails

### Must Always:

- ✓ [Critical requirement]
- ✓ [Critical requirement]
- ✓ [Critical requirement]

### Must Never:

- ✗ [Anti-pattern or forbidden action]
- ✗ [Anti-pattern or forbidden action]
- ✗ [Anti-pattern or forbidden action]

### Escalation Triggers

Escalate to human leadership when:

- [Scenario requiring human judgment]
- [Scenario requiring human judgment]
- [Scenario requiring human judgment]

---

## Tool & Technology Stack

### Recommended Tools

[List tools this agent should be familiar with]

| Category     | Tools                        |
| ------------ | ---------------------------- |
| [Category 1] | [Tool 1], [Tool 2], [Tool 3] |
| [Category 2] | [Tool 1], [Tool 2], [Tool 3] |
| [Category 3] | [Tool 1], [Tool 2], [Tool 3] |

### Frameworks & Methodologies

- **[Framework Name]**: [When and how to apply]
- **[Framework Name]**: [When and how to apply]
- **[Framework Name]**: [When and how to apply]

---

## Example Scenarios

### Scenario 1: [Common Task]

**Input**:
```

[Example user request]

```

**Expected Output**:
```

[Example response from the agent]

```

---

### Scenario 2: [Common Task]

**Input**:
```

[Example user request]

```

**Expected Output**:
```

[Example response from the agent]

```

---

## Integration with Other Agents

This agent collaborates with:

- **[Agent Name]**: [How they interact, what handoffs occur]
- **[Agent Name]**: [How they interact, what handoffs occur]
- **[Agent Name]**: [How they interact, what handoffs occur]

---

## Metrics & Success Criteria

Track these metrics to evaluate effectiveness:

| Metric | Target | Measurement |
|--------|--------|-------------|
| [Metric name] | [Target value] | [How to measure] |
| [Metric name] | [Target value] | [How to measure] |
| [Metric name] | [Target value] | [How to measure] |

---

## References & Resources

- [Link to relevant documentation]
- [Link to relevant documentation]
- [Link to relevant documentation]

---

## Version History

- **v1.0** - [YYYY-MM-DD] - Initial release by [Your Name]

---

## Feedback & Iteration

This prompt is designed to evolve. If you find areas for improvement:
1. Document specific issues or edge cases
2. Propose refinements via pull request
3. Share results from real-world usage

---

**Maintained by**: [Your Name/Organization]
**Last Updated**: [YYYY-MM-DD]
**License**: [Same as repository]
```

#### Step 4: Customize the Template

Fill in all sections with content specific to your specialty:

- Replace placeholders with actual content
- Add domain-specific technical details
- Include realistic examples and scenarios
- Reference actual tools and frameworks
- Define clear quality standards

#### Step 5: Add Configuration (if applicable)

If your agent requires model-specific configuration (like Ollama), create a modelfile:

```bash
touch config/ollama_[specialty]_modelfile
```

Example content:

```
FROM llama2:latest

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER top_k 40

SYSTEM """
[Your system prompt content here]
"""
```

#### Step 6: Document the Workflow

If your specialist agent introduces a new workflow, create a workflow document:

```bash
touch workflows/[NN]_[workflow_name].md
```

Follow the structure of existing workflows (see `workflows/01_feature_handoff.md` for reference).

#### Step 7: Update the README

Add your new agent to the main README.md:

```markdown
### Specialist Agents

- **System Architect** (Claude) - [`prompts/01_system_architect.md`](prompts/01_system_architect.md)
- **Design DNA** (Moonchild) - [`prompts/02_design_dna.md`](prompts/02_design_dna.md)
- **Compliance Researcher** (Gemini) - [`prompts/03_compliance_researcher.md`](prompts/03_compliance_researcher.md)
- **[Your Specialty]** ([Model]) - [`prompts/[NN]_[specialty].md`](prompts/[NN]_[specialty].md) ← NEW
```

#### Step 8: Submit Your Contribution

Follow the standard pull request process described above.

---

## Improving Existing Content

### Types of Improvements Welcome

- **Clarity**: Making instructions clearer and easier to follow
- **Examples**: Adding real-world examples and use cases
- **Accuracy**: Correcting technical errors or outdated information
- **Completeness**: Filling gaps in documentation
- **Optimization**: Improving workflows based on practical experience
- **Accessibility**: Making content more accessible and inclusive

### How to Improve Existing Prompts

1. **Test the Prompt**: Use it in a real AI conversation
2. **Document Issues**: Note what worked and what didn't
3. **Propose Changes**: Edit the prompt file with improvements
4. **Explain Rationale**: In your PR, explain why the change improves the prompt
5. **Show Examples**: Include before/after examples if possible

### How to Improve Workflows

1. **Run the Workflow**: Execute it end-to-end with actual tasks
2. **Identify Pain Points**: Document where it breaks down or is unclear
3. **Suggest Refinements**: Propose specific improvements
4. **Test Improvements**: Verify your changes solve the problem
5. **Share Results**: Include metrics or outcomes in your PR

---

## Pull Request Guidelines

### PR Title Format

```
[type]: [short description]
```

Examples:

- `feat: add DevOps Engineer specialist agent`
- `docs: improve legal review loop workflow`
- `fix: correct Architect prompt decision framework`

### PR Description Template

```markdown
## Description

[Brief description of what this PR does]

## Type of Change

- [ ] New specialist agent
- [ ] Workflow improvement
- [ ] Documentation update
- [ ] Bug fix
- [ ] Other: [describe]

## Motivation

[Why is this change needed? What problem does it solve?]

## Testing

[How did you test this? What AI models did you use?]

## Screenshots/Examples

[If applicable, include examples of the agent/workflow in action]

## Checklist

- [ ] Followed the contribution guidelines
- [ ] Updated relevant documentation
- [ ] Tested with appropriate AI model
- [ ] Added examples where helpful
- [ ] Updated README if adding new content
```

---

## Code of Conduct

### Our Standards

- **Be Respectful**: Treat all contributors with respect and courtesy
- **Be Inclusive**: Welcome contributors of all backgrounds and experience levels
- **Be Constructive**: Provide helpful, actionable feedback
- **Be Professional**: Keep discussions focused on technical merit
- **Be Ethical**: Promote responsible AI practices

### Unacceptable Behavior

- Harassment, discrimination, or hostile comments
- Spam, self-promotion, or off-topic content
- Sharing proprietary information without permission
- Plagiarism or claiming others' work as your own

### Enforcement

Violations of the code of conduct will result in:

1. Warning
2. Temporary ban from contributing
3. Permanent ban (for severe or repeated violations)

Report issues to: [your contact method]

---

## Style Guide

### Markdown Formatting

- Use proper heading hierarchy (don't skip levels)
- Include a table of contents for documents > 200 lines
- Use code blocks with language specification
- Use tables for structured data
- Use bullet points for lists
- Use numbered lists for sequential steps

### Writing Style

- **Clear**: Use simple, direct language
- **Concise**: Avoid unnecessary words
- **Actionable**: Provide specific steps, not vague suggestions
- **Professional**: Executive tone appropriate for public use
- **Generic**: Avoid company-specific or proprietary details

### Prompt Engineering

- Be specific about agent capabilities and limitations
- Include clear examples and scenarios
- Define success criteria and quality standards
- Specify when to escalate to humans
- Include decision-making frameworks

---

## Testing Your Contributions

### Before Submitting

- [ ] All markdown renders correctly
- [ ] All links work (both internal and external)
- [ ] Code examples are syntactically correct
- [ ] System prompts tested with recommended AI model
- [ ] Workflows tested end-to-end
- [ ] No sensitive or proprietary information included
- [ ] Follows repository structure and naming conventions
- [ ] README updated if adding new content

### Quality Checklist

- [ ] Content is accurate and technically sound
- [ ] Examples are realistic and helpful
- [ ] Instructions are clear and complete
- [ ] Tone is professional and generic
- [ ] Content is useful to others, not just your specific use case

---

## Getting Help

### Questions About Contributing?

- **Check existing issues**: Someone may have already asked
- **Open a discussion**: Use GitHub Discussions for questions
- **Ask in your PR**: Maintainers will help refine your contribution

### Need Inspiration?

Ideas for contributions:

- Add specialist agents for: DevOps, QA, Security, Data Engineering, Performance
- Create workflows for: Incident response, Architecture reviews, Team onboarding
- Improve prompts with: Better examples, clearer decision frameworks, edge cases
- Add resources: Tool recommendations, metric templates, checklists

---

## Recognition

Contributors will be recognized in:

- Repository contributors list
- Release notes for significant contributions
- README acknowledgments section (for major contributions)

---

## License

By contributing to this repository, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](LICENSE) file).

Your contributions should be original work or properly attributed if building on others' ideas.

---

## Questions?

For questions about contributing, please:

- Open an issue with the `question` label
- Start a discussion in GitHub Discussions
- Contact the maintainers at: [contact method]

---

**Thank you for helping make this resource better for the community!**

We appreciate your time and expertise in contributing to the AI Agency Handbook. Every contribution—no matter how small—helps others build better AI-augmented fractional CTO practices.

---

**Last Updated**: February 14, 2026
**Maintained by**: [@jcyrus](https://github.com/jcyrus)
