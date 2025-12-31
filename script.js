// ==================== PASSWORD CONFIGURATION ====================
const CORRECT_PASSWORD = "2026";

// ==================== DOM ELEMENTS ====================
const passwordScreen = document.getElementById('password-screen');
const mainScreen = document.getElementById('main-screen');
const passwordInput = document.getElementById('password-input');
const submitPassword = document.getElementById('submit-password');
const passwordError = document.getElementById('password-error');
const typingText = document.getElementById('typing-text');
const particlesCanvas = document.getElementById('particles');
const confettiContainer = document.getElementById('confetti-container');

// ==================== PASSWORD FUNCTIONALITY ====================
function checkPassword() {
    const enteredPassword = passwordInput.value;
    
    if (enteredPassword === CORRECT_PASSWORD) {
        // Success!
        passwordError.textContent = '';
        passwordScreen.style.opacity = '0';
        passwordScreen.style.transition = 'opacity 0.5s ease';
        
        setTimeout(() => {
            passwordScreen.classList.remove('active');
            mainScreen.classList.add('active');
            passwordScreen.style.opacity = '1';
            
            // Start animations after showing main screen
            startTypingAnimation();
            createConfetti();
        }, 500);
    } else {
        // Wrong password
        passwordError.textContent = '❌ Wrong password! Try again.';
        passwordError.classList.add('shake');
        
        // Add red glow to input
        passwordInput.style.borderColor = '#ff4444';
        passwordInput.style.boxShadow = '0 0 20px rgba(255, 68, 68, 0.5)';
        
        setTimeout(() => {
            passwordError.classList.remove('shake');
            passwordInput.style.borderColor = '';
            passwordInput.style.boxShadow = '';
        }, 500);
        
        // Clear input
        passwordInput.value = '';
    }
}

// Event listeners for password
submitPassword.addEventListener('click', checkPassword);
passwordInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        checkPassword();
    }
});

// ==================== TYPING ANIMATION ====================
const welcomeMessage = "Happy New Year, Best Friend! 🎆";
let charIndex = 0;

function startTypingAnimation() {
    typingText.textContent = '';
    charIndex = 0;
    
    function typeChar() {
        if (charIndex < welcomeMessage.length) {
            typingText.textContent += welcomeMessage.charAt(charIndex);
            charIndex++;
            setTimeout(typeChar, 100);
        }
    }
    
    // Start after a short delay
    setTimeout(typeChar, 500);
}

// ==================== PARTICLE BACKGROUND ====================
const ctx = particlesCanvas.getContext('2d');
let particles = [];
let animationId;

function resizeCanvas() {
    particlesCanvas.width = window.innerWidth;
    particlesCanvas.height = window.innerHeight;
}

function createParticle() {
    return {
        x: Math.random() * particlesCanvas.width,
        y: Math.random() * particlesCanvas.height,
        size: Math.random() * 3 + 1,
        speedX: (Math.random() - 0.5) * 2,
        speedY: (Math.random() - 0.5) * 2,
        opacity: Math.random() * 0.5 + 0.3,
        color: Math.random() > 0.5 ? '#0047AB' : '#00BFFF'
    };
}

function initParticles() {
    particles = [];
    const particleCount = Math.min(100, Math.floor(window.innerWidth / 10));
    
    for (let i = 0; i < particleCount; i++) {
        particles.push(createParticle());
    }
}

function drawParticles() {
    ctx.clearRect(0, 0, particlesCanvas.width, particlesCanvas.height);
    
    particles.forEach(particle => {
        ctx.beginPath();
        ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2);
        ctx.fillStyle = particle.color;
        ctx.globalAlpha = particle.opacity;
        ctx.fill();
        
        // Update position
        particle.x += particle.speedX;
        particle.y += particle.speedY;
        
        // Bounce off edges
        if (particle.x < 0 || particle.x > particlesCanvas.width) {
            particle.speedX *= -1;
        }
        if (particle.y < 0 || particle.y > particlesCanvas.height) {
            particle.speedY *= -1;
        }
        
        // Twinkle effect
        particle.opacity += (Math.random() - 0.5) * 0.1;
        if (particle.opacity < 0.2) particle.opacity = 0.2;
        if (particle.opacity > 0.8) particle.opacity = 0.8;
    });
    
    // Draw connections
    particles.forEach((particle1, i) => {
        particles.slice(i + 1).forEach(particle2 => {
            const distance = Math.sqrt(
                Math.pow(particle2.x - particle1.x, 2) +
                Math.pow(particle2.y - particle1.y, 2)
            );
            
            if (distance < 150) {
                ctx.beginPath();
                ctx.moveTo(particle1.x, particle1.y);
                ctx.lineTo(particle2.x, particle2.y);
                ctx.strokeStyle = '#0047AB';
                ctx.globalAlpha = (150 - distance) / 150 * 0.2;
                ctx.stroke();
            }
        });
    });
    
    animationId = requestAnimationFrame(drawParticles);
}

