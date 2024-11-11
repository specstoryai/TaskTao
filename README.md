# TaskTao

TaskTao is a single-user web application for managing tasks across multiple areas of responsibility. It provides three focused modes: Capture, Planning, and Action.

## Features

- **Areas**: Organize tasks by areas of responsibility
- **Task Types**: Tasks are either Important or Urgent
- **Routines**: Manage recurring tasks with various frequencies
- **Three Modes**:
  - Capture: Quick task entry
  - Planning: Organize areas and tasks
  - Action: Focus on today's tasks

## Technology Stack

- Backend: Ruby/Sinatra
- Database: PostgreSQL with Sequel ORM
- Frontend: Server-side rendered with HTMX
- Styling: Tailwind CSS with DaisyUI
- Deployment: Render.com

## Local Development Setup

1. **Prerequisites**:
   - Ruby 3.3.x
   - PostgreSQL
   - Git

2. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/tasktao.git
   cd tasktao
   ```

3. **Install dependencies**:
   ```bash
   bundle install
   ```

4. **Set up environment variables**:
   ```bash
   cp .env.example .env
   # Edit .env with your credentials
   ```

5. **Set up the database**:
   ```bash
   # Create the database
   createdb tasktao_development
   
   # Run migrations
   rake db:migrate
   ```

6. **Start the server**:
   ```bash
   bundle exec puma
   ```

7. **Access the application**:
   - Open http://localhost:9292
   - Use the credentials set in your .env file

## Database Schema

### Areas
- `id`: Primary key
- `title`: String (required)
- `description`: String
- `color`: String (required)
- `active`: Boolean
- `position`: Integer
- `created_at`, `updated_at`: DateTime

### Tasks
- `id`: Primary key
- `area_id`: Foreign key to areas
- `title`: String (required)
- `description`: String
- `type`: String ('important' or 'urgent')
- `for_today`: Boolean
- `completed`: Boolean
- `completed_at`: DateTime
- `position`: Integer
- `created_at`, `updated_at`: DateTime

### Routines
- `id`: Primary key
- `title`: String (required)
- `description`: String
- `frequency`: String ('daily', 'weekly', 'monthly', 'quarterly', 'yearly')
- `day_of_week`: Integer (0-6 for weekly)
- `day_of_month`: Integer (1-31 for monthly)
- `month`: Integer (1-12 for yearly)
- `active`: Boolean
- `completed`: Boolean
- `completed_at`: DateTime
- `created_at`, `updated_at`: DateTime

### Task Checklist Items
- `id`: Primary key
- `task_id`: Foreign key to tasks
- `content`: String (required)
- `completed`: Boolean
- `position`: Integer
- `created_at`, `updated_at`: DateTime

## Directory Structure

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
```

## Deployment

TaskTao is designed to be deployed on Render.com:

1. Create a new Web Service on Render
2. Connect your repository
3. Set environment variables:
   - `USERNAME`: Admin username
   - `PASSWORD`: Admin password
   - `DATABASE_URL`: Provided by Render PostgreSQL instance
4. Deploy

## Authentication

TaskTao uses HTTP Basic Authentication:
- Credentials are set via environment variables
- All routes are protected
- No session management required
- Secured via HTTPS in production

## Development Patterns

### Models
- Inherit from Sequel::Model
- Use validation_helpers plugin
- Define relationships using Sequel's DSL
- Implement validate method for custom validations

### Routes
- Organized by resource
- Return HTML fragments for HTMX requests
- Use layout: false for HTMX responses
- Follow REST conventions

### Views
- Use .erb extension
- Partials prefixed with underscore
- DaisyUI classes for components
- Tailwind utilities for custom styling
- HTMX attributes for dynamic behavior

## License

MIT License. See LICENSE file for details.

## Testing

TaskTao has a comprehensive test suite focused on business logic and domain-specific functionality. The tests avoid redundantly testing framework features that are already well-tested by Sequel, Sinatra, and Ruby.

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/task_spec.rb

# Run specific test by line number
bundle exec rspec spec/models/task_spec.rb:42

# Run with detailed output
bundle exec rspec --format documentation
```

### Test Organization

- `spec/models/` - Unit tests for model business logic
- `spec/features/` - Integration tests for user workflows
- `spec/factories/` - Test data factories
- `spec/spec_helper.rb` - Test configuration

### Writing Tests

When writing new tests:
1. Focus on business rules and domain logic
2. Avoid testing framework features
3. Use factories for test data
4. Keep tests focused and descriptive

### Test Coverage

To check test coverage:
```bash
COVERAGE=true bundle exec rspec
```
Coverage report will be generated in `coverage/index.html` 

## Keyboard Shortcuts

### Global Shortcuts
- `Command+/` (Mac) or `Ctrl+/` (Windows/Linux): Open Capture mode from anywhere

### Capture Mode
- `↑/↓`: Change area
- `←/→`: Change task type (Important/Urgent)
- `Enter`: Save task
- `Esc`: Cancel and return to previous mode