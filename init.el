;; init.el - Emacs para Clojure & PHP

;; -------------------------
;; Configurações básicas
;; -------------------------
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil
      ring-bell-function 'ignore
      use-file-dialog nil
      use-dialog-box nil
      initial-major-mode 'fundamental-mode
      gc-cons-threshold (* 50 1000 1000))

;; UI limpa
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Parênteses
(electric-pair-mode 1)
(show-paren-mode 1)

;; -------------------------
;; Gerenciamento de pacotes
;; -------------------------
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; -------------------------
;; Evil mode
;; -------------------------
(setq evil-want-keybinding nil
      evil-want-C-u-scroll t
      evil-want-C-d-scroll t)

(use-package evil
  :init (setq evil-want-integration t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "<escape>") 'keyboard-quit)
  (define-key evil-visual-state-map (kbd "<escape>") 'keyboard-quit))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;; -------------------------
;; Leader Key
;; -------------------------
(use-package general
  :config
  (general-create-definer my-leader-def
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC"))

;; -------------------------
;; Interface
;; -------------------------
(use-package doom-themes
  :config (load-theme 'doom-one t))

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "))

(use-package counsel
  :after ivy
  :config (counsel-mode 1))

(use-package swiper
  :after ivy)

;; -------------------------
;; LSP com Eglot
;; -------------------------
(use-package eglot
  :hook ((php-mode . eglot-ensure)
         (js-mode  . eglot-ensure))
  :config
  ;; clojure-lsp registrado manualmente
  (add-to-list 'eglot-server-programs
               '(clojure-mode . ("clojure-lsp")))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'eglot-format-buffer -10 t))))

;; -------------------------
;; PHP
;; -------------------------
(use-package php-mode
  :hook (php-mode . eglot-ensure)
  :config
  (setq php-mode-coding-style 'psr2))

(use-package phpunit
  :after php-mode)

;; -------------------------
;; Clojure
;; -------------------------
(use-package clojure-mode
  :hook (clojure-mode . eglot-ensure))

;; CIDER - REPL interativo
(use-package cider
  :after clojure-mode
  :config
  ;; REPL geral
  (setq cider-repl-display-help-banner nil
        cider-repl-use-pretty-printing t
        cider-repl-buffer-size-limit 100000
        ;; Salvar arquivo antes de carregar no REPL
        cider-save-file-on-load t
        ;; Namespace abreviado no prompt
        cider-repl-prompt-function 'cider-repl-prompt-abbreviated
        ;; REPL abre ao lado, não sobrepõe o código
        cider-repl-display-in-current-window nil
        cider-repl-pop-to-buffer-on-connect 'display-only
        ;; Erros
        cider-show-error-buffer t
        cider-auto-select-error-buffer t))

;; Edição estrutural de parênteses (essencial para Clojure)
(use-package paredit
  :hook ((clojure-mode    . paredit-mode)
         (cider-repl-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode))
  :config
  (with-eval-after-load 'evil
    (add-hook 'paredit-mode-hook
              (lambda ()
                (define-key evil-insert-state-local-map (kbd "DEL") 'paredit-backward-delete)
                (define-key evil-insert-state-local-map (kbd ")") 'paredit-close-round)))))

;; Destaque de parênteses por nível
(use-package rainbow-delimiters
  :hook ((clojure-mode    . rainbow-delimiters-mode)
         (emacs-lisp-mode . rainbow-delimiters-mode)))

;; -------------------------
;; Treesit
;; -------------------------
(use-package treesit-auto
  :config (global-treesit-auto-mode))

;; -------------------------
;; File Explorer
;; -------------------------
(use-package treemacs
  :defer t
  :config (setq treemacs-width 30))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-completion-system 'ivy))

(use-package treemacs-projectile
  :after (treemacs projectile))

;; -------------------------
;; Terminal (vterm)
;; -------------------------
(use-package vterm
  :config
  (setq vterm-max-scrollback 10000
        vterm-shell "/bin/bash")
  (add-hook 'vterm-mode-hook
            (lambda () (display-line-numbers-mode -1))))

(defun my/toggle-vterm ()
  "Abre/fecha vterm na parte inferior."
  (interactive)
  (let ((buf (get-buffer "*vterm*")))
    (if (and buf (get-buffer-window buf))
        (delete-window (get-buffer-window buf))
      (progn
        (split-window-below -15)
        (other-window 1)
        (if buf
            (switch-to-buffer buf)
          (vterm))))))

;; -------------------------
;; Arquivos recentes
;; -------------------------
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; -------------------------
;; Keybindings
;; -------------------------
(my-leader-def
  ;; Arquivos
  "f"   '(:ignore t :which-key "arquivos")
  "ff"  '(counsel-find-file :which-key "abrir arquivo")
  "fs"  '(save-buffer :which-key "salvar")
  "fr"  '(counsel-recentf :which-key "recentes")

  ;; Explorer
  "e"   '(treemacs :which-key "explorer")

  ;; Buffers
  "b"   '(:ignore t :which-key "buffers")
  "bb"  '(ivy-switch-buffer :which-key "trocar")
  "bd"  '(kill-current-buffer :which-key "fechar")

  ;; Janelas
  "w"   '(:ignore t :which-key "janelas")
  "wv"  '(split-window-right :which-key "vertical")
  "ws"  '(split-window-below :which-key "horizontal")
  "wd"  '(delete-window :which-key "fechar")
  "wo"  '(delete-other-windows :which-key "fechar outras")

  ;; Terminal
  "t"   '(:ignore t :which-key "terminal")
  "tt"  '(my/toggle-vterm :which-key "toggle vterm")

  ;; Search
  "s"   '(:ignore t :which-key "pesquisar")
  "ss"  '(swiper :which-key "no buffer")

  ;; LSP (Eglot)
  "l"   '(:ignore t :which-key "lsp")
  "lr"  '(eglot-rename :which-key "renomear")
  "lf"  '(eglot-format :which-key "formatar")
  "la"  '(eglot-code-actions :which-key "code actions")
  "ld"  '(xref-find-definitions :which-key "definição")

  ;; Clojure / CIDER
  "c"   '(:ignore t :which-key "clojure")
  "cj"  '(cider-jack-in :which-key "jack-in (lein/deps)")
  "cJ"  '(cider-jack-in-cljs :which-key "jack-in cljs")
  "cc"  '(cider-connect :which-key "conectar REPL")
  "cq"  '(cider-quit :which-key "fechar REPL")
  "ce"  '(cider-eval-last-sexp :which-key "eval sexp")
  "cE"  '(cider-eval-buffer :which-key "eval buffer")
  "cf"  '(cider-eval-defun-at-point :which-key "eval função")
  "cr"  '(cider-switch-to-repl-buffer :which-key "ir pro REPL")
  "ci"  '(cider-inspect-last-result :which-key "inspecionar resultado")
  "cp"  '(cider-pprint-eval-last-sexp :which-key "pretty print eval")
  "ct"  '(cider-test-run-test :which-key "rodar teste")
  "cT"  '(cider-test-run-ns-tests :which-key "rodar todos testes")
  "cd"  '(cider-doc :which-key "documentação")
  "cn"  '(cider-repl-set-ns :which-key "setar namespace")

  ;; PHP
  "h"   '(:ignore t :which-key "php")
  "ht"  '(phpunit-current-test :which-key "rodar teste")
  "hT"  '(phpunit-current-class :which-key "rodar classe")

  ;; Projeto
  "p"   '(:ignore t :which-key "projeto")
  "pf"  '(projectile-find-file :which-key "arquivo")
  "pp"  '(projectile-switch-project :which-key "trocar projeto")

  ;; Quit
  "q"   '(:ignore t :which-key "sair")
  "qq"  '(save-buffers-kill-terminal :which-key "salvar e sair"))

;; -------------------------
;; Startup limpo
;; -------------------------
(defun my/clean-startup ()
  (when (get-buffer "*scratch*")
    (with-current-buffer "*scratch*"
      (erase-buffer))))

(add-hook 'emacs-startup-hook 'my/clean-startup)

(message "🚀 Emacs pronto — Clojure & PHP!")

(provide 'init)
;;; init.el ends here
