// ============================================
// TEXT SCRAMBLE EFFECT
// ============================================
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
// CUSTOM CURSOR - DESKTOP ONLY
// ============================================
function initCursor() {
  // Only on desktop
  if (window.innerWidth < 640) return;

  const cursor = document.querySelector(".cursor");
  const follower = document.querySelector(".cursor-follower");

  if (!cursor || !follower) return;

  let mouseX = 0, mouseY = 0;
  let followerX = 0, followerY = 0;

  document.addEventListener("mousemove", (e) => {
    mouseX = e.clientX;
    mouseY = e.clientY;
    cursor.style.transform = `translate(${mouseX - 10}px, ${mouseY - 10}px)`;
  });

  function animateFollower() {
    followerX += (mouseX - followerX) * 0.3;
    followerY += (mouseY - followerY) * 0.3;
    follower.style.transform = `translate(${followerX - 20}px, ${followerY - 20}px)`;
    requestAnimationFrame(animateFollower);
  }
  animateFollower();

  document.addEventListener("mousedown", () => cursor.classList.add("click"));
  document.addEventListener("mouseup", () => cursor.classList.remove("click"));

  const hoverElements = document.querySelectorAll("a, button, .project-card, .archive-item, .cursor-pointer");
  hoverElements.forEach((el) => {
    el.addEventListener("mouseenter", () => cursor.classList.add("hover"));
    el.addEventListener("mouseleave", () => cursor.classList.remove("hover"));
  });
}

// ============================================
// MAGNETIC BUTTON - DESKTOP ONLY
// ============================================
function initMagneticButtons() {
  // Only on desktop
  if (window.innerWidth < 640) return;

  const magneticButtons = document.querySelectorAll(".magnetic-btn, .magnetic");

  magneticButtons.forEach((button) => {
    const strength = parseInt(button.dataset.strength) || 20;

    button.addEventListener("mousemove", (e) => {
      const rect = button.getBoundingClientRect();
      const x = e.clientX - rect.left - rect.width / 2;
      const y = e.clientY - rect.top - rect.height / 2;

      button.style.transform = `translate(${x / strength}px, ${y / strength}px)`;
    });

    button.addEventListener("mouseleave", () => {
      button.style.transform = "translate(0, 0)";
    });
  });
}