function startParticles() {
    resizeCanvas();
    initParticles();
    drawParticles();
}

function stopParticles() {
    if (animationId) {
        cancelAnimationFrame(animationId);
    }
    ctx.clearRect(0, 0, particlesCanvas.width, particlesCanvas.height);
}

// ==================== CONFETTI ANIMATION ====================
function createConfetti() {
    const colors = ['#0047AB', '#4169E1', '#00BFFF', '#6495ED', '#ffd700'];
    const confettiCount = 150;
    
    for (let i = 0; i < confettiCount; i++) {
        setTimeout(() => {
            const confetti = document.createElement('div');
            confetti.className = 'confetti';
            confetti.style.left = Math.random() * 100 + '%';
            confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
            confetti.style.animationDuration = (Math.random() * 3 + 2) + 's';
            confetti.style.transform = `rotate(${Math.random() * 360}deg)`;
            
            // Random sizes
            confetti.style.width = (Math.random() * 10 + 5) + 'px';
            confetti.style.height = (Math.random() * 10 + 5) + 'px';
            
            confettiContainer.appendChild(confetti);
            
            // Remove confetti after animation
            setTimeout(() => {
                confetti.remove();
            }, 5000);
        }, i * 30);
    }
}

// ==================== WISH CARD INTERACTIONS ====================
document.querySelectorAll('.wish-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-10px) scale(1.02)';
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
    });
    
    card.addEventListener('click', function() {
        const wish = this.dataset.wish;
        createWishEffect(this);
    });
});

function createWishEffect(card) {
    // Create floating hearts
    for (let i = 0; i < 10; i++) {
        setTimeout(() => {
            const heart = document.createElement('div');
            heart.innerHTML = '❤️';
            heart.style.position = 'absolute';
            heart.style.left = card.offsetLeft + card.offsetWidth / 2 + 'px';
            heart.style.top = card.offsetTop + 'px';
            heart.style.fontSize = '20px';
            heart.style.pointerEvents = 'none';
            heart.style.animation = 'floatUp 1s ease-out forwards';
            heart.style.zIndex = '100';
            
            document.body.appendChild(heart);
            
            setTimeout(() => {
                heart.remove();
            }, 1000);
        }, i * 100);
    }
}

// Add floatUp animation
const style = document.createElement('style');
style.textContent = `
    @keyframes floatUp {
        0% {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
        100% {
            opacity: 0;
            transform: translateY(-100px) scale(1.5);
        }
    }
`;
document.head.appendChild(style);

// ==================== SCROLL ANIMATIONS ====================
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe elements for scroll animations
document.querySelectorAll('.greeting-card, .wish-card, .quote-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
});

// ==================== WINDOW RESIZE HANDLER ====================
window.addEventListener('resize', () => {
    resizeCanvas();
    if (mainScreen.classList.contains('active')) {
        initParticles();
    }
});

// ==================== INITIALIZATION ====================
document.addEventListener('DOMContentLoaded', () => {
    // Initialize particles on password screen
    startParticles();
    
    // Focus password input
    passwordInput.focus();
});

// ==================== EASTER EGG - Konami Code ====================
let konamiCode = [];
const konamiPattern = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'];

document.addEventListener('keydown', (e) => {
    konamiCode.push(e.key);
    konamiCode = konamiCode.slice(-10);
    
    if (konamiCode.join(',') === konamiPattern.join(',')) {
        // Easter egg activated!
        createConfetti();
        alert('🎉 You found the secret! Happy New Year! 🎉');
    }
});

// ==================== ADDITIONAL VISUAL EFFECTS ====================
// Add glow effect to year on scroll
window.addEventListener('scroll', () => {
    const yearText = document.querySelector('.year-text');
    const scrollY = window.scrollY;
    
    if (yearText) {
        yearText.style.textShadow = `
            0 0 ${30 + scrollY * 0.1}px rgba(0, 71, 171, 0.5),
            0 0 ${60 + scrollY * 0.1}px rgba(0, 191, 255, 0.3)
        `;
    }
});

// Magnetic effect on wish cards
document.querySelectorAll('.wish-card').forEach(card => {
    card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        
        const rotateX = (y - centerY) / 20;
        const rotateY = (centerX - x) / 20;
        
        card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.05, 1.05, 1.05)`;
    });
    
    card.addEventListener('mouseleave', () => {
        card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) scale3d(1, 1, 1)';
    });
});

console.log('🎆 Happy New Year 2026! Made with ❤️ by Kudra');

