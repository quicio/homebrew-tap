cask "fm1lab" do
  version :latest
  sha256 :no_check

  on_arm do
    url "https://github.com/quicio/fm1lab/releases/latest/download/fm1lab-macos-arm64-app.tar.gz"
  end
  on_intel do
    url "https://github.com/quicio/fm1lab/releases/latest/download/fm1lab-macos-x86_64-app.tar.gz"
  end

  name "FM1Lab"
  desc "Laboratorio y panel de performance para el M-VAVE FM-1"
  homepage "https://github.com/quicio/fm1lab"

  depends_on :macos

  app "FM1Lab.app"
  binary "#{appdir}/FM1Lab.app/Contents/MacOS/fm1ctl", target: "fm1ctl"

  # Ni la app ni el binario están notarizados por Apple: la firma es ad-hoc.
  # Homebrew conserva la cuarentena de la descarga, así que la quitamos para
  # que la primera apertura no quede bloqueada por Gatekeeper.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/FM1Lab.app"],
        writable_paths: ["/Applications/FM1Lab.app"],
        must_succeed:   false
  end

  zap trash: [
    "~/.config/fm1lab",
    "~/Library/Saved Application State/com.quicio.fm1lab.savedState",
  ]

  caveats <<~EOS
    FM1Lab se distribuye sin notarización de Apple. Este cask intenta quitar la
    cuarentena; si macOS igual bloquea la primera apertura, usá clic derecho →
    Abrir sobre FM1Lab.app.

    El panel usa MIDI por USB. Si el FM-1 no aparece, revisá el cable de datos y
    que otra app no esté usando el puerto. El comando `fm1ctl` queda enlazado en
    /opt/homebrew/bin (o /usr/local/bin) para diagnóstico y setlists.
  EOS
end
