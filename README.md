# Homebrew tap de quicio

Casks para instalar las apps de [quicio](https://github.com/quicio) en macOS.

```bash
brew install --cask quicio/tap/catodo   # Cátodo
brew install --cask quicio/tap/candil   # Candil
```

Homebrew 5+ no carga casks de taps de terceros hasta confiarlos. Si aparece
`Refusing to load cask ... from untrusted tap`, correr una vez:

```bash
brew trust quicio/tap
```

## Cátodo

Shell multimedia con estética CRT: canales de Spotify, YouTube, anime, arcade,
TV, Crunchyroll, HBO Max y pantalla. El backend Rust viaja dentro de
`Catodo.app/Contents/Resources/backend/` y Electron lo lanza como sidecar; no hay
formula ni `brew services`.

- Requiere macOS en Apple Silicon (`arm64`).
- Cask estático: `version :latest` + `sha256 :no_check`, apuntando a
  `releases/latest/download/Catodo-mac-arm64.zip`. No se actualiza en cada
  release.

```bash
brew upgrade --cask catodo          # actualizar
brew uninstall --cask catodo        # desinstalar (conserva ~/.local/share/catodo/)
brew uninstall --cask catodo --zap  # desinstalar y borrar los datos de usuario
```

## Candil

Lector de EPUB minimalista. Cask estático con builds separados para `arm64` y
`x86_64`.

```bash
brew upgrade --cask candil
brew uninstall --cask candil --zap
```

## Gatekeeper

Ninguna de las dos apps está notarizada por Apple. Los casks intentan quitar la
cuarentena con `xattr -dr com.apple.quarantine`; si macOS igual bloquea la
primera apertura, usá clic derecho → Abrir sobre la app en `/Applications`.
