;; Place your private configuration here. Remember, you do not need to run 'doom sync' after modifying this file!

;; Set frame opacity
(doom/set-frame-opacity 95)

;; Set user information
(setq user-full-name "Joshua Yeung"
      user-mail-address "najoshua.yeung@gmail.com")

;; Set fonts
(setq doom-font (font-spec :family "Iosevka Term SS14" :size 20 :weight 'light)
      doom-big-font (font-spec :family "Iosevka Term SS14" :size 36)
      doom-variable-pitch-font (font-spec :family "Fira Sans"))

;; Set theme
;; (setq doom-theme 'doom-gruvbox)
(load-theme 'modus-operandi)

;; Set line numbers
(setq display-line-numbers-type t)

;; Set org directory
(setq org-directory "~/org/")

(require 'react-snippets)
