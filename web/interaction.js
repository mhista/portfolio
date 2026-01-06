class TextScramble {
  constructor(el) {
    this.el = el;
    this.chars = "!<>-_\\/[]{}—=+*^?#________";
    this.update = this.update.bind(this);
  }

  setText(newText) {
    const oldText = this.el.innerText;
    const length = Math.max(oldText.length, newText.length);
    const promise = new Promise((resolve) => (this.resolve = resolve));
    this.queue = [];

    for (let i = 0; i < length; i++) {
      const from = oldText[i] || "";
      const to = newText[i] || "";
      const start = Math.floor(Math.random() * 40);
      const end = start + Math.floor(Math.random() * 40);
      this.queue.push({ from, to, start, end });
    }

    cancelAnimationFrame(this.frameRequest);
    this.frame = 0;
    this.update();
    return promise;
  }

  update() {
    let output = "";
    let complete = 0;

    for (let i = 0, n = this.queue.length; i < n; i++) {
      let { from, to, start, end, char } = this.queue[i];

      if (this.frame >= end) {
        complete++;
        output += to;
      } else if (this.frame >= start) {
        if (!char || Math.random() < 0.28) {
          char = this.randomChar();
          this.queue[i].char = char;
        }
        output += `<span style="color: var(--green)">${char}</span>`;
      } else {
        output += from;
      }
    }

    this.el.innerHTML = output;

    if (complete === this.queue.length) {
      this.resolve();
    } else {
      this.frameRequest = requestAnimationFrame(this.update);
      this.frame++;
    }
  }

  randomChar() {
    return this.chars[Math.floor(Math.random() * this.chars.length)];
  }
}

// ============================================
// CUSTOM CURSOR - FASTER
// ============================================
function initCursor() {
  const cursor = document.querySelector(".cursor");
  const follower = document.querySelector(".cursor-follower");

  if (!cursor || !follower) return;

  let mouseX = 0,
    mouseY = 0;
  let followerX = 0,
    followerY = 0;

  document.addEventListener("mousemove", (e) => {
    mouseX = e.clientX;
    mouseY = e.clientY;
    cursor.style.transform = `translate(${mouseX - 10}px, ${mouseY - 10}px)`;
  });

  function animateFollower() {
    // FASTER: 0.3 instead of 0.1
    followerX += (mouseX - followerX) * 0.3;
    followerY += (mouseY - followerY) * 0.3;
    follower.style.transform = `translate(${followerX - 20}px, ${
      followerY - 20
    }px)`;
    requestAnimationFrame(animateFollower);
  }
  animateFollower();

  // Click effect
  document.addEventListener("mousedown", () => cursor.classList.add("click"));
  document.addEventListener("mouseup", () => cursor.classList.remove("click"));

  // Hover effects
  const hoverElements = document.querySelectorAll(
    "a, button, .project-card, .archive-item, .cursor-pointer"
  );
  hoverElements.forEach((el) => {
    el.addEventListener("mouseenter", () => cursor.classList.add("hover"));
    el.addEventListener("mouseleave", () => cursor.classList.remove("hover"));
  });
}

// ============================================
// MAGNETIC BUTTON
// ============================================
function initMagneticButtons() {
  const magneticButtons = document.querySelectorAll(".magnetic-btn, .magnetic");

  magneticButtons.forEach((button) => {
    const strength = parseInt(button.dataset.strength) || 20;

    button.addEventListener("mousemove", (e) => {
      const rect = button.getBoundingClientRect();
      const x = e.clientX - rect.left - rect.width / 2;
      const y = e.clientY - rect.top - rect.height / 2;

      button.style.transform = `translate(${x / strength}px, ${
        y / strength
      }px)`;
    });

    button.addEventListener("mouseleave", () => {
      button.style.transform = "translate(0, 0)";
    });
  });
}

