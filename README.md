# Cinema × Crime (India): Impact Analysis

This project aims to build a **data-backed, transparent exploration** of whether **commercially dominant Indian films** (and the kinds of protagonists/crime depictions they popularize) **correlate** with **short-term changes in recorded crime patterns** after release.

It is framed as a cultural + econometrics study inspired by the broader thesis that mainstream cinema can shape norms—but the project is explicitly careful about claims: **correlation ≠ causation**.

## What we’re trying to answer

For a set of high-reach films (e.g., top ~50 per year), we want to ask questions like:

- Do films that **glorify violence** or present **law-breaking protagonists** correlate with **changes in specific crime categories** (property crime, assault, etc.) in the **weeks after release**?
- Are correlations stronger in places where a film was more of a **blockbuster** (where data supports it)?
- How do results change under different assumptions (2 vs 4 vs 6 week windows, different baselines, different controls)?

The project’s output is intended to be an **interactive website/dashboard** (not just a static report) that lets people explore findings, read methodology, and understand limitations.

## Core principles and caveats

- **No simplistic “movies cause crime” narrative**: the goal is to measure *associations* and report effect sizes + uncertainty.
- **Confounds are real**: festivals, elections, weather, unemployment, policing intensity, and seasonality can move crime rates.
- **Reporting bias**: higher FIR counts can reflect improved reporting, not necessarily more crime.
- **Temporal resolution is the hard part**: NCRB is often annual; meaningful “4-week windows” require monthly/weekly city/state sources where available.
- **Transparency over hype**: publish assumptions, sensitivity analyses, and multiple-hypothesis corrections.

## Data sources (planned)

### Film data (metadata + performance)
- **TMDb**: titles, release dates, cast/crew, genres, synopses.
- **IMDb datasets**: additional metadata and cross-referencing via IMDb IDs.
- **Box office sources** (may require scraping): domestic weekly collections and other performance proxies.

### Film content annotations (structured “what the film depicts”)
Most of the important variables (e.g., “violence glorified?”, “crime rewarded?”, protagonist archetype) are not available as clean datasets.

Planned approach:
- Use **LLM-assisted structured extraction** from plot summaries + reviews using **DSPy**.
- Create a **manually annotated gold set** for validation and to calibrate the extraction pipeline.
- Store annotations with **confidence scores** and provenance.

### Crime data
- **NCRB / data.gov.in**: official crime categories and counts (often annual).
- Where possible, incorporate **higher-frequency sources** (metro/city monthly reporting, state portals, etc.) to support short windows.

## Methodology (planned)

The analysis will emphasize methods that are common in policy/econometrics rather than “black-box” correlations:

- **Interrupted Time Series (ITS)** to test for level/slope changes around release dates.
- **Difference-in-Differences (DiD)** when a plausible treatment/control split exists (e.g., differential film reach by geography).
- **Panel regressions** with **state/time fixed effects** and explicit controls where data allows.
- **Multiple testing correction** (e.g., FDR) because we’ll test many film × crime × region combinations.
- Report **effect sizes and confidence intervals**, not only p-values.

## Tech stack (planned)

- **Python**: ingestion, cleaning, feature generation, analysis.
- **PostgreSQL** (plus **pgvector**): relational data + embeddings in one place.
- **Next.js + Prisma**: website and API layer.
- **D3 / react-simple-maps**: India map + choropleths and interactive visuals.
- **Tailwind + shadcn/ui**: UI components and styling.
- **DSPy (+ LLM provider)**: structured film-content annotation and “ask the data” exploration (RAG).

## Intended product experience

- **Explore India map**: select year/crime type/film attribute; see choropleths and deltas.
- **Film explorer**: filter films by archetypes (e.g., “crime rewarded”, “anti-authority theme”).
- **Film deep-dive pages**: annotations, data provenance, and post-release crime window analysis.
- **Correlation dashboard**: compare attributes vs crime categories with clear uncertainty visualization.
- Optional: **RAG chatbot** that answers questions grounded in the dataset (“Ask the data”).

## Roadmap (high level)

- **Phase 1 — Data foundation**: gather film lists + crime datasets; normalize geography/time; load to Postgres.
- **Phase 2 — Annotation pipeline**: define schema; build DSPy extraction; validate against gold set.
- **Phase 3 — Statistical analysis**: baselines, windows, models, corrections, sensitivity checks.
- **Phase 4 — Website build**: interactive exploration + methodology pages.
- **Phase 5 — Polish & publish**: performance, SEO, writing up limitations, reproducibility.

## Repo status

This repository is currently in the **planning stage**. The detailed working plan lives in `cinema-crime-india-action-plan.md` (ignored by default via `.gitignore`).

As implementation starts, expect folders like:
- `data/` (raw/processed pointers, not necessarily committed)
- `scripts/` or `pipeline/` (ingestion + cleaning)
- `analysis/` (notebooks, models, results tables)
- `web/` (Next.js app)

## Ethics & communication

Because this topic is easy to sensationalize, the project will prioritize:
- Clear language about what the study can and cannot claim
- Open methodology and reproducible analysis where feasible
- Care around demographic inferences (religion/caste/class fields require strong justification and careful framing)

