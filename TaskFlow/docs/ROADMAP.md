# TaskFlow — Learning Roadmap

**Mode:** guided. Claude explains and specifies; I write the code.
**Scope:** full team task tracker — auth, orgs/teams, projects, tasks, comments,
activity feed, roles/permissions, attachments, real-time updates.

## Lesson format
Each lesson ships four things:
1. **Guide** — the concept, and *why* Spring/Angular does it this way.
2. **Lab** — what I write, file by file, with signatures given but bodies mine.
3. **Checkpoint** — a command that proves it works (curl, test, or UI).
4. **Recall cards** — 3–5 Q/A to re-derive the concept cold later.

## Toolchain (verified 2026-09-22)
| Tool | Status |
|---|---|
| JDK 21.0.10 LTS | installed (also JDK 26 — we pin to 21) |
| Maven | not installed — use the `mvnw` wrapper from Initializr |
| Node 24.20.0 / npm 11.19.0 | installed |
| Angular CLI 21.2.21 | installed globally |
| PostgreSQL 18 | installed at `/Library/PostgreSQL/18` |
| Docker | **NOT installed** — blocks Testcontainers (see Lesson 11) |

## Phase 1 — Backend foundations
- **L0** Wipe + regenerate both projects from zero. Every dependency justified.
- **L1** Spring Boot anatomy: the request lifecycle, DI container, `application.yml`, profiles.
- **L2** Postgres + Flyway: versioned schema, first migration, why never `ddl-auto=update`.
- **L3** JPA entities & repositories: mapping, relationships, lazy loading, the N+1 trap.
- **L4** Web layer done right: DTOs vs entities, Bean Validation, global error handling.

## Phase 2 — Security
- **L5** Spring Security filter chain + JWT: register, login, password hashing.
- **L6** Teams & authorization: membership, roles, method security, data-scoped access.

## Phase 3 — Domain
- **L7** Projects & Tasks: service layer, transactions, pagination, filtering, sorting.
- **L8** Comments + activity feed via domain events.
- **L9** Attachments: multipart upload, storage abstraction, serving files safely.
- **L10** Real-time: WebSocket + STOMP, broadcasting task changes to a team.
- **L11** Testing: unit, `@WebMvcTest` slices, integration. (Needs a Docker runtime.)

## Phase 4 — Frontend
- **L12** Angular 21 anatomy: standalone components, signals, the modern bootstrap.
- **L13** Auth in the client: `HttpClient`, interceptors, route guards, token handling.
- **L14** The task board: component design, signal state, reactive forms.
- **L15** Live updates: STOMP client wired to signals.
- **L16** Build, package, and serve the SPA from Spring Boot.

## Open decisions
- **Lombok?** Recommendation: skip it. Java 21 `record`s cover DTOs, and writing
  real constructors/getters once teaches what Lombok hides. Revisit at L3.
- **Docker runtime?** Needed for Testcontainers at L11. Colima is the light option.
  Deferred — local Postgres is enough until then.
