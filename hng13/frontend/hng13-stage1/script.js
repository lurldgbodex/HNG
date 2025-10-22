// Navigation functionality
document.addEventListener("DOMContentLoaded", function () {
  const navLinks = document.querySelectorAll(".nav-link");
  const pages = document.querySelectorAll(".page");
  const menuToggle = document.querySelector(".menu-toggle");
  const navLinksContainer = document.querySelector(".nav-links");

  // Navigation click handler
  navLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();

      // Remove active class from all links and pages
      navLinks.forEach((l) => l.classList.remove("active"));
      pages.forEach((page) => page.classList.remove("active"));

      // Add active class to clicked link and corresponding page
      this.classList.add("active");
      const pageId = this.getAttribute("data-page") + "-page";
      document.getElementById(pageId).classList.add("active");

      // Close mobile menu if open
      if (navLinksContainer.classList.contains("active")) {
        navLinksContainer.classList.remove("active");
        menuToggle.setAttribute("aria-expanded", "false");
        menuToggle.textContent = "☰";
      }
    });
  });

  menuToggle.addEventListener("click", () => {
    navLinksContainer.classList.toggle("active");
  });

  // Close menu when clicking outside
  document.addEventListener("click", function (e) {
    if (
      navLinksContainer.classList.contains("active") &&
      !navLinksContainer.contains(e.target) &&
      !menuToggle.contains(e.target)
    ) {
      navLinksContainer.classList.remove("active");
      menuToggle.setAttribute("aria-expanded", "false");
      menuToggle.textContent = "☰";
    }
  });

  // Close menu on window resize if it becomes desktop view
  window.addEventListener("resize", function () {
    if (
      window.innerWidth > 768 &&
      navLinksContainer.classList.contains("active")
    ) {
      navLinksContainer.classList.remove("active");
      menuToggle.setAttribute("aria-expanded", "false");
      menuToggle.textContent = "☰";
    }
  });

  // Update the current time in milliseconds
  function updateTime() {
    const timeElement = document.querySelector(
      '[data-testid="test-user-time"]'
    );
    const lastUpdatedElement = document.getElementById("last-updated");

    if (timeElement) {
      timeElement.textContent = Date.now();
    }

    if (lastUpdatedElement) {
      const now = new Date();
      lastUpdatedElement.textContent = now.toLocaleString();
    }
  }

  // Update time immediately and then every second
  updateTime();
  setInterval(updateTime, 1000);

  // Contact form validation
  const contactForm = document.getElementById("contact-form");
  const successMessage = document.getElementById("success-message");

  if (contactForm) {
    contactForm.addEventListener("submit", function (e) {
      e.preventDefault();

      // Reset previous states
      const errorMessages = document.querySelectorAll(".error-message");
      errorMessages.forEach((msg) => {
        msg.classList.remove("show");
      });

      const inputs = document.querySelectorAll("input, textarea, select");
      inputs.forEach((input) => {
        input.setAttribute("aria-invalid", "false");
      });

      successMessage.classList.remove("show");

      // Validate form
      let isValid = true;

      // Name validation
      const nameInput = document.querySelector(
        '[data-testid="test-contact-name"]'
      );
      if (!nameInput.value.trim()) {
        document
          .querySelector('[data-testid="test-contact-error-name"]')
          .classList.add("show");
        nameInput.setAttribute("aria-invalid", "true");
        isValid = false;
      }

      // Email validation
      const emailInput = document.querySelector(
        '[data-testid="test-contact-email"]'
      );
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailInput.value.trim() || !emailRegex.test(emailInput.value)) {
        document
          .querySelector('[data-testid="test-contact-error-email"]')
          .classList.add("show");
        emailInput.setAttribute("aria-invalid", "true");
        isValid = false;
      }

      // Subject validation
      const subjectInput = document.querySelector(
        '[data-testid="test-contact-subject"]'
      );
      if (!subjectInput.value) {
        document
          .querySelector('[data-testid="test-contact-error-subject"]')
          .classList.add("show");
        subjectInput.setAttribute("aria-invalid", "true");
        isValid = false;
      }

      // Message validation
      const messageInput = document.querySelector(
        '[data-testid="test-contact-message"]'
      );
      if (!messageInput.value.trim() || messageInput.value.trim().length < 10) {
        document
          .querySelector('[data-testid="test-contact-error-message"]')
          .classList.add("show");
        messageInput.setAttribute("aria-invalid", "true");
        isValid = false;
      }

      // If valid, show success message
      if (isValid) {
        successMessage.classList.add("show");
        contactForm.reset();

        // Scroll to success message
        successMessage.scrollIntoView({ behavior: "smooth", block: "nearest" });
      }
    });
  }
});
