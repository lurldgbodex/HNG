# TickApp - Ticket management web app

It's a full-featured, responsive ticket managment application built using React(TypeScript + vite), vue (TypeScript + vite) and Twig (Symfony). Each version shars the same visual design, authentication flow and crud based ticket management interface

# Project Overview

TicketFlow allows users to:

- Register / Login (simulated via localStorage)
- Access a secure dashboard with summary stats
- Create, edit, delete, and view tickets
- Manage statuses (open, in_progress, closed)
- Receive instant feedback with inline validation and toast notifications
- Each version demonstrates best practices for frontend architecture, state management, validation, and accessibility.

## Frameworks & Libraries

### React Version

- Build tool: vite
- language: Typescript
- Styling: Tailwind CSS
- Routing: React Router DOM
- Notifications: Custom Toast system
- Validation: Local utitlity validators
- Storage: Localstorage via utility functions

### Vue Version

- Build tool: vite
- language: Typescript
- Styling: Tailwind CSS
- Routing: vue Router
- Notifications: Custom Toast system
- Validation: Local utitlity validators
- Storage: Localstorage via utility functions

### Twig Version

- Framework: Symfony 6
- Templating: Twig
- Styling: Tailwind CSS
- Routing: Symfony Routing
- Session/Auth: LocalStorage

## SetUp & Execution

### React Version

```bash
cd ticket-app-react
npm install
npm run dev
```

Then visit `http://localhost:5173`

### Vue version

```bash
cd ticketapp-vue
npm install
npm run dev
```

Then visit `http://localhost:5173`

### Twig version

```bash
cd ticketapp-twig
composer install]
npm install
npm run dev
symfony serve
```

Then visit `http://localhost:8000`

## Switching Between Framework Versions

Each framework version is independent. To switch:

1. Navigate into the desired folder:
   - ticketapp-react-vite-ts
   - ticketapp-vue-vite-ts
   - ticketapp-twig
2. Install dependencies (npm install or composer install for Twig).
3. Run the local development server.
   You can keep all three running on different ports simultaneously if desired.

## State & Data structure

common ticket model

```ts
interface Ticket {
    id: string;
    title: string;
    description? string;
    status: 'open' | 'in_progress' | 'closed';
    priority?: string;
    createdAt: string;
    updatedAt: string;
}
```

Auth Session (stored in localStorage)

```json
{
  "token": "mock_session_token",
  "username": "user1",
  "createdAt": "string"
}
```

- key: ticketapp_session
- cleared on logout or session expiry

## Accessibility Notes

- Semantic HTML structure (<header>, <main>, <footer>).
- All buttons and links are keyboard-accessible with visible focus rings.
- Text and background colors have sufficient contrast.
- Form fields include aria-label or for attributes.
- Responsive layout with mobile-first approach.
- SVG wave and animations are decorative (marked with aria-hidden="true").

## Known Issues

- LocalStorage Sync: Session may persist between versions if key name overlaps. Clear manually if switching frameworks.
  -Toast Transitions: Minor delay in animation due to asynchronous updates in React/Vue versions.
