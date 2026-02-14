# Architecture Specification Document (ASD)

**Feature:** [Name]
**Date:** [YYYY-MM-DD]
**Status:** DRAFT / APPROVED

## 1. System Design

- **Pattern:** (e.g., Event-Driven, CRUD, State Machine)
- **Components:** (List modified/new services)
- **Data Flow:** (Step-by-step data journey)

## 2. Data Schema

```sql
-- Proposed Schema Changes
TABLE users ADD COLUMN ...

```

## 3. API Interface

`POST /api/v1/resource`

- **Auth:** Bearer Token
- **Payload:** `{ ... }`
- **Response:** `201 Created`

## 4. Security & Compliance

- [ ] GDPR Impact?
- [ ] AuthZ Level Required:
- [ ] Input Validation Rules:
