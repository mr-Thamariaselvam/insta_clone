/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'media', // Automatically uses user's system theme (light/dark)
  content: ["./templates/**/*.html"],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          '-apple-system',
          'BlinkMacSystemFont',
          'Segoe UI',
          'Roboto',
          'Helvetica Neue',
          'Arial',
          'Noto Sans',
          'sans-serif',
          'Apple Color Emoji',
          'Segoe UI Emoji',
          'Segoe UI Symbol',
          'Noto Color Emoji',
        ],
      },
       colors: {
        bg: 'var(--color-bg)',
        text: 'var(--color-text)',
        card: 'var(--color-card)',
        input: 'var(--color-input)',
        border: 'var(--color-border)',
        link: 'var(--color-link)',
        blue: 'var(--color-blue)',
        footer: 'var(--color-footer)',
      }
    },
  },
  plugins: [],
}
