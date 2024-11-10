
# Overview

TaskTao is an app for managing tasks. 

TaskTao is for people that work on multiple things. They have multiple areas of responsibility and focus. They work on many projects.

It has a simple section for managing recurring tasks, called routines.

It has a simple mode for capturing new tasks.

It has a planning mode for maintaining areas and tasks, and for planning the tasks of the day.

It has an action mode for taking action on the tasks of the day.

## Product

### Areas

Areas are an important concept in TaskTao. Areas can correspond to areas of responsibility, or focus. They can be projects, or roles, or teams, or anything else. They are the containers for categories of tasks. 

Tasks within an area are separated into "Important" and "Urgent" tasks.

- Areas have a title, and an optional description.
- Areas can be active or inactive.
- Areas have important tasks and urgent tasks. 
- Areas have a color.
- Areas can be created, updated, and deleted.
- Areas can be reordered.
- Areas can have their title and description edited.
- Areas can have their color edited.

### Tasks

Tasks are the basic unit of work in the app. 

Importantly, tasks are associated with a particular area. There are no tasks that are not associated with an area.

Importantly, tasks are either "Important", "Urgent" or "Routines". There is no other option.

- Tasks have an order within their area.
- Tasks have a title, as well as an optional description, and an optional check list.
- Tasks have a completion status, and a completion timestamp.
- Tasks have a today toggle.
- Tasks have a creation and last updated timestamp.
- Tasks take the color of the area they are associated with.
- Tasks can be created, updated, and deleted.
- Tasks can be reordered within their area.
- Tasks can be completed.
- Tasks can be toggled as for today.

### Routines

Routines are tasks that also have a frequency.

Routines are tasks that repeat on a regular basis. Some are daily habits. Some are just tasks that recur on a regular basis. These can be weekly, monthly, quarterly, or yearly. They can be on specific days of the month, or a certain weekday.

- A routine marked as a daily habit resets its completion timestamp each day.
- A routine marked as as recurring resets its completion timestamp the next time the frequency occurs.
- A routine can be active or inactive.
- Inactive routines do not reset their completion timestamp and are not shown in the action mode.

### Nos

TaskTao is not:

- It's not for teams.
- It's not focused on due dates. 
- It doesn't track time.
- It doesn't track task progress.

### User Interface

### Modes

TaskTao has 3 modes:

- Capture
- Planning
- Action

#### Capture

Capture mode is a focused mode for quickly capturing tasks. It allows for a very quick entry of a task with only keyboard input.

Only active areas are shown in the capture mode.

Capture mode can be entered at any time by pressing the "Capture" button in the header or by pressing Command + \ on the keyboard.

The most recently used area is defaulted as the selected area.

The title field is focused and ready for input.

Pressing the up and down arrow keys changes the selected area.

Pressing the arrow left and right keys changes the task type between "Important", and "Urgent". Routines cannot be created in capture mode.

Pressing the return key in the title field creates a new task in the selected area, as long as the title is not empty.

Pressing the escape key cancels out of capture mode.

Future: Capture mode could also allow for voice input.

#### Planning

Planning mode is for maintaining areas and tasks, and for planning the tasks of the day.

The day is shown prominently at the top of the screen.

- It allows for area creation and deletion.
- It allows for area title and description editing.
- It allows for area reordering.
- It allows for area color editing.
- It allows for area activation and deactivation.
  
- It shows all tasks in all areas. 
- It allows for task reordering within an area.
- It allows for task creation.
- It allows for task title and description editing.
- It allows for toggling tasks as for today.
- It allows for task check list editing.
- It allows for task completion.
- It allows for task deletion.  

During planning, the user can navigate to prior days using the "Previous Day" and "Next Day" buttons, as well as a calendar picker. When not looking at today, the user can navigate to today.

When looking at today, only tasks that are not completed, or are not completed on today are shown. Tasks that are completed today are shown as completed.