// ============================================
// UPDATED PROJECT CAROUSEL JAVASCRIPT
// ============================================
function initProjectCarousel() {
  const carousel = document.querySelector(
    ".projects-carousel, #projects-carousel"
  );
  const cards = document.querySelectorAll(".project-card");
  const projectName = document.getElementById("projectName");
  const projectMeta = document.getElementById("projectMeta");
  const projectNumber = document.getElementById("projectNumber");

  if (!carousel || cards.length === 0) return;

  const scramblers = new Map();
  let activeCard = null;

  // Initialize scrambler for project name
  if (projectName) {
    scramblers.set(projectName, new TextScramble(projectName));
  }

  function setActiveCard(card, index) {
    // Remove active from all cards
    cards.forEach((c) => c.classList.remove("active"));

    // Add active to clicked/hovered card
    card.classList.add("active");
    activeCard = card;

    // Add has-active class to carousel to trigger blur effect
    carousel.classList.add("has-active");

    // Update project info
    const name = card.dataset.name;
    const meta = card.dataset.meta;
    const number = card.dataset.number;

    if (name && projectName) {
      const nameFx = scramblers.get(projectName);
      if (nameFx) {
        nameFx.setText(name);
      }
    }
    if (meta && projectMeta) projectMeta.textContent = meta;
    if (number && projectNumber) projectNumber.textContent = `[${number}]`;
  }

  function clearActiveCard() {
    cards.forEach((c) => c.classList.remove("active"));
    carousel.classList.remove("has-active");
    activeCard = null;
  }

  // Handle mouseenter
  cards.forEach((card, index) => {
    card.addEventListener("mouseenter", () => {
      setActiveCard(card, index);
    });
  });

  // Handle click
  cards.forEach((card, index) => {
    card.addEventListener("click", () => {
      setActiveCard(card, index);
    });
  });

  // Handle mouseleave from carousel (not individual cards)
  carousel.addEventListener("mouseleave", () => {
    clearActiveCard();
  });

  // Optional: Update on scroll
  carousel.addEventListener("scroll", () => {
    if (!activeCard) {
      // Only if no card is manually selected
      const scrollLeft = carousel.scrollLeft;
      const cardWidth = cards[0].offsetWidth + 16;
      const centerIndex = Math.round(scrollLeft / cardWidth);

      if (cards[centerIndex]) {
        // Don't trigger blur, just update info
        const card = cards[centerIndex];
        const name = card.dataset.name;
        const meta = card.dataset.meta;
        const number = card.dataset.number;

        if (name && projectName) {
          const nameFx = scramblers.get(projectName);
          if (nameFx) nameFx.setText(name);
        }
        if (meta && projectMeta) projectMeta.textContent = meta;
        if (number && projectNumber) projectNumber.textContent = `[${number}]`;
      }
    }
  });
}

// ============================================
// TIME UPDATE
// ============================================
function initTimeClock() {
  function updateTime() {
    const timeEl = document.getElementById("time");
    if (timeEl) {
      const now = new Date();
      const time = now.toLocaleTimeString("en-US", { hour12: false });
      timeEl.textContent = time;
    }
  }
  updateTime();
  setInterval(updateTime, 1000);
}

// ============================================
// PAGE TRANSITIONS
// ============================================
function initPageTransitions() {
  const transition = document.querySelector(".page-transition");

  if (!transition) return;

  // Show transition on link click
  document.querySelectorAll('a[href^="/"]').forEach((link) => {
    link.addEventListener("click", (e) => {
      if (e.ctrlKey || e.metaKey) return; // Allow opening in new tab

      e.preventDefault();
      transition.classList.add("active");

      setTimeout(() => {
        window.location.href = link.href;
      }, 400);
    });
  });

  // Hide transition on page load
  window.addEventListener("load", () => {
    setTimeout(() => {
      transition.classList.remove("active");
    }, 100);
  });
}

