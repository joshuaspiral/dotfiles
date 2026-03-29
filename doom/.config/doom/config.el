(setq user-full-name "Joshua Yeung"
      user-mail-address "hi@joshuaspiral.xyz")

(setq doom-theme 'doom-gruvbox
      doom-font (font-spec :family "Geist Mono Nerd Font" :size 18))

(setq display-line-numbers-type 'relative)
(add-to-list 'default-frame-alist '(alpha-background . 85))

(setq vterm-shell (executable-find "fish"))

(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/agenda/" "\\.org$"))

(with-eval-after-load 'org
  (setq org-hide-emphasis-markers t
        org-startup-indented t
        org-pretty-entities t
        org-preview-latex-default-process 'dvisvgm
        org-src-fontify-natively t
        org-src-tab-acts-natively t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (C      . t)
     (shell  . t)
     (latex  . t))))

(setq +latex-viewers '(zathura))

(with-eval-after-load 'latex
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-save-query nil))

(add-hook! 'LaTeX-mode-hook
  (defun my/latex-auto-compile ()
    (add-hook 'after-save-hook
              (lambda ()
                (TeX-command-run-all nil))
              nil t)))

(require 'epa)
(setenv "GPG_AGENT_INFO" nil)
(setq epa-file-encrypt-to '("hi@joshuaspiral.xyz"))

(defun my/open-encrypted-scratch ()
  "Open a temporary buffer that saves as an encrypted GPG file."
  (interactive)
  (let ((file (expand-file-name (format "scratch-%s.txt.gpg" (format-time-string "%Y%m%d%H%M%S")) "~/.gnupg/secure-notes/")))
    (make-directory (file-name-directory file) t)
    (find-file file)
    (insert "# Secure scratch pad. Saving will encrypt via EPA.\n\n")))

(map! :leader
      :prefix ("z" . "encryption")
      :desc "Encrypt file"   "f" #'epa-encrypt-file
      :desc "Decrypt file"   "d" #'epa-decrypt-file
      :desc "Encrypt region" "r" #'epa-encrypt-region
      :desc "Decrypt region" "R" #'epa-decrypt-region
      :desc "Secure Scratch" "s" #'my/open-encrypted-scratch)

(defun my/doom-sync-and-reload ()
  "Run doom sync asynchronously, then reload Doom configuration."
  (interactive)
  (message "Running doom sync...")
  (set-process-sentinel
   (start-process "doom-sync" "*doom-sync*" (expand-file-name "bin/doom" doom-emacs-dir) "sync")
   (lambda (process event)
     (when (string= event "finished\n")
       (message "Sync complete. Reloading...")
       (doom/reload)))))

(map! :leader
      :desc "Sync and reload Doom"
      "h R" #'my/doom-sync-and-reload)
