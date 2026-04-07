# 📝 Dotfiles

Personal Linux configuration built around a **minimal Wayland workflow**.

Focused on simplicity, speed and a clean terminal experience.

---

## 🖼️ Preview

<p align="center">
  <img src="desktop.png" width="900">
</p>

---

## 🖥️ Environment

| Component          | Setup   |
| ------------------ | ------- |
| **Distro**         | CachyOS |
| **Display Server** | Wayland |
| **Compositor**     | Niri    |

---

## ⚙️ Core Tools

| Tool          | Description                   |
| ------------- | ----------------------------- |
| **Niri**      | Scrollable Wayland compositor |
| **Fish**      | Friendly interactive shell    |
| **Starship**  | Fast and minimal prompt       |
| **Fastfetch** | System information display    |

---

## 📁 Structure

```
.
├── fastfetch
│   └── config.jsonc
├── fish
│   ├── conf.d
│   └── config.fish
├── niri
│   └── config.kdl
├── starship.toml
└── desktop.png
```

---

## 🤖 Claude Code

Managed with **Claude Code** (CLI) powered by **Claude Opus 4.6**.

### Workflow
- Feature work uses isolated **git worktrees** (via `superpowers:using-git-worktrees`)
- Implementation follows **TDD** and systematic debugging
- Plans are written before multi-step tasks (`superpowers:writing-plans`)
- Verification always before claiming completion (`superpowers:verification-before-completion`)

---

## 🎯 Philosophy

* Fast
* Minimal
* Terminal-centric
