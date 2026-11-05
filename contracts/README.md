# Data Contract — customer360_kafka_to_postgresql

Machine-readable contract in `data_contract.json`. This document is the
human-review companion for governance / PR review.

## Quality rule enforcement

Which generated runtime enforces each rule. A rule enforced in fewer
runtimes than others is flagged so it is never silently dropped.

| Column | Rule | Severity | Enforced in | Coverage |
|---|---|---|---|---|
| `customer_id` | not_null | error | dbt, spark, airflow | ok |
| `revenue_month` | not_null | error | dbt, spark, airflow | ok |
| `currency` | not_null | error | dbt, spark, airflow | ok |
| `customer_id` | unique | error | dbt, spark, airflow | ok |
| `currency` | regex | error | dbt, spark, airflow | ok |
| `monthly_revenue` | not_null | error | dbt, spark, airflow | ok |
| `monthly_revenue` | min | error | dbt, spark, airflow | ok |
| `purchase_count` | min | error | dbt, spark, airflow | ok |
| `customer_id` | row_count | error | dbt, spark, airflow | ok |
| `last_event_timestamp` | freshness | warn | airflow | ⚠ partial |
| `country_code` | not_null | warn | dbt, spark, airflow | ok |

**Coverage:** 10 full · 1 partial · 0 unenforced (of 11 rules).

## PII masking policy

| Column | Strategy | Enforced at |
|---|---|---|
| `email` | sha256 | dbt staging (hash before any analytics surface) |
| `phone` | sha256 | dbt staging (hash before any analytics surface) |
