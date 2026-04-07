(setq eglot-autoshutdown t)

(setq user-full-name "Joshua Yeung"
      user-mail-address "hi@joshuaspiral.xyz")

(setq doom-theme 'doom-gruvbox
      doom-font (font-spec :family "Iosevka Nerd Font" :size 18))

(setq display-line-numbers-type 'relative)
(add-to-list 'default-frame-alist '(alpha-background . 85))

(setq vterm-shell (executable-find "fish"))

(setq org-directory "~/org/")
(setq org-agenda-hide-tags-regexp "RECURRING")

(after! org
  (plist-put org-format-latex-options :scale 1.5))
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

;; Hugo
(after! org
  (require 'ox-hugo))

(put 'org-hugo-auto-export-mode 'safe-local-variable #'booleanp)

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

(setq-hook! 'latex-mode-hook +format-with 'latexindent)

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

(with-eval-after-load 'eglot
  ;; Configure Pyright for strict type checking
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pyright-langserver" "--stdio")))

  (setq-default eglot-workspace-configuration
                '((:python . (:analysis (:typeCheckingMode "strict"
                                         :autoSearchPaths t
                                         :useLibraryCodeForTypes t))))))
(setq eglot-autoshutdown t)

(setq-hook! 'python-mode-hook
  +format-with 'black
  +format-with-lsp nil)

(setq-hook! '(latex-mode-hook LaTeX-mode-hook) +format-with 'latexindent)

(after! org
  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file+headline "~/org/inbox.org" "Unsorted Capture")
           "* %?\n%U\n%i" :prepend t :empty-lines 1)
          ("t" "Todo" entry
           (file+headline "~/org/to     dos.org" "Tasks")
           "* TODO %?\n%U" :prepend t :empty-lines 1))))
