;; Add the melpa-stable package archive
(add-to-list 'package-archives
			 '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Bootstrap use-package
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; UI settings
(setq make-backup-files nil      ; Stop creating backup~ files
	  auto-save-default nil      ; Stop creating #autosave# files
	  custom-file "~/.emacs.d/custom.el"
	  inhibit-startup-message t  ; Don't show the splash screen
	  visible-bell t)            ; Flash when the bell rings

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

;; Evil mode
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-undo-system 'undo-fu
		evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package evil-leader
  :ensure t
  :after evil
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
	"e" 'counsel-find-file
	"b" 'switch-to-buffer
	"k" 'kill-buffer
	"op" 'neotree-toggle
	"me" 'org-export-dispatch)
  (global-evil-leader-mode 1))

(use-package evil-commentary
  :diminish
  :config
  (evil-commentary-mode 1))

;; Plugins
(use-package neotree)

(use-package fontaine
  :config
  (setq fontaine-presets
		'((regular
		   :default-height 140)
		  (small
		   :default-height 110)
		  (large
		   :default-weight semilight
		   :default-height 180
		   :bold-weight extrabold)
		  (extra-large
		   :default-weight semilight
		   :default-height 210
		   :line-spacing 5
		   :bold-weight ultrabold)
		  (t                        ; Our shared fallback properties
		   :default-family "Iosevka Term SS14")))
  (fontaine-set-preset 'regular))

(use-package org-modern
  :after org
  :hook (org-mode . org-modern-mode))
;; :config


(use-package async
  :ensure t
  :defer t
  :init
  (dired-async-mode 1))

(use-package repeat
  :defer 10
  :init
  (repeat-mode +1))

(use-package vterm
  :ensure t)


(use-package all-the-icons
  :if (display-graphic-p))

(use-package magit
  :bind (("C-x g" . magit-status)
		 ("C-x C-g" . magit-status)))

(use-package ranger
  :ensure t)


(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)))

(use-package which-key
  :config
  (which-key-mode))

(setq neo-theme 'icons)
(use-package pdf-tools)

(use-package woman)
(use-package popup)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(setq-default tab-width 4)
