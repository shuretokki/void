#import "lib/banner/banner.typ": banner
#import "@preview/beautitled:0.1.0": *
#import "@preview/zebraw:0.6.1": zebraw

#let theme = sys.inputs.at("theme", default: "dark")
#let (bg-color, card-bg, text-color, secondary-color) = if theme == "dark" {
  (rgb("#000000"), rgb("#111111"), rgb("#ffffff"), rgb("#a3a3a3"))
} else {
  (rgb("#ffffff"), rgb("#ffffff"), rgb("#000000"), rgb("#525252"))
}
#let accent-color = if theme == "dark" { white } else { black }

#set page(
  fill: none,
  width: 800pt,
  height: auto,
  margin: 0pt,
)

#set text(
  fill: text-color,
  font: "HarmonyOS Sans",
  size: 14pt,
)

#beautitled-setup(
  style: "creative",
  primary-color: text-color,
  secondary-color: secondary-color,
  accent-color: accent-color,
)
#show: beautitled-init

#let banner-stroke = 0.5pt + if theme == "dark" { white.transparentize(80%) } else { black.lighten(80%) }
#let zebraw = zebraw.with(background-color: if theme == "dark" { card-bg.lighten(5%) } else {
  secondary-color.lighten(90%)
})

#show raw.where(block: true): it => block(
  width: 100%,
  radius: 12pt,
  stroke: banner-stroke,
  clip: true,
)[
  #set text(font: "JetBrainsMono NF", size: 12pt)
  #zebraw(it)
]

#align(center)[
  #banner(
    title: "void",
    subtitle: "shuretokki",
    theme: theme,
  )
]

#v(20pt)

#let kbd(txt) = box(
  inset: (x: 6pt, y: 3pt),
  baseline: 20%,
  radius: 6pt,
  fill: if theme == "dark" { bg-color.lighten(10%) } else { secondary-color.lighten(95%) },
  stroke: banner-stroke,
  text(size: 10pt, weight: "bold", font: "JetBrainsMono NF", txt),
)

#grid(
  columns: (1fr, 1.2fr),
  gutter: 40pt,
  [
    == #text(fill: accent-color)[About]

    #text(size: 11pt)[
      *Void* is a real-time distributed engine for synchronous puzzle-logic orchestration and multi-agent competitive assessment. It facilitates high-fidelity state synchronization for deterministic resolution of cryptographic challenges and cognitive game-flow, providing a robust substrate for performant, session-based adversarial reasoning.
    ]

    #v(10pt)
    == #text(fill: accent-color)[Getting Started]

    #text(size: 11pt)[
      *Prerequisites:* Ensure #kbd("Just") is installed.
      Nix (Linux/WSL) or Node.js v22+ (Native).
    ]

    #v(10pt)
    ```bash
    # setup project
    just setup
    ```
    ```bash
    # run dev server
    just dev
    ```
    ```bash
    # optional
    direnv allow
    ```
  ],
  [
    == #text(fill: accent-color, font: "HarmonyOS Sans")[Tools]

    #v(6pt)
    #stack(dir: ltr, spacing: 8pt, kbd("Nuxt 4"), kbd("LibSQL"), kbd("Drizzle"), kbd("Tailwind v4"))

    #v(10pt)
    == #text(fill: accent-color)[Verification]
    ```bash
    # verify build integrity
    just check
    ```

    #v(10pt)
    == #text(fill: accent-color)[Persistence]
    ```bash
    # scheme sync
    just migrate
    ```

    #v(10pt)
    == #text(fill: accent-color)[Deployment]
    ```bash
    # rollout
    just deploy
    ```
  ],
)

#v(50pt)
#line(length: 100%, stroke: 0.5pt + secondary-color.transparentize(50%))
#v(10pt)
#align(center)[
  #text(size: 10pt, fill: secondary-color, font: "HarmonyOS Sans", style: "italic")[
    Supported on NixOS, macOS, and Windows via PowerShell.
  ]
]
