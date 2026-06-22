# Design

Single-page direct-response lander, ~13 stacked sections, dark cinematic hero → alternating light/dark sections → embedded Typeform schedule + footer.

## Theme

Light surfaces on light sections (`#ffffff` / `#f4f5f7`), near-black on dark sections (`#050505` hero, `#0e2238` navy product sections). Brand-red `#e11d2a` as the single saturated accent (~5% surface coverage), used for italic-serif emotional emphasis, pulsing status dots, the Profit Engine core glow, and CTA hover-states. Editorial-italic + monospace data labels carry voice; no gradient text.

## Color

Tokens are HEX (not yet OKLCH — flagged for audit):

| Token | Value | Role |
|---|---|---|
| `--red` | `#e11d2a` | brand accent, italic emphasis, pulses |
| `--red-2` | `#f23845` | hover/glow tint |
| `--black` | `#050505` | hero ground |
| `--black-2` | `#0a0a0a` | secondary dark surface |
| `--navy` | `#0e2238` | dark product/section ground |
| `--navy-700` | `#0a1b2e` | dark hover/state |
| `--navy-900` | `#07131f` | footer ground |
| `--ink` | `#14233a` | body text on light |
| `--slate` | `#5b6675` | secondary text |
| `--slate-2` | `#8a94a3` | tertiary / muted labels |
| `--silver` | `#9aa6b2` | italic-serif on dark (legacy from earlier draft, partly replaced by `--red`) |
| `--paper` | `#ffffff` | light page bg |
| `--mist` | `#f4f5f7` | alternating section bg |
| `--mist-2` | `#eef0f3` | input/card subtle fill |
| `--line` | `#e6e8ec` | hairline borders on light |
| `--line-dark` | `rgba(255,255,255,.12)` | hairline borders on dark |

Contrast notes: body text (`--slate` `#5b6675` on `#fff`) ≈ 6.5:1 ✓. Section eyebrows in `--slate-2` ≈ 3.8:1 — fails AA for non-large text. Red on white ≈ 4.6:1 — borderline, OK on punch words but watch for any small-size usage.

## Typography

| Family | Role | Weights |
|---|---|---|
| **Playfair Display** | Editorial serif for h1-h2 emotional emphasis ("Stop Paying More For Leads That *Don't Convert*"). Italic for punch words. | 500–800 + matching italics |
| **Geist** | All-around UI sans: body, eyebrows-on-light, buttons, micro-labels. | 400, 500, 600, 700 |
| **Geist Mono** | All numerals (`$10`, `$50`, `$100`, `−42%`, `45 min`), data labels, "NOT_BY → BY:" framings, status chips. Carries the "operator/receipts" half of voice. | 400, 500, 600 |
| **Poppins** | Wordmark only (`ELEVATES`). Weight 500. | 500 |

Scale: heading display clamps `40px → 80px` (hero), `30px → 52px` (section h2). Body `15px–19px`. Hero h1 letter-spacing `-0.02em` (within the impeccable ≥ -0.04em floor). Italic-serif emphasis carries `text-shadow:0 2px 28px rgba(225,29,42,.35)` on dark hero for refraction. `text-wrap: balance` not yet applied — flagged.

## Components

- **Nav.** Transparent over hero → frosted-glass backdrop-filter solid on scroll. Brand mark (3-tower castle, red on white) + "ELEVATES" Poppins 500. Right side: light pill CTA → solid navy on scroll. Mobile: shortens label to "Book a Call".
- **Hero (scroll-scrubbed video).** 260vh stage with `position:sticky` pinned 100vh viewport; 4K all-keyframe MP4 (`hero.mp4` 12.9MB) advances frame-by-scroll via `currentTime = progress * duration`. Mobile falls back to autoplay loop. Heavy four-layer scrim for text legibility over the cinematic frame.
- **Profit Engine viz.** Inline SVG concentric rings (5 of them, 2 with dashed stroke counter-rotating), 2 orbiting dots, breathing red core showing live `CAC −$38 ▼42% MoM`, 4 floating chips (Funnel / Offer / Creative / Backend) with pulsing red dots.
- **Brand marquee.** Infinite horizontal scroll of 5 logos × 4 repeats = 20 tiles, CSS mask-image edge-fade, pauses on hover, grayscale → color on per-tile hover.
- **CAC Ladder.** Asymmetric 3-column grid (.85fr / .92fr / 1.05fr) replacing a banned "3-equal-cards" pattern. Best rung has gradient-edge refraction border and pulsing red "What we optimise for" meta.
- **Schedule (embedded Typeform).** 2-col: copy card on left + 620px Typeform iframe on right (`data-tf-widget="Kffv650s"`). Skeleton shimmer renders behind iframe during load.
- **Team.** Zigzag 2-col (`.85fr 1.15fr` then reversed) with portrait + bio.

## Motion

- Custom easings: `--ease-out: cubic-bezier(0.23, 1, 0.32, 1)` (strong), `--ease-in-out: cubic-bezier(0.77, 0, 0.175, 1)`.
- Hero: scroll-scrubbed video (desktop) / autoplay loop (mobile). Reduced-motion: holds first frame.
- Scroll reveals via IntersectionObserver (`once: true`, threshold 0.12, rootMargin `-80px` bottom). Stagger via `transition-delay` on direct children of `[data-stagger]`.
- Perpetual micro-motion: pulsing red dots (chips, best-rung meta, schedule "limited slots"), engine core "breath" (3.6s ease-in-out), counter-rotating rings (22s + 32s), orbiting dots (14s + 22s), brand-marquee linear infinite (38s), skeleton-shimmer 1.6s linear.
- Count-up reveals on `[data-count]` numbers (engine `$38`, `−42%`, `+68%`) via `requestAnimationFrame` with cubic ease-out, 1.4s.
- Reduced motion: every keyframe animation gates via `@media (prefers-reduced-motion: reduce)`.

## Layout

- Container: `max-w-1180px mx-auto` (`--maxw`), `padding: 0 28px`.
- Section vertical rhythm: `clamp(72px, 9vw, 128px)` top/bottom. Brands section reduced to `clamp(60px, 8vw, 100px)` for tighter pacing.
- Hero: `260vh` stage with `position:sticky` pin at 100svh (uses `svh` not `vh` to avoid iOS jump).
- Mobile breakpoint: 980px (hero collapses, multi-col grids → 1-col); 880px (schedule grid → 1-col); 560px (smaller adjustments).
- Z-index scale: nav `50`, grain overlay `45`, hero scrim `2`, hero copy `3`, scroll-cue `4`. Currently informal — flagged for systematizing.

## Surfaces & materials

- Fixed-position SVG noise overlay at z-45, `mix-blend-mode: overlay`, opacity 0.16, fractalNoise turbulence pattern. Adds tactile film grain across the whole page without per-section repaint cost.
- Cards: 14–24px radius depending on weight; tinted box-shadows (hue-matched to bg). Best-rung card has refraction border via dual mask-composite trick.
- Buttons: inner-edge shadows (`box-shadow: ... inset`) for tactile depth; `:active scale(0.97)` with 160ms ease-out for press feedback. No outer glows.
