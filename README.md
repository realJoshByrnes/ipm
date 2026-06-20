# 📦 ipm
### IRC Package Manager for mIRC & AdiIRC

`ipm` is a lightweight package manager designed to make installing, updating, and managing scripts in mIRC and AdiIRC effortless.

---

## ⚡ One-Click Installation

To install `ipm` instantly, copy the command below, paste it into any editbox (status window or channel input) in your mIRC or AdiIRC client, and press **Enter**:

```msl
//noop $urlget(https://raw.githubusercontent.com/realJoshByrnes/ipm/refs/heads/main/ipm.mrc, gfk, $scriptdir $+ ipm.mrc, .timer -m 1 1 .alias dl $chr(124) .alias dl $unsafe(if ($ $+ urlget($ $+ 1).state == ok) $chr(123) .reload -rs $ $+ qt($ $+ urlget($ $+ 1).target) $chr(124) .signal -n ipm.start $chr(125) $chr(124) else echo $color(info) -at * Unable to install ipm) $chr(124) dl)
```

> [!NOTE]
> This command will download `ipm.mrc` directly into your client's script directory and load it automatically.

---

## ✨ Features

- **Painless Setup:** One single command downloads and registers the script.
- **Self-Updating:** Keeps itself updated to the latest version automatically.
- **Compatibility:** Built to support both mIRC and AdiIRC.
- **Modular Design:** Easily extensible to fetch, install, and update your favorite IRC scripts.

## 📋 Requirements

- **mIRC** (v7.64 or newer) or **AdiIRC**
- Internet connection (for remote script downloading)

## ⚖️ License

This project is licensed under the terms of the GNU General Public License v3.0 (see [LICENSE](./LICENSE) for details).

Please note that subdirectories contain third-party packages which are governed by their respective licenses.