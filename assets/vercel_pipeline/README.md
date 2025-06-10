# Vercel Advanced Pipeline

This pipeline processes logs from Vercel deployments and applications, applying various transformations and enrichments to make the data more useful for monitoring and analysis.

## Overview

The pipeline filters logs with the source "vercel" and applies several processors to transform and enrich the log data.

## Processors

### 1. Project Name Mapping
- Maps the `@projectName` attribute to a `project_name` tag
- Preserves the original source attribute

### 2. Environment Mapping
- Maps the `@environment` attribute to both `environment` and `env` tags
- Preserves the original source attribute

### 3. Team Assignment
- Uses a lookup table to map project names to teams
- The lookup table is configurable through the `vlookup_project_name_to_team` variable

### 4. UTM Source Extraction
- Extracts UTM source parameters from URL paths using Grok parsing
- Matches patterns like:
  - `/test?utm_source=test`
  - `/test?utm_source=test&utm_campaign=test`
  - And similar variations with additional UTM parameters

### 5. Team Tag Mapping
- Maps the `@team` attribute to a `team` tag
- Preserves the original source attribute

### 6. Admin Status Lookup
- Determines admin status based on client IP addresses
- Uses a configurable lookup table (`vlookup_is_admin`)
- Defaults to "false" if no match is found

## Configuration Variables

- `name_suffix`: Optional suffix for the pipeline name
- `tags`: Custom tags to apply to the pipeline
- `vlookup_project_name_to_team`: Lookup table for mapping project names to teams
- `vlookup_is_admin`: Lookup table for determining admin status based on IP addresses

## Usage

The pipeline is automatically enabled and processes all logs with the source "vercel". The processors are applied in sequence to transform and enrich the log data with additional context and metadata.