When not looking at today, only tasks created before the selected day, and not completed before the selected day are shown.

When not looking at today, tasks that are completed on the selected day are shown as completed.

When not looking at today, the rest of the user interface is readonly.

#### Action

Action mode is a focused mode for taking action on the tasks of the day. Only tasks that are planned for today are shown here. 

Today's date is shown prominently at the top of the screen.

In action mode:
- The user sees tasks in three columns: "Important", "Urgent", and "Routines".
- Only tasks that are planned for today, or are routines, are shown.
- Tasks are shown in the order of their area, then in the order of their task.
- Tasks are shown in the color of their area.
- There is a count of the number of completed and total tasks in each column.

In action mode, the user can:
- The user can take action on the tasks of the day.
- The user can complete tasks, in which case they remain in the view, and are shown as completed.
- The user can toggle tasks as not for today, in which case they are removed from the view.
- The user can edit the title, description and check list of a task.

## Technical

### Architecture

Single-User Web Application

Stack Components:

Backend Framework: 
- Ruby/Sinatra
- Server-side rendered application
- RESTful routing patterns
- ERB templating engine
- Sequel ORM with PostgreSQL
- Deployment on Render.com

Database Layer:
- Render.com managed PostgreSQL
- Sequel ORM for database interaction
- Sequel Migrations for schema management
- Model validations through Sequel::Model
- Database connection managed in config/database.rb

Frontend Architecture:
- Server-side rendered HTML via ERB
- Tailwind CSS for styling
- DaisyUI component library
- HTMX for dynamic interactions
- No custom JavaScript required
- No frontend build process needed

UI Interaction Pattern:
- Initial page load server-rendered
- Dynamic updates via HTMX attributes
- Server responds with partial HTML fragments
- DaisyUI components for styled elements
- Tailwind utility classes for custom styling

Infrastructure:
- Hosted on Render.com
- Production PostgreSQL ($7/month tier)
- Automatic HTTPS
- Git-based deployments

### Development Patterns

Models:
- Inherit from Sequel::Model
- Include validation_helpers plugin
- Define relationships using Sequel's DSL
- Implement validate method for custom validations

Routes:
- Organized by resource
- Return HTML fragments for HTMX requests
- Use layout: false for HTMX responses
- Follow REST conventions

Views:
- Use .erb extension
- Partials prefixed with underscore
- DaisyUI classes for components
- Tailwind utilities for custom styling
- HTMX attributes for dynamic behavior

Database:
- Migrations for schema changes
- Sequel.connect in database.rb
- Connection string from ENV variables
- Rake tasks for database operations

### Directory Structure

```
app/
  models/          # Sequel model classes
  routes/          # Sinatra route handlers
  views/           # ERB templates
    layout.erb
    partials/      # Partial templates for HTMX responses
config/
  database.rb      # Sequel configuration
  application.rb   # Sinatra configuration
db/
  migrations/      # Sequel migrations
public/
  css/            # Tailwind CSS
Gemfile           # Ruby dependencies
config.ru         # Rack configuration
Rakefile          # Database tasks
```

### Authentication

Authentication:

- HTTP Basic Authentication via Rack::Auth::Basic
- Credentials stored in environment variables (USERNAME, PASSWORD)
- Applied globally to all routes
- No database tables or session management required
- No custom login pages
- Browser handles credential storage and transmission
- Secured via HTTPS (provided by Render.com)

Environment Variables Required:

- USERNAME: Single user's username
- PASSWORD: Single user's password

This authentication should be configured in the application setup before any routes are defined.

### Testing

TaskTao has comprehensive unit tests, but is careful not to just test Sequel or Sinatra or Ruby themselves. We know those work.

### Documentation

Create and maintain the following thorough documentation:

- Local development documentation
- Deployment documentation
- Database schema documentation
- Database migration documentation
- Design documentation
- Developer documentation
- Directory structure documentation
- Code documentation
- Code comments