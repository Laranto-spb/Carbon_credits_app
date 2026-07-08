# Carbon Credits Registry — Rails MVP

## What Are Carbon Credits?

A carbon credit is a verified unit representing the reduction of greenhouse gas emissions—typically 1 ton of CO₂ equivalent. Projects such as wind farms or reforestation initiatives register emission reductions, generate credits, and can sell them to companies aiming to offset their carbon footprint. A key rule: a credit can be retired (used to offset emissions) only once.

## About the Project

This is a data aggregator for carbon credits, implemented as an MVP registry in Rails. It pulls, normalizes, and consolidates information from external sources (via Apify) into a unified view, enabling tracking of project metadata, credit issuance, trades, and retirements.

The project demonstrates typical backend development tasks: handling messy real‑world data, caching, API integration, pagination, aggregations, and reporting.

> 🌱 **Note**: The project is currently under development. Upcoming plans include adding advanced analytics, report generation, new data visualizations, as well as tools for data synchronization and statistics export.

## Tech Stack

- **Framework**: Ruby on Rails
- **Database**: SQLite (for simplicity and portability)
- **Containerization**: Docker & docker-compose
- **External Data**: Apify API for data aggregation
- **Caching**: Rails cache with Redis (keys generated via a dedicated builder)
- **Data Normalization**: Custom service layer to handle inconsistent input
- **Testing**: RSpec
- **Frontend**: Plain CSS + ERB views with basic charts/tables for metrics

## Data Sources

- **Apify datasets**: Simulated market data and project registries via Apify API.
- **Real‑world references**: Seed data is based on actual project types, regions, and typical credit volumes (not live market prices).
- **Synthetic records**: Additional trades, retirements, and verification entries generated via seeds for demo purposes.

## Demo Data & Seeds

Seed scripts populate the database with realistic scenarios for demonstration:

- Carbon projects with baseline emissions and verification records.
- Credit batches and individual credits with statuses (`issued`, `traded`, `retired`).
- Sample trades and retirement events to showcase business rules (e.g., preventing double retirement).
- “Raw” records to demonstrate data normalization workflows.

All seed data is inspired by real project patterns but is not tied to any live registry or financial market.

## How to Run Locally

Use the provided `start.sh` script to start:

```bash
./start.sh
```

To stop containers:

```bash
./stop.sh
```
