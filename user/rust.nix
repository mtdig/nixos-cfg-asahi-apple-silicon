{ config, pkgs, pkgs-esp-idf, ... }:

let
  rustToolchain = pkgs.rust-bin.stable.latest.default.override {
    targets = [
      "x86_64-unknown-linux-gnu"
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "riscv32imc-unknown-none-elf"  # ESP32-C3
      "riscv32imac-unknown-none-elf" # ESP32-C6
    ];
  };
in {
  environment.systemPackages = with pkgs; [
    # Rust toolchain with ESP RISC-V targets
    rustToolchain
    gcc

    # aarch64 (Raspberry Pi) cross-compilation support
    pkgsCross.aarch64-multiplatform.stdenv.cc

    # ESP-IDF (C/C++ framework) - includes toolchains for C3 and C6
    pkgs-esp-idf.esp-idf-full

    # ESP Rust tools
    espflash           # serial flasher
    espup              # toolchain installer (for Xtensa if ever needed)
    esptool            # low-level flash/read utility
    cargo-generate     # project scaffolding from templates
    esp-generate       # esp-rs project generator (replaces esp-template)
    ldproxy            # linker proxy for esp-idf-sys builds
    probe-rs-tools     # on-chip debugging & flashing
  ];

  # Set cross-linker for aarch64 Rust builds
  environment.variables.CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = "aarch64-unknown-linux-gnu-gcc";

  # udev rules for Espressif USB JTAG/serial devices
  services.udev.extraRules = ''
    # Espressif USB JTAG/serial debug unit (ESP32-C3, ESP32-C6, ESP32-S3, etc.)
    ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="0666", GROUP="dialout"
    # Espressif USB bridge
    ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1002", MODE="0666", GROUP="dialout"
    # CP210x (common ESP32 dev board USB-UART)
    ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE="0666", GROUP="dialout"
    # FTDI (common ESP32 dev board USB-UART)
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0666", GROUP="dialout"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0666", GROUP="dialout"
    # CH340/CH341 (common cheap ESP32 dev board USB-UART)
    ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE="0666", GROUP="dialout"
    ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55d4", MODE="0666", GROUP="dialout"
  '';
}
