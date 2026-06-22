# Elevates — Lander Design V1

Single-page, self-contained marketing lander for **Elevates** (Singapore performance marketing agency). Long-form direct-response narrative ending in an embedded Typeform strategy-session booking.

## Run it

> ⚠️ **Do not double-click `index.html`.** The scroll-scrubbed hero video, the Typeform embed, and a few asset requests all require a real HTTP origin. Opening the page via `file://` silently breaks the hero scroll animation (the video stays frozen on the poster while you scroll).

**Easiest path** — double-click the matching launcher:

- **Windows:** `serve.bat`
- **Mac:** `serve.command` (right-click → Open the first time to allow execution)

Either opens `http://localhost:5577` in your browser and everything works.

**Manual alternative** if you don't want the launcher script:

```bash
# Python (any version 3.x — pre-installed on Mac, comes with Win 11)
python -m http.server 5577

# Or Node, no install required
npx serve .

# Or VS Code: install "Live Server" extension → right-click index.html → Open with Live Server
```

Then open `http://localhost:5577`.

## File tree

```
lander-design-v1/
├── index.html          # the entire page (HTML + CSS + JS, ~70 KB)
├── serve.bat           # Windows: double-click → opens http://localhost:5577
├── serve.command       # Mac:     double-click → opens http://localhost:5577
├── PRODUCT.md          # strategy: who/what/why, voice, anti-references, principles
├── DESIGN.md           # visual system: colors, type, components, motion, layout
├── README.md           # this file
└── assets/
    ├── hero.mp4        # 4K all-keyframe hero video (5.04s, 12.9 MB)
    ├── hero-poster.jpg # static poster for hero (2560×1440)
    ├── kennedy.jpg     # team portrait (1100×1649)
    ├── hervy.jpg       # team portrait (1100×1649)
    ├── logo.png        # brand mark (red+white castle, 72×70 transparent)
    ├── logo-01.png     # client: CognitiveX
    ├── logo-02.png     # client: Biohackk
    ├── logo-03.png     # client: Befound
    ├── logo-04.png     # client: The Edu Experience
    └── logo-05.png     # client: Workjoy
```

## Stack & dependencies

- Plain HTML + CSS + vanilla JS — **no build, no framework, no node_modules**
- Google Fonts (CDN): Playfair Display, Poppins
- Geist + Geist Mono via jsdelivr CDN
- Typeform embed via `embed.typeform.com/next/embed.js` (form ID `Kffv650s`)

All external dependencies load over the public internet; nothing is bundled locally.

## Page structure

13 stacked sections, in order:

1. **Hero** — scroll-scrubbed cinematic video of the two founders chatting → handshake. 260vh stage, pins 100svh, plays via `currentTime = progress * duration`. Mobile falls back to autoplay loop.
2. **Problem** — counter-led `01–04` cards: cost rising, leads not converting, etc.
3. **False Game** — 3 quote chips + navy callout: "you don't scale a business with leads"
4. **Real Problem (CAC Ladder)** — asymmetric `$10 / $50 / $100` ladder, best rung in navy with red-edge refraction
5. **Mechanism** — *The Elevates Profit Engine™*: two-column with animated concentric-ring viz on the right (5 rings, 2 orbiting dots, breathing red core showing live `CAC $38 ▼42% MoM`, 4 floating chips)
6. **What's Different** — split: copy + ask/answer card
7. **Why This Works** — split: when-you list + benefit box
8. **Brands** — infinite kinetic marquee of 5 real client logos
9. **Qualification** — Who This Is For / Who This Is Not For
10. **The Elevates Difference** — split: anti-list + flow box
11. **Offer** — 5 bullets in a navy-bordered card
12. **Team** — zigzag bios of Kennedy + Hervy
13. **CTA / Schedule** — two-column: copy card + embedded Typeform

## Design tokens (quick reference)

```css
--red:        #e11d2a   /* brand accent: italic emphasis, CTAs, pulses, engine core */
--red-2:      #f23845   /* hover/glow */
--navy:       #0e2238   /* dark surface ground (mechanism, callouts, footer) */
--navy-900:   #07131f   /* deepest navy */
--ink:        #14233a   /* body text on light */
--slate:      #5b6675   /* secondary text */
--mist:       #f4f5f7   /* alternating light section bg */
```

Fonts: Playfair Display (editorial italic emphasis), Geist + Geist Mono (UI body + data labels), Poppins 500 (wordmark only).

Full design notes are in **DESIGN.md**.

## Motion

- Custom easing: `cubic-bezier(0.23, 1, 0.32, 1)` for ease-out, `(0.77, 0, 0.175, 1)` for ease-in-out
- Hero: scroll-scrubbed 4K video (desktop) / autoplay loop (mobile)
- Scroll reveals via `IntersectionObserver` (`once: true`)
- Perpetual motion: brand-marquee, engine concentric rings, engine breath, pulsing status dots
- Count-up animations on data numerals (`−42%`, `+68%`, `$38`)
- All animations gate on `prefers-reduced-motion: reduce`

## What I'd hand off

For your designer to iterate visually:

1. **The 4K hero video** is generated AI footage (Seedance 2.0, 1080p × Bytedance 4K upscale). If you have real footage of the founders, swap `assets/hero.mp4` and `assets/hero-poster.jpg`. The page expects 16:9 at any resolution from 1080p–4K.
2. **The Profit Engine viz** is inline SVG with CSS animations — fully editable in `index.html` (search for `class="engine"`).
3. **The kinetic marquee** swaps logos by replacing the 5 `assets/logo-0?.png` files. Currently hardcoded order: CognitiveX, Biohackk, Befound, The Edu Experience, Workjoy.
4. **Copy** is voice-locked to the direct-response register described in PRODUCT.md. Headlines and italic-red emphasis are the conversion levers — touch carefully.

## Known polish items (P3)

Punch list for the next iteration if your designer wants to clean up before launch:

- Hero video ships at 4K (12.9 MB) regardless of viewport. Adding a `<source media="(max-width: 1100px)">` 1080p fallback would cut mobile bandwidth by ~60%.
- Team member names (`.m-name` divs) should be `<h3>` for semantic heading hierarchy.
- 60+ inline styles in `index.html` — worth extracting into utility classes if your designer prefers a cleaner token-based stylesheet.
- Color tokens are HEX; converting to OKLCH would make tint/shade math easier for future variants.

These are documented in greater detail at the bottom of an audit pass (run by Impeccable v3.7.1; full report available on request).
