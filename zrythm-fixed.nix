{
  stdenv,
  lib,
  fetchFromGitHub,
  fetchzip,
  alsa-lib,
  appstream,
  bash-completion,
  boost,
  carla,
  chromaprint,
  cmake,
  curl,
  dbus,
  dconf,
  fftw,
  fftwFloat,
  flex,
  glib,
  graphviz,
  gtk4,
  gtksourceview5,
  guile,
  help2man,
  jq,
  kissfft,
  libadwaita,
  libbacktrace,
  libcyaml,
  libepoxy,
  libjack2,
  libpanel,
  libpulseaudio,
  libsamplerate,
  libsndfile,
  libxml2,
  libyaml,
  lilv,
  lv2,
  meson,
  ninja,
  pcre2,
  pkg-config,
  plasma5Packages,
  python3,
  rtaudio_6,
  rtmidi,
  rubberband,
  sassc,
  serd,
  sord,
  sox,
  soxr,
  sratom,
  texi2html,
  vamp-plugin-sdk,
  wrapGAppsHook4,
  writeScript,
  xdg-utils,
  xxHash,
  yyjson,
  zix,
  zstd,
}:

let
  # Error: Dependency carla-host-plugin found: NO found 2.5.6 but need: '>=2.6.0'
  # So we need Carla unstable
  carla-unstable = carla.overrideAttrs (oldAttrs: {
    pname = "carla";
    version = "unstable-2024-04-26";

    src = fetchFromGitHub {
      owner = "falkTX";
      repo = "carla";
      rev = "948991d7b5104280c03960925908e589c77b169a";
      hash = "sha256-uGAuKheoMfP9hZXsw29ec+58dJM8wMuowe95QutzKBY=";
    };
  });
in
stdenv.mkDerivation (finalAttrs: {
  pname = "zrythm";
  version = "1.0.0";

  src = fetchzip {
    url = "https://www.zrythm.org/releases/zrythm-${finalAttrs.version}.tar.xz";
    hash = "sha256-qI1UEIeIJdYQcOWMjJa55DaWjDIabx56dSwjhm64ROM=";
  };

  passthru.updateScript = writeScript "update-zrythm" ''
    #!/usr/bin/env nix-shell
    #!nix-shell -i bash -p curl common-updater-scripts

    version="$(curl -s https://www.zrythm.org/releases/ | grep -o -m 1 'href="zrythm-[^"]*\.tar\.xz"' | head -1 | sed 's/href="zrythm-\(.*\)\.tar\.xz"/\1/')"
    update-source-version zrythm "$version"
  '';

  nativeBuildInputs = [
    chromaprint
    cmake
    flex
    guile
    help2man
    jq
    libxml2
    lilv
    meson
    ninja
    pkg-config
    python3
    python3.pkgs.sphinx
    sassc
    serd
    sord
    sratom
    texi2html
    wrapGAppsHook4
  ];

  buildInputs = [
    appstream
    bash-completion
    boost
    carla-unstable
    curl
    dbus
    dconf
    fftw
    fftwFloat
    glib
    graphviz
    gtk4
    gtksourceview5
    kissfft
    libadwaita
    libbacktrace
    libcyaml
    libepoxy
    libjack2
    libpanel
    libpulseaudio
    libsamplerate
    libsndfile
    libyaml
    lv2
    pcre2
    rtaudio_6
    rtmidi
    rubberband
    sox
    soxr
    vamp-plugin-sdk
    xdg-utils
    xxHash
    yyjson
    zix
    zstd
  ]
  ++ lib.optionals stdenv.isLinux [
    alsa-lib
  ];

  # Zrythm uses meson to build, but requires cmake for dependency detection.
  dontUseCmakeConfigure = true;

  dontWrapQtApps = true;

  mesonFlags = [
    "-Db_lto=false"
    "-Dcarla=enabled"
    "-Dcarla_binaries_dir=${carla-unstable}/lib/carla"
    "-Ddebug=true"
    "-Dfftw3_threads_separate=false"
    "-Dfftw3_threads_separate_type=library"
    "-Dfftw3f_separate=false"
    "-Dlsp_dsp=disabled"
    # "-Dmanpage=true"
    "-Drtaudio=enabled"
    "-Drtmidi=enabled"
    # some darwin specifc things
    "-Dalsa=${if stdenv.isLinux then "enabled" else "disabled"}"
    "-Dx11=${if stdenv.isLinux then "enabled" else "disabled"}"
    "-Dmanpage=${if stdenv.isDarwin then "false" else "true"}"
    # "-Duser_manual=true" # needs sphinx-intl
  ];

  NIX_LDFLAGS = ''
    -lfftw3_threads -lfftw3f_threads
  '';

  GUILE_AUTO_COMPILE = 0;

  dontStrip = true;

  postPatch = ''
    substituteInPlace meson.build \
      --replace-fail "'/usr/lib', '/usr/local/lib', '/opt/homebrew/lib'" "'${fftw}/lib'"

    ${lib.optionalString stdenv.isDarwin ''
      # macOS 'open' isn't available in Nix sandbox, but will be at runtime (hopefully)
      substituteInPlace meson.build \
        --replace-fail "find_program (open_dir_cmd)" "find_program (open_dir_cmd, required: false)"
    ''}

    chmod +x scripts/meson-post-install.sh
    patchShebangs ext/sh-manpage-completions/run.sh scripts/generic_guile_wrap.sh \
      scripts/meson-post-install.sh tools/check_have_unlimited_memlock.sh
  '';

  postInstall = lib.optionalString stdenv.isDarwin ''
    # HACK: Patch zrythm_launch after install for darwin
    substituteInPlace $out/bin/zrythm_launch \
      --replace-fail "ldconfig" "true" \
      --replace-fail "gsettings" "true"
  '';

  postFixup = lib.optionalString stdenv.isDarwin ''
    # Manually patch the rpath for the REAL binary executable,
    # which is renamed by wrapGAppsHook4.
    echo "Manually adding rpaths to $out/bin/.zrythm-wrapped"
    local lib_paths=$(echo ${lib.makeLibraryPath finalAttrs.buildInputs} | sed 's/:/ /g')

    for lib_path in $lib_paths; do
      install_name_tool -add_rpath $lib_path $out/bin/.zrythm-wrapped
    done
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix GSETTINGS_SCHEMA_DIR : "$out/share/gsettings-schemas/${finalAttrs.pname}-${finalAttrs.version}/glib-2.0/schemas/"
      --prefix XDG_DATA_DIRS : "$XDG_ICON_DIRS:${plasma5Packages.breeze-icons}/share"
    )
  '';

  meta = {
    homepage = "https://www.zrythm.org";
    description = "Automated and intuitive digital audio workstation";
    maintainers = with lib.maintainers; [
      tshaynik
      magnetophon
      astavie
      PowerUser64
    ];
    platforms = lib.platforms.unix;
    license = lib.licenses.agpl3Plus;
  };
})
