# 🔵 Prospira Free Utility V0.1

**Release Date:** 11/12/2025 📅  

---

### 🆕 New Stuff / Features

- Added a **license system** (`license.dat` stored in AppData).
- Added a **login system** (username + password).
- Added **first-time setup** for new users.
- Added **password reset option**.
- Added **colored console text** for a better look.
- Added **automatic admin rights check** and elevation if needed.
- Added **UTF-8 support** for proper display and input.
- Added a **license screen** that shows on first launch.
- Added **auto restart as admin** if permissions are missing.
- Added a simple **folder test/cleanup** inside System32.
- Added **PowerShell ExecutionPolicy** bypass setup for compatibility.
- Added **System Info** section to view detailed PC information.

---

### ⚙️ System

- Fully menu-based batch layout with categorized tweak sections.
- Improved startup detection and setup logic.
- Automatically skips setup if license already exists.
- Cleaner visuals and easier navigation between menus.

---

### 🔒 User & Security

- Stores user data safely in `%APPDATA%\ProspiraTweaks\`.
- Login attempts have validation and feedback.
- Password reset available if forgotten.

---

### 🧩 Tools & Tweaks

- Includes a full set of **system optimization tweaks**, grouped by category:
  - **BCDEdit tweaks** - improve system timer and boot settings.
  - **Privacy tweaks** - disable telemetry, tracking, feedback, and ads.
  - **Performance tweaks** - adjust system settings for smoother performance.
  - **Network tweaks** - reduce latency and improve connection stability.
  - **Visual tweaks** - disable animations and effects for faster response.
  - **Service tweaks** - turn off unnecessary background services.
  - **Extra tweaks** - smaller system optimizations and fixes.
- Built-in **restore point creation** before applying any tweaks.
- Includes a **revert option** to undo all tweaks if needed.

---

### 🔍 Behind the Scenes

- Over 60 internal script sections ensure modularity and reliability.
- Added comments, GPL license header, and preparation for future updates.
- Base framework for adding new utilities and modules in upcoming versions.

---

### 🔮 Coming Next (V0.2 Preview)
 
- Optional auto-update system
- MORE SOON 

---


# 🔵 Prospira Free Utility V0.11

**Release Date:** 11/19/2025 📅

---

### ✨ Improvements & Changes

* Replaced all legacy ASCII art (`/ \`) with a new, modern block-style (`█`) design across the entire utility.
* Added a new startup section to automatically add the script to Windows Defender exclusions, preventing false positive detections.
* Updated the resource download link for `NSudo.exe` to point to the new repository location.
* Changed the script's file encoding from UTF-8 to UTF-8 with BOM to fix rendering issues with `echo` commands and special characters.

---
