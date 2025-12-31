# 🎆 Happy New Year 2025 - Gift Website

A beautiful, futuristic Happy New Year gift website for your best friend! 🎉

## ✨ Features

- 🔐 **Password Protection** - Enter the magic with a secret password
- 🌙 **Dark Mode** - Futuristic neon design with dark theme
- 🎨 **Cool Animations** - Particles, typing effects, confetti, and more
- 📱 **Responsive** - Works perfectly on all devices
- 💫 **Interactive** - Hover effects and magnetic cards
- 🎊 **Personal Wishes** - Six beautiful wish cards with special messages

## 🔑 Password

The default password is: `KudraBestFriend2025`

You can change this in `script.js` by modifying the `CORRECT_PASSWORD` constant.

## 🚀 Deployment to GitHub Pages

1. **Create a GitHub repository**
   - Go to [GitHub](https://github.com)
   - Click "+" → "New repository"
   - Name it (e.g., "new-year-gift")
   - Make it Public
   - Click "Create repository"

2. **Push your files**
   ```bash
   git init
   git add .
   git commit -m "🎆 Happy New Year 2025 - Initial commit"
   git branch -M main
   git remote add origin https://github.com/am3lue/am3lue.git
   git push -u origin main
   ```

3. **Enable GitHub Pages**
   - Go to your repository on GitHub
   - Click "Settings" → "Pages" (left sidebar)
   - Under "Source", select "main" branch
   - Click "Save"
   - Wait 1-2 minutes for deployment

4. **Access your site**
   - Your site will be available at: `https://am3lue.github.io/am3lue/`

## 📂 Project Structure

```
├── index.html    # Main webpage
├── style.css     # Styling and animations
├── script.js     # Interactive features
├── README.md     # This file
└── todo.md       # Project planning notes
```

## 🎨 Customization

### Change Password
Edit `script.js` line 3:
```javascript
const CORRECT_PASSWORD = "2026";
```

### Change Friend's Name
Edit `index.html` - find "Dear My Best Friend," and replace with her name.

### Change Wishes
Edit the wish cards in `index.html` to personalize the messages.

### Change Colors
Edit CSS variables in `style.css` (lines 5-15):
```css
:root {
    --neon-cyan: #00f5ff;      /* Change cyan color */
    --neon-magenta: #ff00ff;   /* Change magenta color */
    --neon-gold: #ffd700;      /* Change gold color */
}
```

## 🎮 Easter Egg

There's a hidden Konami code! Try entering: ↑↑↓↓←→←→BA

## 📱 Preview

Open `index.html` directly in your browser to preview locally!

## 💖 Made with Love

Created by Kudra for her best friend. Happy New Year 2025! 🎊

