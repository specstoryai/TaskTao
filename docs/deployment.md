# Deploying TaskTao on Render.com

This guide walks through deploying TaskTao on Render.com.

## Prerequisites

1. A Render.com account
2. Your TaskTao repository on GitHub
3. A credit card for Render.com services (required for PostgreSQL)

## Step 1: Create a PostgreSQL Database

1. In Render Dashboard, go to "New +" > "PostgreSQL"
2. Configure the database:
   - Name: `tasktao-postgres`
   - Database: `tasktao_production`
   - User: Leave as default
   - Region: Choose closest to your users
   - Plan: Start with $7/month tier
3. Click "Create Database"
4. Save the "Internal Database URL" - you'll need it later

## Step 2: Create a Web Service

1. Go to "New +" > "Web Service"
2. Connect your GitHub repository
3. Configure the service:
   - Name: `tasktao`
   - Environment: `Ruby`
   - Region: Same as database
   - Branch: `main`
   - Build Command: `bundle install`
   - Start Command: `bundle exec puma -C config/puma.rb`
   - Plan: Start with free tier

### Environment Variables

Add these environment variables in the web service settings:

```
DATABASE_URL=your_internal_database_url_from_step_1
USERNAME=your_chosen_admin_username
PASSWORD=your_chosen_admin_password
RACK_ENV=production
```

### Health Check Path

Set the health check path to `/`:
- Health Check Path: `/`
- Health Check Status: `302` (since root redirects to /action)

## Step 3: Add Build Files 