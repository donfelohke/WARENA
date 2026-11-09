;; warena-bare-metal-stage-a.scm
;; WARENA Stage A — Guix System + nonguix + Sway on external SSD
;; RESEARCH draft for HP EliteBook 835 G8 class hardware (2026-11-09)
;; NOT a LIVE deployment claim. Verify block devices before use.

(use-modules
 (gnu)
 (gnu system nss)
 (nongnu packages linux)
 (nongnu system linux-initrd))

(use-package-modules
 admin certs linux networking ssh tls wm terminals version-control)
(use-service-modules
 desktop networking ssh sound)

(operating-system
  (host-name "warena")
  (timezone "Africa/Nairobi")
  (locale "en_US.utf8")

  ;; Hardware enablement: nonguix linux + firmware for modern AMD laptop class
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  ;; Provisional: related HP AMD EliteBooks report amd_pmf battery/CPU quirks.
  ;; Validate on this G8 (dmesg | grep -i pmf). Remove if unneeded.
  (kernel-arguments
   (append
    (list "modprobe.blacklist=amd_pmf")
    %default-kernel-arguments))

  (keyboard-layout (keyboard-layout "us"))

  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets (list "/boot/efi"))
    (keyboard-layout keyboard-layout)))

  ;; EDIT after lsblk -f — example assumes external SSD /dev/sda
  (file-systems
   (cons*
    (file-system
      (mount-point "/boot/efi")
      (device "/dev/sda1")
      (type "vfat")
      (flags '(no-atime)))
    (file-system
      (mount-point "/")
      (device (file-system-label "warena-root"))
      (type "ext4")
      (flags '(no-atime)))
    %base-file-systems))

  (users
   (cons*
    (user-account
     (name "feloh")
     (comment "Don Feloh")
     (group "users")
     (home-directory "/home/feloh")
     (supplementary-groups
      '("wheel" "netdev" "audio" "video" "input" "lp")))
    %base-user-accounts))

  (packages
   (append
    (list
     sway foot bemenu
     git curl wget
     emacs-no-x-toolkit
     nss-certs
     openssh
     htop)
    %base-packages))

  (services
   (append
    (list
     (service openssh-service-type)
     (service network-manager-service-type)
     (service wpa-supplicant-service-type)
     (service elogind-service-type)
     (service pulseaudio-service-type))
    %base-services))

  (name-service-switch %mdns-host-lookup-nss))
