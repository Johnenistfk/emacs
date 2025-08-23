;; init.el - Configuração Emacs Minimalista Completa

;; init.el - Configuração Emacs Minimalista e Limpa

;; -------------------------
;; Configurações básicas - início limpo
;; -------------------------
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil
      ring-bell-function 'ignore
      ;; Não abrir diálogos automaticamente
      use-file-dialog nil
      use-dialog-box nil
      ;; Buffer inicial vazio
      initial-major-mode 'fundamental-mode)

;; UI limpa
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)

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
;; Evil mode completo
;; -------------------------
(setq evil-want-keybinding nil
      evil-want-C-u-scroll t
      evil-want-C-d-scroll t)

(use-package evil
  :init
  (setq evil-want-integration t)
  :config
  (evil-mode 1)
  ;; ESC cancela tudo
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "<escape>") 'keyboard-quit)
  (define-key evil-visual-state-map (kbd "<escape>") 'keyboard-quit))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; -------------------------
;; Sistema de Leader Key
;; -------------------------
(use-package general
  :config
  (general-create-definer my-leader-def
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC"))

;; -------------------------
;; Interface e completions
;; -------------------------
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

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
  :config
  (counsel-mode 1))

(use-package swiper
  :after ivy)

;; -------------------------
;; LSP com Eglot
;; -------------------------
(use-package eglot
  :hook ((c-mode          . eglot-ensure)
         (c++-mode        . eglot-ensure)
         (java-mode       . eglot-ensure)
         (js-mode         . eglot-ensure)
         (php-mode        . eglot-ensure))
  :config
  ;; Formatação automática
  (add-hook 'eglot-managed-mode-hook
            (lambda () 
              (add-hook 'before-save-hook #'eglot-format-buffer -10 t))))

;; -------------------------
;; Modos de linguagens
;; -------------------------
(use-package php-mode)
(use-package typescript-mode)

;; -------------------------
;; File Explorer
;; -------------------------
(use-package treemacs
  :defer t
  :config
  (setq treemacs-width 30))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-completion-system 'ivy))

(use-package treemacs-projectile
  :after (treemacs projectile))

;; -------------------------
;; Terminal
;; -------------------------
(defun my/toggle-terminal ()
  "Abre/fecha terminal na parte inferior."
  (interactive)
  (let ((term-buffer (get-buffer "*ansi-term*")))
    (if (and term-buffer (get-buffer-window term-buffer))
        (delete-window (get-buffer-window term-buffer))
      (progn
        (split-window-below -15)
        (other-window 1)
        (if term-buffer
            (switch-to-buffer term-buffer)
          (ansi-term (getenv "SHELL")))))))

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
  "fs"  '(save-buffer :which-key "salvar arquivo")
  "fr"  '(counsel-recentf :which-key "arquivos recentes")

  ;; Explorer - só abrir quando solicitado
  "e"   '(treemacs :which-key "abrir/fechar explorer")

  ;; Buffers
  "b"   '(:ignore t :which-key "buffers")
  "bb"  '(ivy-switch-buffer :which-key "trocar buffer")
  "bd"  '(kill-current-buffer :which-key "fechar buffer")

  ;; Janelas
  "w"   '(:ignore t :which-key "janelas")
  "wv"  '(split-window-right :which-key "dividir vertical")
  "ws"  '(split-window-below :which-key "dividir horizontal")
  "wd"  '(delete-window :which-key "fechar janela")
  "wo"  '(delete-other-windows :which-key "fechar outras")

  ;; Terminal
  "t"   '(:ignore t :which-key "terminal")
  "tt"  '(my/toggle-terminal :which-key "toggle terminal")

  ;; Search
  "s"   '(:ignore t :which-key "pesquisar")
  "ss"  '(swiper :which-key "buscar no buffer")

  ;; LSP
  "l"   '(:ignore t :which-key "lsp")
  "lr"  '(eglot-rename :which-key "renomear")
  "lf"  '(eglot-format :which-key "formatar")
  "la"  '(eglot-code-actions :which-key "code actions")
  "ld"  '(xref-find-definitions :which-key "ir para definição")

  ;; Projectile
  "p"   '(:ignore t :which-key "projeto")
  "pf"  '(projectile-find-file :which-key "arquivo no projeto")

  ;; Quit
  "q"   '(:ignore t :which-key "sair")
  "qq"  '(save-buffers-kill-terminal :which-key "salvar e sair"))

;; -------------------------
;; Desabilitar atalhos nativos
;; -------------------------
(dolist (key '("C-x" "C-c" "C-h" "C-s" "C-v" "C-y" "C-w"))
  (global-unset-key (kbd key)))

;; -------------------------
;; Início limpo - apenas buffer vazio
;; -------------------------
(defun my/clean-startup ()
  "Garante um início completamente limpo."
  (when (get-buffer "*scratch*")
    (with-current-buffer "*scratch*"
      (erase-buffer))))

;; Executar limpeza após inicialização
(add-hook 'emacs-startup-hook 'my/clean-startup)

;; Configurações de performance
(setq gc-cons-threshold (* 50 1000 1000))

(message "🚀 Emacs configurado com sucesso!")

(provide 'init)
;;; init.el ends here
