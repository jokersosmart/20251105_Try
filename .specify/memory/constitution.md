<!--
Sync Impact Report:
- Version: 1.0.0 → 1.1.0 (Minor Amendment)
- Modified Principles: None
- Added Sections: V. Documentation & Localization Standards
- Removed Sections: None
- Templates Status:
  ✅ plan-template.md - Constitution Check updated with localization requirement
  ✅ spec-template.md - Constitution Compliance updated with language requirement
  ✅ tasks-template.md - Compliance validation updated with localization check
- Follow-up TODOs: None

Change Summary (v1.1.0):
Added new core principle V: Documentation & Localization Standards
- All specifications, plans, and user-facing documentation MUST be in Traditional Chinese (zh-TW)
- Code comments and technical documentation may be in English for international collaboration
- UI text and error messages MUST be in Traditional Chinese
- Establishes clear scope for localization requirements

Previous History:
- v1.0.0 (2025-11-19): Initial constitution with four core principles
-->

# SpecKit Constitution

## Core Principles

### I. Code Quality & Maintainability

**Non-negotiable Requirements**:
- All code MUST pass linting and static analysis before commit
- Code MUST be self-documenting with clear naming conventions
- Complex logic (cyclomatic complexity >10) MUST be justified and documented
- Code reviews MUST verify readability, maintainability, and adherence to style guides
- Technical debt MUST be tracked and addressed within 2 sprint cycles
- Dead code and unused dependencies MUST be removed immediately

**Rationale**: Maintainable code reduces long-term costs, enables faster iterations, and minimizes bugs. Poor code quality creates compounding technical debt that slows development velocity exponentially.

**Standards**:
- Function length: Maximum 50 lines (excluding tests)
- Class length: Maximum 300 lines
- Duplicate code: Zero tolerance - DRY principle enforced
- Code comments: Required only for "why", not "what" (code should be self-explanatory)
- Documentation: Every public API MUST have usage examples

### II. Testing Standards & Coverage

**Non-negotiable Requirements**:
- Minimum 80% code coverage for all new features
- Critical paths (authentication, payment, data persistence) MUST have 100% coverage
- Tests MUST be written BEFORE implementation (TDD approach preferred)
- All tests MUST pass before merging to main branch
- Integration tests MUST cover all service boundaries and external dependencies
- Performance regression tests MUST exist for critical paths

**Rationale**: Comprehensive testing catches bugs early, enables confident refactoring, and serves as living documentation. Tests are the safety net that allows rapid development without fear of breaking existing functionality.

**Test Hierarchy** (in order of importance):
1. **Contract Tests**: Verify API contracts and service boundaries
2. **Integration Tests**: Verify end-to-end user journeys
3. **Unit Tests**: Verify individual component behavior
4. **Performance Tests**: Verify response times and resource usage

**Test Requirements**:
- Each user story MUST have at least one integration test
- Each public function/method MUST have at least one unit test
- Each external API call MUST have a contract test
- Flaky tests MUST be fixed or removed within 24 hours

### III. User Experience Consistency

**Non-negotiable Requirements**:
- All UI components MUST follow the established design system
- User interactions MUST provide immediate feedback (within 100ms)
- Error messages MUST be user-friendly, actionable, and consistent
- Loading states MUST be shown for operations taking >300ms
- All features MUST support keyboard navigation and screen readers (WCAG 2.1 AA compliance)
- User preferences and state MUST persist across sessions

**Rationale**: Consistent UX builds user trust, reduces support costs, and increases product adoption. Users should never have to relearn patterns or guess what will happen next.

**UX Standards**:
- Visual hierarchy: Clear primary, secondary, and tertiary actions
- Response time: Actions MUST complete or show progress within 1 second
- Error handling: Users MUST always know what went wrong and how to fix it
- Navigation: Users MUST be able to reach any feature within 3 clicks
- Accessibility: All interactive elements MUST have proper ARIA labels and focus states

**Prohibited Patterns**:
- Generic error messages ("Something went wrong")
- Blocking operations without progress indicators
- Inconsistent button styles or placements
- Unannounced state changes
- Non-responsive UI elements

### IV. Performance Requirements & Optimization

**Non-negotiable Requirements**:
- Page load time MUST be under 2 seconds (p95) on 3G connection
- API response time MUST be under 200ms (p95) for read operations
- API response time MUST be under 500ms (p95) for write operations
- Database queries MUST be indexed for all frequent access patterns
- Frontend bundle size MUST be under 200KB (gzipped) for initial load
- Memory leaks MUST be identified and fixed before production deployment

**Rationale**: Performance directly impacts user satisfaction, conversion rates, and operational costs. Slow systems lead to user abandonment and increased infrastructure expenses.

**Performance Standards**:
- API endpoints: Monitor and alert on p95 latency > 200ms
- Database queries: No full table scans in production
- Frontend: Implement code splitting and lazy loading for routes
- Caching: Implement at all layers (CDN, application, database)
- Resource usage: CPU < 70%, Memory < 80% under normal load

**Monitoring Requirements**:
- Real-user monitoring (RUM) for frontend performance
- APM (Application Performance Monitoring) for backend services
- Database query performance tracking
- Regular performance testing in CI/CD pipeline
- Performance budgets enforced in build process

### V. Documentation & Localization Standards

