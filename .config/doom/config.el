(setq truncate-string-ellipsis "...")
(setq-default display-line-numbers-width  4
              c-basic-offset              4
              ediff-forward-word-function 'forward-char
              tab-width                   4
              line-spacing                0.0
              truncate-lines              t
              indent-tabs-mode            nil
              completion-ignore-case      t
              indent-line-function        'insert-tab
              history-length              100
              scroll-margin               7
              pixel-scroll-precision-mode t)


(setq fancy-splash-image "~/.config/doom/banners/ue-colorful.png")
(setq display-line-numbers-type t)
(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-big-font (font-spec :family "Cascadia Code" :size 24))


;; (setq catppuccin-flavor 'mocha)
;; (add-to-list 'custom-theme-load-path "~/.config/doom/themes")
;; (load-theme 'catppuccin t)
;; (catppuccin-set-color 'base "#000000")
;; (catppuccin-reload)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
;; (use-package kaolin-themes
;;   :config
;;   (setq kaolin-themes-italic-comments t)
;;   (setq kaolin-themes-hl-line-colored t)
;;   (setq kaolin-themes-distinct-company-scrollbar t)
;;   (setq kaolin-themes-git-gutter-solid t)
;;   ;; (setq kaolin-ocean-alt-bg t)
;;   (load-theme 'kaolin-ocean t)
;;   (kaolin-treemacs-theme))
(use-package autothemer
  :config
  ;; (load-theme 'catppuccin-mocha t)
  (load-theme 'kanagawa t))



(use-package treemacs
  :config
  (treemacs-load-theme "Default")
  (treemacs-indent-guide-mode)
  (treemacs-git-mode 'deferred))


(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(require 'org)
(after! org
  (setq org-directory "~/org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
        '(("google" . "http://www.google.com/search?q=")
          ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
          ("wiki" . "https://en.wikipedia.org/wiki/"))))

(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 5000)
(setq eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))
(map! :leader
      :desc "Eshell"                 "e s" #'eshell
      :desc "Eshell popup toggle"    "e t" #'+eshell/toggle
      :desc "Counsel eshell history" "e h" #'counsel-esh-history
      :desc "Vterm popup toggle"     "v t" #'+vterm/toggle)

(map! :leader :desc "Format" "f m" #'format-all-buffer)

(defvar +vertico-current-arrow t)

(cl-defmethod vertico--format-candidate :around
  (cand prefix suffix index start &context ((and +vertico-current-arrow
                                                 (not (bound-and-true-p vertico-flat-mode)))
                                            (eql t)))
  (setq cand (cl-call-next-method cand prefix suffix index start))
  (if (bound-and-true-p vertico-grid-mode)
      (if (= vertico--index index)
          (concat #("➜" 0 1 (face vertico-current)) cand)
        (concat #("_" 0 1 (display " ")) cand))
    (if (= vertico--index index)
        (concat
         #(" " 0 1 (display (left-fringe right-triangle vertico-current)))
         cand)
      cand)))


(define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
(define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
(define-key evil-outer-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj ("conditional.outer" "loop.outer")))
(define-key evil-inner-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj ("conditional.inner" "loop.inner")))
(define-key evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "parameter.outer"))
(define-key evil-inner-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "parameter.inner"))
(define-key evil-normal-state-map (kbd "]f") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer")))
(define-key evil-normal-state-map (kbd "[f") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer" t)))
(define-key evil-normal-state-map (kbd "]F") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer" nil t)))
(define-key evil-normal-state-map (kbd "[F") (lambda ()
                                               (interactive)
                                               (evil-textobj-tree-sitter-goto-textobj "function.outer" t t)))

(setq which-key-idle-delay 0.1)

(setq lsp-ui-doc-show-with-mouse t)
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-ui-sideline-show-code-actions t)
(map! :leader
      :desc "find definition"   "c d" #'lsp-ui-peek-find-definitions
      :desc "find reference"    "c i" #'lsp-ui-peek-find-references)

(use-package company-box
  :config
  (setq company-box-icons-alist 'company-box-icons-images))
