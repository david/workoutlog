# Project Conventions

This document outlines the coding conventions and best practices followed in this Ruby on Rails project. LLMs must adhere to these conventions to ensure consistency, readability, and maintainability of the codebase.

## General Guidelines

- Make focused changes to the codebase. Do not include unrelated changes when changing code. For example, if you notice that an association is missing `dependent: :destroy`, ignore it if that is not your focus at the time.
- Prefer readability over cleverness. The code should always be obviously correct.
- Use clear names (variables, methods, classes, etc.) and omit all comments.
- Avoid duplication. If you find yourself writing the same code multiple times, refactor it into a reusable method or class.

## Models

- Keep models focused on business logic and data persistence.
- Use scopes for common queries.
- Validate data presence, format, and uniqueness appropriately.

## Controllers

- Keep controllers thin. Delegate complex logic to models.
- Use strong parameters (`require` and `permit`) to protect against mass assignment vulnerabilities.
- Use standard RESTful actions (`index`, `show`, `new`, `create`, `edit`, `update`, `destroy`) where applicable.

## Views

- Keep views simple and focused on presentation. Avoid complex logic.
- Use partials to keep views DRY (Don't Repeat Yourself).
- Use helpers for view-specific logic.
- Leverage Rails' built-in view helpers (e.g., `form_with`, `link_to`).

## Routing

- Use resourceful routing (`resources`) whenever possible.
- Define custom routes clearly.
- When using routing functions, make sure they exist in the `config/routes.rb` file.

## Migrations

- Migrations should be reversible. Use `change` where possible; otherwise, define `up` and `down` methods.
- Never use model classes directly in migrations, as the model definition might change over time.
- Keep migrations small and focused on a single schema change.
- Never change past migrations. If you need to make a change, to the database schema, create a new migration.

## Testing

- Use Rails' built-in testing framework (Minitest)
- Follow the Arrange-Act-Assert (AAA) pattern in tests.
- Keep tests fast and independent.

## Internationalization (I18n)

- Use I18n for all user-facing strings.
- Store translations in `config/locales/*.yml`.
- Use descriptive keys for translations.
- Prefer local keys (i.e., keys that start with a dot, as in ".name") over global keys, except when keys are shared across views.

## Security

- Be aware of common web vulnerabilities (e.g., XSS, CSRF, SQL Injection).
- Use Rails' built-in security features (e.g., CSRF protection, strong parameters).
- Sanitize user input where necessary.
- Keep gems updated, especially security-related ones.