**Non-negotiable Requirements**:
- All feature specifications MUST be written in Traditional Chinese (zh-TW)
- All implementation plans MUST be written in Traditional Chinese (zh-TW)
- All user-facing documentation MUST be written in Traditional Chinese (zh-TW)
- All UI text, labels, and messages MUST be in Traditional Chinese (zh-TW)
- Error messages MUST be in Traditional Chinese with clear, actionable guidance
- User stories and acceptance criteria MUST be in Traditional Chinese

**Rationale**: Consistent use of Traditional Chinese ensures that all stakeholders can fully understand requirements, specifications, and user-facing content. This reduces miscommunication, improves collaboration with Chinese-speaking teams, and delivers better user experience for the target audience.

**Language Scope**:
- **Traditional Chinese Required**:
  - Feature specifications (`/specs/*.md`)
  - Implementation plans (`/specs/*/plan.md`)
  - User stories and scenarios
  - API documentation for user-facing endpoints
  - User guides and quickstart documentation
  - UI components and user-facing text
  - Error messages and notifications
  - Commit messages (preferred, but English acceptable)
  
- **English Permitted** (for international collaboration):
  - Code comments (English preferred for broader accessibility)
  - Internal technical documentation
  - API implementation details
  - Third-party integration documentation
  - Variable/function names (English required per coding standards)
  - Git branch names and technical identifiers

**Quality Standards**:
- Use proper Traditional Chinese terminology (避免簡體中文或大陸用語)
- Consistent terminology across all documentation (建立詞彙表)
- Professional and clear language (避免口語化或模糊表達)
- All dates MUST use ISO format (YYYY-MM-DD) or "YYYY年MM月DD日" format
- Numbers and units follow Taiwan localization standards

**Validation**:
- All specifications MUST be reviewed by Traditional Chinese native speaker
- Automated checks for language compliance in CI/CD
- Translation glossary MUST be maintained for consistent terminology

## Quality Standards

### Code Review Process

**Mandatory Checks**:
1. All automated tests pass (100% required)
2. Code coverage meets minimum threshold (80%)
3. Linting and static analysis pass (zero warnings)
4. Performance tests pass (no regressions)
5. Security scan passes (no high/critical vulnerabilities)
6. At least one peer review approval

**Review Criteria**:
- Does code follow established patterns and conventions?
- Are edge cases handled appropriately?
- Is error handling comprehensive and user-friendly?
- Are performance implications acceptable?
- Is the code testable and maintainable?
- Does the PR include necessary documentation updates?

### Security Requirements

**Non-negotiable**:
- All user inputs MUST be validated and sanitized
- Authentication tokens MUST be securely stored and transmitted (HTTPS only)
- Sensitive data MUST be encrypted at rest and in transit
- Security vulnerabilities MUST be patched within 48 hours of discovery
- Dependency vulnerabilities MUST be reviewed weekly
- Access control MUST follow principle of least privilege

## Development Workflow

### Feature Development Lifecycle

1. **Specification**: Feature requirements documented in `/specs` with user stories
2. **Design**: Technical design completed with contracts and data models
3. **Implementation**: TDD approach with continuous integration
4. **Testing**: All test types executed and passing
5. **Review**: Peer review with constitution compliance check
6. **Deployment**: Staged rollout with monitoring
7. **Validation**: User acceptance and performance validation

### Definition of Done

A feature is considered complete when:
- [ ] All user stories implemented and testable
- [ ] Code coverage ≥ 80% (100% for critical paths)
- [ ] All tests passing (unit, integration, contract, performance)
- [ ] Code reviewed and approved by at least one peer
- [ ] Documentation updated (API docs, user guides) in Traditional Chinese
- [ ] All specifications and plans written in Traditional Chinese
- [ ] All UI text and error messages in Traditional Chinese
- [ ] Performance requirements met
- [ ] Security scan passed
- [ ] Accessibility requirements met (WCAG 2.1 AA)
- [ ] Deployed to staging and validated
- [ ] Monitoring and alerts configured

### Complexity Management

**Before adding complexity, MUST answer**:
1. What simpler alternative was considered?
2. Why is the simpler alternative insufficient?
3. What is the maintenance cost of this complexity?
4. How will this be tested and monitored?

**Complexity that requires justification**:
- New external dependencies
- New frameworks or libraries
- Architectural pattern changes
- Performance optimizations that sacrifice readability

## Governance

### Constitution Authority

This constitution supersedes all other development practices and guidelines. When conflicts arise between this constitution and other documentation, this constitution takes precedence.

### Amendment Process

**To amend this constitution**:
1. Propose change with rationale and impact analysis
2. Discuss with team and stakeholders
3. Document migration plan if needed
4. Update version according to semantic versioning:
   - **MAJOR**: Breaking changes to principles or removal of sections
   - **MINOR**: New principles or sections added
   - **PATCH**: Clarifications or minor refinements
5. Update all dependent templates and documentation
6. Commit with detailed changelog

### Compliance Verification

**Enforcement**:
- All pull requests MUST include constitution compliance checklist
- Automated CI/CD checks enforce measurable requirements
- Monthly constitution review meetings to assess adherence
- Violations MUST be documented and remediated within one sprint

**Exceptions**:
- Exception requests MUST be documented with justification
- Exceptions MUST be time-bound (not permanent)
- Exception MUST include remediation plan

### Living Document

This constitution is a living document that evolves with the project. Feedback, improvement suggestions, and amendment proposals are encouraged and should be submitted through the formal amendment process.

**Version**: 1.1.0 | **Ratified**: 2025-11-19 | **Last Amended**: 2025-11-19
