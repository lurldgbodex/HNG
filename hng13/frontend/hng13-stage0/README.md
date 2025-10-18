# Profile Card Component

A responsive, accesssible profile card implementation

## Live Demo

[View Live Demo](https://folio-profile.netlify.app/)

## Features

- data-testid attributes to allow easy testing
- uses Semantic HTML structure
- Response design
- accessible keyboard navigation
- real-time updating timestamp
- social links with proper security attributes
- modern css with flexbox layout
- hover and focus states for interactive elements

## Core Elements

- Profile card root container (data-testid="test-profile-card")
- Name (data-testid="test-user-name")
- Short biography (data-testid="test-user-bio")
- Current time in milliseconds (data-testid="test-user-time")
- Avatar image (data-testid="test-user-avatar")
- Social links list (data-testid="test-user-social-links")
- Individual social links (data-testid="test-user-social-<network>")
- Hobbies list (data-testid="test-user-hobbies")
- Dislikes list (data-testid="test-user-dislikes")

## HTML & Semantics

- Uses <article> for main card container
- Proper heading structure with `<h2>` for name
- `<figure>` and `<figcaption>` for avatar
- `<nav>` for social links navigation
- `<section>` for content grouping
- `<ul>` for list items

## Responsive Design

- Mobile-first approach
- Vertical stacking on small screens
- Sidebar layout on wider screens (768px+)
- Flexible content that adapts to different content lengths Behavior
- Real-time timestamp updates every second
- Social links open in new tab with rel="noopener noreferrer"
- Keyboard focusable elements with visible focus states
- Accessible form controls and navigation

## Quick Start

1. Download the index.html file
2. Open it directly in any modern web browser
3. No build process or dependencies required

## Testing

### Automated Testing

The component is ready for automated testing with the following selectors:

```javascript
// Example test selectors
const profileCard = document.querySelector('[data-testid="test-profile-card"]');
const userName = document.querySelector('[data-testid="test-user-name"]');
const userBio = document.querySelector('[data-testid="test-user-bio"]');
const userTime = document.querySelector('[data-testid="test-user-time"]');
const userAvatar = document.querySelector('[data-testid="test-user-avatar"]');
const socialLinks = document.querySelector(
  '[data-testid="test-user-social-links"]'
);
const hobbies = document.querySelector('[data-testid="test-user-hobbies"]');
const dislikes = document.querySelector('[data-testid="test-user-dislikes"]');
```
