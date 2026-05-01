;; -- make emacs FASTER --
(setopt read-process-output-max (* 1024 1024))
(setopt gc-cons-threshold (* 50 1024 1024))

;; --- ui ---
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(set-fringe-mode 2)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(savehist-mode 1)

;; --- env (nix) ---
;; remove ts
(let ((my-paths '("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/bin"
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
(set-face-attribute 'default nil :height 120)
(add-hook 'after-init-hook
          (lambda ()
            (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
            (set-face-attribute 'font-lock-comment-delimiter-face nil :slant 'italic)
	    (set-face-attribute 'font-lock-keyword-face nil :slant 'italic)))

;; --- completion (vertico/corfu/consult/marginalia) ---
(require 'vertico)
(vertico-mode 1)

(require 'marginalia)
(marginalia-mode 1)

(require 'orderless)
(setopt completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles basic partial-completion))
				      (eglot (styles basic))
				      (eglot-capf (styles basic))))

(require 'corfu)
(setopt corfu-auto t
      corfu-auto-delay 0.1
      corfu-auto-prefix 1
      corfu-cycle t
      corfu-preselect 'first
      corfu-quit-at-boundary t)
(global-corfu-mode 1)

;; ;; --- completion (vertico/corfu/consult/marginalia) ---
;; ;; i really hate how suggestions are hidden to me sometimes (because it guessed some random function that i dont want
;; ;; think thats orderless fault
;; (require 'vertico)
;; (vertico-mode 1)

;; (require 'marginalia)
;; (marginalia-mode 1)

;; (require 'orderless)
;; (setq completion-styles '(orderless basic)
;;       completion-category-defaults nil
;;       completion-category-overrides '((file (styles basic partial-completion))))

;; (require 'corfu)
;; (setq corfu-auto t
;;       corfu-auto-delay 0.1
;;       corfu-auto-prefix 1
;;       corfu-cycle t
;;       corfu-preselect 'prompt)
;; (global-corfu-mode 1)

;; (corfu-popupinfo-mode)

;; (with-eval-after-load 'corfu
;;   (define-key corfu-map (kbd "RET") #'corfu-insert)
;;   (define-key corfu-map (kbd "C-n") #'corfu-next)
;;   (define-key corfu-map (kbd "C-p") #'corfu-previous))

(require 'kind-icon)
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)

(require 'cape)
(add-to-list 'completion-at-point-functions #'cape-dabbrev t)
(add-to-list 'completion-at-point-functions #'cape-file t)
;; (add-to-list 'completion-at-point-functions #'cape-keyword)

(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.1)

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

(defun pastaya/mail-refresh ()
  "refresh mail with mbsync + notmuch"
  (interactive)
  (shell-command "mbsync -a && notmuch new")
  (message "email refreshed!"))

(defun pastaya/resize-window-left (step)
  (interactive "p")
  (adjust-window-trailing-edge (selected-window) (- step) t))

(defun pastaya/resize-window-right (step)
  (interactive "p")
  (adjust-window-trailing-edge (selected-window) step t))

(defun pastaya/resize-window-down (step)
  (interactive "p")
   (adjust-window-trailing-edge (selected-window) step nil))

(defun pastaya/resize-window-up (step)
  (interactive "p")
  (adjust-window-trailing-edge (selected-window) (- step) nil))

;; --- search/jump & global remaps ---
(require 'consult)
; probably more but whatever
(global-set-key (kbd "C-s") #'consult-line)
(global-set-key (kbd "M-y") #'consult-yank-pop)
(global-set-key (kbd "M-g M-g") #'consult-goto-line)

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

;; search/jump
(define-key pastaya/dispatch-map (kbd "s s") #'consult-line)
(define-key pastaya/dispatch-map (kbd "s r") #'consult-ripgrep)
(define-key pastaya/dispatch-map (kbd "s e") #'consult-flymake)
(define-key pastaya/dispatch-map (kbd "j")   #'avy-goto-char-timer)

;; windows
(winner-mode 1)
(define-key pastaya/dispatch-map (kbd "w h") #'pastaya/resize-window-left)
(define-key pastaya/dispatch-map (kbd "w l") #'pastaya/resize-window-right)
(define-key pastaya/dispatch-map (kbd "w j") #'pastaya/resize-window-down)
(define-key pastaya/dispatch-map (kbd "w k") #'pastaya/resize-window-up)

;; rust
(define-key pastaya/dispatch-map (kbd "r b") #'pastaya/cargo-build)
(define-key pastaya/dispatch-map (kbd "r t") #'pastaya/cargo-test)
(define-key pastaya/dispatch-map (kbd "r r") #'pastaya/cargo-run)

(define-key pastaya/dispatch-map (kbd "m m") #'notmuch)
(define-key pastaya/dispatch-map (kbd "m r") #'pastaya/mail-refresh)
(define-key pastaya/dispatch-map (kbd "t") #'vterm)

;; --- vterm ---
(defun pastaya/term-hook ()
  (display-line-numbers-mode -1)
  (corfu-mode -1)
  (electric-indent-mode -1)
  (electric-pair-mode -1)
  (setq-local read-process-output-max (* 1024 1024)))

(add-hook 'vterm-mode-hook #'pastaya/term-hook)

;; --- git & langs ---
(require 'magit)
(require 'magit-delta)
(magit-delta-mode)

(require 'eglot)
; lsp for csharp has headaches with electric-pair-mode
(add-hook 'csharp-ts-mode-hook
	  (lambda ()
	    (setq-default eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider))))

(add-to-list 'eglot-server-programs '(haskell-mode "haskell-language-server-wrapper" "--lsp"))
(add-to-list 'eglot-server-programs '(csharp-ts-mode "csharp-ls"))
;; (add-to-list 'eglot-server-programs '(fsharp-mode "fsautocomplete" "--adaptive-lsp-server-enabled"))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (setq-local eldoc-idle-delay 0)
            (add-hook 'eldoc-documentation-functions #'eglot-hover-eldoc-function 10 t)
	    (setq-local eldoc-echo-area-display-truncation-message nil)))

(require 'treesit-auto)
(global-treesit-auto-mode)
; not that ill use most of them anyways...
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

(setopt treesit-font-lock-level 4)

(require 'envrc)
(envrc-global-mode)

;; --- hooks ---
(require 'ansi-color)
(defun pastaya/colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))

(add-hook 'compilation-filter-hook 'pastaya/colorize-compilation-buffer)

;; --- org mode ---
(setq org-log-done 'time
      org-insert-heading-respect-content t
      org-pretty-entities t)

;; --- magit ---
(require 'magit)
(setopt magit-define-global-key-bindings 'recommended)

;; --- misc ---
(setopt display-line-numbers 'relative)
(editorconfig-mode 1)

;; --- snippets ---
(global-set-key (kbd "M-e") #'yas-expand)
(yas-global-mode)

;; --- paredit ---
(require 'paredit)
(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "RET") 'paredit-newline)
     (define-key paredit-mode-map (kbd "C-j") 'paredit-newline)))

(defun pastaya/enable-paredit ()
  (setq-local electric-pair-mode nil)
  (setq-local electric-indent-mode nil)
  (paredit-mode +1))

(defun pastaya/enable-paredit-minibuffer ()
  (pastaya/enable-paredit)
  (local-set-key (kbd "RET") 'exit-minibuffer))

; clojure-mode dervies from lisp-mode
(dolist (hook '(lisp-mode-hook
		emacs-lisp-mode-hook
		scheme-mode-hook
		lisp-interaction-mode-hook
		eval-expression-minibuffer-setup-hook
		clojure-mode-hook))
  (add-hook hook #'pastaya/enable-paredit t))

(add-hook 'eval-expression-minibuffer-setup-hook #'pastaya/enable-paredit-minibuffer t)
