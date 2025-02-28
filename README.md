# Chambers For Sport Academy - UK

## Overview
MyRailsApp is a Dockerized Ruby on Rails application designed for athlete onboarding, KPI tracking, coaching schedules, and event management. It includes a scoring service, form handling, and supports multiple websites. The app leverages Stripe for payments and SendGrid for email notifications.

## Features
- **Athlete Management**: Onboarding and KPI tracking for athletes.
- **Coaching & Scheduling**: Recurring calendar management for coaches.
- **Event Management**: Yearly events, sessions, and packages.
- **Forms Handling**: Supports multiple websites.
- **QR Code Generator**: Generates QR codes for easy access.
- **CSV Uploader**: Bulk data upload for quick processing.
- **Scoring Service**: Athlete performance assessment with detailed scoring.
- **API Serialization**: Uses serializers for structured API responses.
- **Testing & Code Quality**:
  - RSpec for testing.
  - Rubocop and Husky for code linting and pre-commit hooks.
- **Storage & Background Jobs**:
  - Active Storage for handling media.
  - R2 Cloudflare Bucket for media storage.
  - JWT/Devise gem for authentication.
  - Sidekiq for job processing.
- **UI & Styling**: Built with Tailwind CSS for modern design.

## Setup Instructions
### Prerequisites
- Docker & Docker Compose
- Ruby on Rails
- PostgreSQL
- Redis for Sidekiq

## Screenshots
### Dashboard
![Dashboard](./dashboard-image.png)

### Scoring Screen
![Scoring](./scoring-screen.png)

### Schedules Screen
![Schedules](./schedules-screen.png)