// ============================================
// PROJECT CAROUSEL - MOBILE OPTIMIZED
// ============================================
function initProjectCarousel() {
  const carousel = document.querySelector(".projects-carousel, #projects-carousel");
  const cards = document.querySelectorAll(".project-card");
  const projectName = document.getElementById("projectName");
  const projectMeta = document.getElementById("projectMeta");
  const projectNumber = document.getElementById("projectNumber");

  if (!carousel || cards.length === 0) return;

  const scramblers = new Map();
  let activeCard = null;
  const isMobile = window.innerWidth < 640;

  // Initialize scrambler for project name
  if (projectName) {
    scramblers.set(projectName, new TextScramble(projectName));
  }

  function setActiveCard(card, index) {
    cards.forEach((c) => c.classList.remove("active"));
    card.classList.add("active");
    activeCard = card;
    carousel.classList.add("has-active");

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

  function clearActiveCard() {
    carousel.classList.remove("has-active");
    cards.forEach((c) => c.classList.remove("active"));
    activeCard = null;
  }

  // MOBILE: Use IntersectionObserver for scroll-based activation
  if (isMobile) {
    const observerOptions = {
      root: carousel,
      threshold: 0.6, // Card is 60% visible
      rootMargin: "0px",
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const card = entry.target;
          const index = parseInt(card.dataset.index || "0");
          setActiveCard(card, index);
        }
      });
    }, observerOptions);

    cards.forEach((card) => observer.observe(card));

    // Also handle touch interactions
    carousel.addEventListener("touchstart", (e) => {
      const card = e.target.closest(".project-card");
      if (card) {
        const index = parseInt(card.dataset.index || "0");
        setActiveCard(card, index);
      }
    });
  }

  // DESKTOP: Use hover and click
  if (!isMobile) {
    carousel.addEventListener("mouseover", (e) => {
      const card = e.target.closest(".project-card");
      if (card) {
        const index = parseInt(card.dataset.index || "0");
        setActiveCard(card, index);
      }
    });

    carousel.addEventListener("mouseout", (e) => {
      if (!e.relatedTarget || !carousel.contains(e.relatedTarget)) {
        clearActiveCard();
      }
    });

    carousel.addEventListener("mouseleave", () => {
      clearActiveCard();
    });
  }

  // Click handler for both mobile and desktop
  carousel.addEventListener("click", (e) => {
    const card = e.target.closest(".project-card");
    if (card) {
      const index = parseInt(card.dataset.index || "0");
      setActiveCard(card, index);
      
      // Mobile: Scroll to center
      if (isMobile) {
        card.scrollIntoView({ behavior: "smooth", block: "nearest", inline: "center" });
      }
    }
  });

  // Optional: Update on scroll (for both mobile and desktop)
  let scrollTimeout;
  carousel.addEventListener("scroll", () => {
    clearTimeout(scrollTimeout);
    scrollTimeout = setTimeout(() => {
      if (!activeCard) {
        const scrollLeft = carousel.scrollLeft;
        const cardWidth = cards[0].offsetWidth + (isMobile ? 16 : 16);
        const centerIndex = Math.round(scrollLeft / cardWidth);

        if (cards[centerIndex]) {
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
    }, 100);
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

  document.querySelectorAll('a[href^="/"]').forEach((link) => {
    link.addEventListener("click", (e) => {
      if (e.ctrlKey || e.metaKey) return;
      e.preventDefault();
      transition.classList.add("active");
      setTimeout(() => {
        window.location.href = link.href;
      }, 400);
    });
  });

  window.addEventListener("load", () => {
    setTimeout(() => {
      transition.classList.remove("active");
    }, 100);
  });
}

// ============================================
// GSAP SCROLL ANIMATIONS - DESKTOP ONLY
// ============================================
function initScrollAnimations() {
  if (typeof gsap === "undefined" || typeof ScrollTrigger === "undefined") return;
  if (window.innerWidth < 640) return; // Skip on mobile

  gsap.registerPlugin(ScrollTrigger);

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

  // Project Detail Hero Animation
  const projectHero = document.querySelector(".project-detail-hero");
  if (projectHero) {
    gsap.from(".project-detail-info", {
      x: -100,
      opacity: 0,
      duration: 1,
      ease: "power4.out"
    });
    gsap.from(".project-detail-image", {
      x: 100,
      opacity: 0,
      duration: 1,
      ease: "power4.out"
    });
  }

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
// INTERSECTION ANIMATIONS
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

  document.querySelectorAll(".slide-in-left, .slide-in-right, .fade-in").forEach((el) => {
    observer.observe(el);
  });
}

// ============================================
// ACTIVE NAV LINK
// ============================================
function updateActiveNavLink() {
  const currentPath = window.location.pathname;
  const navLinks = document.querySelectorAll(".nav-link");

  navLinks.forEach((link) => {
    const path = link.getAttribute("data-path");
    if (path === currentPath || (currentPath === "/" && path === "/")) {
      link.classList.remove("text-primary-text");
      link.classList.add("text-green-neon");
    } else {
      link.classList.remove("text-green-neon");
      link.classList.add("text-primary-text");
    }
  });
}

// ============================================
// PROJECT DETAIL GALLERY
// ============================================
function initProjectDetailGallery() {
  const gallery = document.querySelector(".project-gallery-main");
  const thumbs = document.querySelectorAll(".gallery-thumb");
  const nextBtn = document.querySelector(".gallery-next");
  const prevBtn = document.querySelector(".gallery-prev");
  const counter = document.querySelector(".gallery-counter");

  if (!gallery || thumbs.length === 0) return;

  let currentIndex = 0;

  function updateGallery(index) {
    currentIndex = index;
    const thumb = thumbs[index];
    const src = thumb.getAttribute("data-src");
    
    // Update main image
    const mainImg = gallery.querySelector("img");
    if (mainImg && src) {
      mainImg.style.opacity = "0";
      setTimeout(() => {
        mainImg.src = src;
        mainImg.style.opacity = "1";
      }, 300);
    }

    // Update thumbs
    thumbs.forEach(t => t.classList.remove("active", "ring-2", "ring-white"));
    thumb.classList.add("active", "ring-2", "ring-white");

    // Update counter
    if (counter) {
      counter.textContent = `${currentIndex + 1} / ${thumbs.length}`;
    }
  }

  thumbs.forEach((thumb, index) => {
    thumb.addEventListener("click", () => updateGallery(index));
  });

  if (nextBtn) {
    nextBtn.addEventListener("click", () => {
      let next = (currentIndex + 1) % thumbs.length;
      updateGallery(next);
    });
  }

  if (prevBtn) {
    prevBtn.addEventListener("click", () => {
      let prev = (currentIndex - 1 + thumbs.length) % thumbs.length;
      updateGallery(prev);
    });
  }
}

// ============================================
// INITIALIZE ALL
// ============================================
function init() {
  console.log("🎨 Initializing portfolio...");

  // Clean up existing observers/listeners if needed (optional for now)
  
  const scrambleElements = document.querySelectorAll(".scramble-text");
  console.log(`📝 Found ${scrambleElements.length} scramble elements`);

  const scramblers = new Map();
  let scrambleTimeout;

  scrambleElements.forEach((el) => {
    // Only if not already processed
    if (el.dataset.scrambleInit) return;
    el.dataset.scrambleInit = "true";

    const fx = new TextScramble(el);
    scramblers.set(el, fx);

    const originalText = el.getAttribute("data-text") || el.innerText;
    setTimeout(() => {
      fx.setText(originalText);
    }, Math.random() * 500);

    el.addEventListener("mouseenter", () => {
      clearTimeout(scrambleTimeout);
      scrambleTimeout = setTimeout(() => {
        const text = el.getAttribute("data-text") || el.innerText;
        fx.setText(text);
      }, 50);
    });
  });

  initCursor();
  initMagneticButtons();
  initProjectCarousel();
  initProjectDetailGallery();
  initTimeClock();
  initPageTransitions();
  initScrollAnimations();
  initIntersectionAnimations();
  updateActiveNavLink();

  console.log("✅ Portfolio initialized!");
}

// Expose to window for Jaspr to call
window.initPortfolio = init;

// ============================================
// WAIT FOR JASPR HYDRATION
// ============================================
function waitForJaspr() {
  let attempts = 0;
  const checkHydration = setInterval(() => {
    attempts++;
    const carousel = document.querySelector("#projects-carousel");
    const cards = document.querySelectorAll(".project-card");

    if (carousel && (cards.length > 0 || attempts > 20)) {
      clearInterval(checkHydration);
      console.log(`✅ Jaspr ready after ${attempts} attempts`);
      init();
    }
  }, 100);
}

if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", waitForJaspr);
} else {
  waitForJaspr();
}

// Update on navigation
document.addEventListener("DOMContentLoaded", updateActiveNavLink);
window.addEventListener("popstate", () => {
  updateActiveNavLink();
  init(); // Re-init on back/forward
});