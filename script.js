function toggleTheme() {
    document.body.classList.toggle("dark-mode");
}

// Simple animation on scroll
window.addEventListener("scroll", function() {
    const sections = document.querySelectorAll("section");
    sections.forEach(section => {
        const position = section.getBoundingClientRect().top;
        const screenHeight = window.innerHeight;

        if(position < screenHeight - 100) {
            section.style.opacity = "1";
            section.style.transform = "translateY(0)";
        }
    });
});

// Initial style for animation
document.querySelectorAll("section").forEach(section => {
    section.style.opacity = "0";
    section.style.transform = "translateY(50px)";
    section.style.transition = "0.6s ease";
});