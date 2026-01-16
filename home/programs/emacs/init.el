;;; --- ui ---
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(set-fringe-mode 10)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(savehist-mode 1)

;; --- env (nix) ---
(let ((my-paths '("/usr/bin" "/bin" "/usr/sbin" "/sbin"
                  "/run/current-system/sw/bin"
                  "/etc/profiles/per-user/pastaya/bin"
                  "/Users/pastaya/.cargo/bin"
                  "/Users/pastaya/.config/emacs/bin")))
  (setq exec-path (append my-paths exec-path))
  (setenv "PATH" (concat (mapconcat 'identity my-paths ":") ":" (getenv "PATH"))))

;; --- fuck swap files ---
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; --- fonts and faces ---
(set-face-attribute 'default nil :height 140)

;; set comment faces after theme loads
(add-hook 'after-init-hook
          (lambda ()
            (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
            (set-face-attribute 'font-lock-comment-delimiter-face nil :slant 'italic)))

;; --- completion (vertico/corfu/consult/marginalia) ---
(require 'vertico)
(vertico-mode 1)

(require 'marginalia)
(marginalia-mode 1)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles basic partial-completion))))

(require 'corfu)
(setq corfu-auto t
      corfu-auto-delay 0.1
      corfu-auto-prefix 1
      corfu-cycle t
      corfu-preselect 'prompt)
(global-corfu-mode 1)

(with-eval-after-load 'corfu
  (define-key corfu-map (kbd "RET") #'corfu-insert)
  (define-key corfu-map (kbd "C-n") #'corfu-next)
  (define-key corfu-map (kbd "C-p") #'corfu-previous))

(require 'kind-icon)
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)

(require 'cape)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-file)

(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.3)

(electric-pair-mode 1)

;; --- avy & embark ---
(require 'avy)
(global-set-key (kbd "M-j") #'avy-goto-char-timer)

(require 'embark)
(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "M-.") #'embark-dwim)

;; --- pastaya functions ---
(defun pastaya/project-compile (command)
  "run a compilation command from the project root"
  (let ((default-directory (if (project-current)
                               (project-root (project-current))
                             default-directory)))
    (compile command)))

(defun pastaya/cargo-build () 
  "build the current rust project with cargo"
  (interactive) (pastaya/project-compile "cargo b"))

(defun pastaya/cargo-test () 
  "run tests for the current rust project with cargo"
  (interactive) (pastaya/project-compile "cargo t"))

(defun pastaya/cargo-run () 
  "run the current rust project with cargo"
  (interactive) (pastaya/project-compile "cargo r"))

(defun pastaya/vterm ()
  "open or switch to vterm"
  (interactive)
  (if (get-buffer "*vterm*") (switch-to-buffer "*vterm*") (vterm)))

(defun pastaya/mail-refresh ()
  "refresh mail with mbsync + notmuch"
  (interactive)
  (shell-command "mbsync -a && notmuch new")
  (message "email refreshed!"))

(defun pastaya/resize-window-left (step) (interactive "p") (adjust-window-trailing-edge (selected-window) (- step) t))
(defun pastaya/resize-window-right (step) (interactive "p") (adjust-window-trailing-edge (selected-window) step t))
(defun pastaya/resize-window-down (step) (interactive "p") (adjust-window-trailing-edge (selected-window) step nil))
(defun pastaya/resize-window-up (step) (interactive "p") (adjust-window-trailing-edge (selected-window) (- step) nil))

;; --- search/jump & global remaps ---
(require 'consult)
(global-set-key (kbd "C-s") #'consult-line)
(global-set-key (kbd "M-y") #'consult-yank-pop)

;; replace standard buffer switching with consult
(global-set-key (kbd "C-x b") #'consult-buffer)     ;; switch to buffer
(global-set-key (kbd "C-x C-b") #'consult-buffer)   ;; list buffers

;; pulse the line when jumping
(defun pastaya/pulse-line (&rest _)
  (pulse-momentary-highlight-one-line (point)))
(advice-add 'consult-line :after #'pastaya/pulse-line)

;; --- leader key map ---
(defvar pastaya/dispatch-map (make-sparse-keymap))
(global-set-key (kbd "C-c") pastaya/dispatch-map)

;; buffers
(define-key pastaya/dispatch-map (kbd "b b") #'consult-buffer)
(define-key pastaya/dispatch-map (kbd "b k") #'kill-current-buffer)
(define-key pastaya/dispatch-map (kbd "b n") #'next-buffer)
(define-key pastaya/dispatch-map (kbd "b p") #'previous-buffer)

;; search/jump
(define-key pastaya/dispatch-map (kbd "s s") #'consult-line)
(define-key pastaya/dispatch-map (kbd "s r") #'consult-ripgrep)
(define-key pastaya/dispatch-map (kbd "j")   #'avy-goto-char-timer)

;; windows
(winner-mode 1)
(define-key pastaya/dispatch-map (kbd "w v") #'split-window-right)
(define-key pastaya/dispatch-map (kbd "w s") #'split-window-below)
(define-key pastaya/dispatch-map (kbd "w u") #'winner-undo)
(define-key pastaya/dispatch-map (kbd "w h") #'pastaya/resize-window-left)
(define-key pastaya/dispatch-map (kbd "w l") #'pastaya/resize-window-right)
(define-key pastaya/dispatch-map (kbd "w j") #'pastaya/resize-window-down)
(define-key pastaya/dispatch-map (kbd "w k") #'pastaya/resize-window-up)

;; rust
(define-key pastaya/dispatch-map (kbd "r b") #'pastaya/cargo-build)
(define-key pastaya/dispatch-map (kbd "r t") #'pastaya/cargo-test)
(define-key pastaya/dispatch-map (kbd "r r") #'pastaya/cargo-run)

;; git/mail/term
(define-key pastaya/dispatch-map (kbd "g g") #'magit-status)
(define-key pastaya/dispatch-map (kbd "m m") #'notmuch)
(define-key pastaya/dispatch-map (kbd "m r") #'pastaya/mail-refresh)
(define-key pastaya/dispatch-map (kbd "t t") #'pastaya/vterm)

;; --- git & langs ---
(require 'magit)
(require 'magit-delta)
(magit-delta-mode)

(require 'eglot)
(setq eglot-ignored-server-capabilities nil)

(require 'treesit-auto)
(global-treesit-auto-mode)
(setq major-mode-remap-alist
      '((java-mode . java-ts-mode)
        (rust-mode . rust-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (js-json-mode . json-ts-mode)
        (json-mode . json-ts-mode)
        (css-mode . css-ts-mode)
        (html-mode . html-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (csharp-mode . csharp-ts-mode)
        (go-mode . go-ts-mode)
        (python-mode . python-ts-mode)))

(require 'envrc)
(envrc-global-mode)

;; --- hooks ---
(require 'ansi-color)
(defun pastaya/colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))

(add-hook 'rust-ts-mode-hook 'eglot-ensure)
(add-hook 'compilation-filter-hook 'pastaya/colorize-compilation-buffer)

;; --- org mode ---
(setq org-log-done 'time
      org-insert-heading-respect-content t
      org-pretty-entities t)
;; --- elcord ---
(require 'elcord)
(elcord-mode)
;; TODO: customize it