// ============================================
// GSAP SCROLL ANIMATIONS
// ============================================
function initScrollAnimations() {
  if (typeof gsap === "undefined" || typeof ScrollTrigger === "undefined")
    return;

  gsap.registerPlugin(ScrollTrigger);

  // Parallax effect on hero
  const heroTitle = document.querySelector(".hero-title");
  if (heroTitle) {
    gsap.to(".hero-title", {
      scrollTrigger: {
        trigger: ".hero",
        start: "top top",
        end: "bottom top",
        scrub: true,
      },
      y: 200,
      opacity: 0.5,
    });
  }

  // Fade in sections
  gsap.utils.toArray(".section-title").forEach((section) => {
    gsap.from(section, {
      scrollTrigger: {
        trigger: section,
        start: "top 80%",
        end: "top 50%",
        scrub: true,
      },
      opacity: 0,
      y: 50,
    });
  });
}

// ============================================
// SCROLL ANIMATIONS (IntersectionObserver)
// ============================================
function initIntersectionAnimations() {
  const observerOptions = {
    threshold: 0.2,
    rootMargin: "0px 0px -100px 0px",
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
      }
    });
  }, observerOptions);

  document
    .querySelectorAll(".slide-in-left, .slide-in-right, .fade-in")
    .forEach((el) => {
      observer.observe(el);
    });
}


// Add this to your interaction.js file
function updateActiveNavLink() {
  const currentPath = window.location.pathname;
  const navLinks = document.querySelectorAll('.nav-link');
  
  navLinks.forEach(link => {
    const path = link.getAttribute('data-path');
    if (path === currentPath || (currentPath === '/' && path === '/')) {
      link.classList.remove('text-primary-text');
      link.classList.add('text-green-neon');
    } else {
      link.classList.remove('text-green-neon');
      link.classList.add('text-primary-text');
    }
  });
}

// Update on page load
document.addEventListener('DOMContentLoaded', updateActiveNavLink);

// Update on navigation (for client-side routing)
window.addEventListener('popstate', updateActiveNavLink);

// ============================================
// INITIALIZE ALL - OPTIMIZED
// ============================================
function init() {
  console.log("Initializing portfolio...");

  // Wait for Jaspr to hydrate
  setTimeout(() => {
    // Initialize text scramble with debounce
    const scrambleElements = document.querySelectorAll(".scramble-text");
    const scramblers = new Map();
    let scrambleTimeout;

    scrambleElements.forEach((el) => {
      const fx = new TextScramble(el);
      scramblers.set(el, fx);

      // Initial scramble
      const originalText = el.getAttribute("data-text") || el.innerText;
      setTimeout(() => {
        fx.setText(originalText);
      }, Math.random() * 500);

      // Hover scramble with debounce
      el.addEventListener("mouseenter", () => {
        clearTimeout(scrambleTimeout);
        scrambleTimeout = setTimeout(() => {
          const text = el.getAttribute("data-text") || el.innerText;
          fx.setText(text);
        }, 50);
      });
    });

    // Initialize all features
    initCursor();
    initMagneticButtons();
    initProjectCarousel();
    initTimeClock();
    initPageTransitions();
    initScrollAnimations();
    initIntersectionAnimations();

    console.log("Portfolio initialized!");
  }, 200); // Wait 200ms for Jaspr
}

// Run when DOM is ready
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", init);
} else {
  init();
}

// Toggle cursor with 'C' key
let cursorEnabled = true;
document.addEventListener("keydown", (e) => {
  if (e.key === "c" || e.key === "C") {
    cursorEnabled = !cursorEnabled;
    const cursor = document.querySelector(".cursor");
    const follower = document.querySelector(".cursor-follower");

    if (cursor && follower) {
      cursor.style.display = cursorEnabled ? "block" : "none";
      follower.style.display = cursorEnabled ? "block" : "none";
      document.body.style.cursor = cursorEnabled ? "none" : "auto";
    }
  }
});


