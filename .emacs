(setq load-path (append (list "~/.emacs.d"
                              "~/.emacs.d/yasnippet"
                              "~/.emacs.d/evil"
                              "~/.emacs.d/emacs-async"
                              "~/.emacs.d/emacs-multi"
                              "~/.emacs.d/helm"
                              )
                        load-path))

(require 'helm-config)
(require 'wbp)
(require 'music)
(require 'yasnippet)
(require 'evil)
(require 'idle-highlight-mode)
(require 'elisp-slime-nav)
(setq yas-snippet-dirs (list "~/.emacs.d/yasnippet/snippets"))

(evil-mode 1)
(yas-global-mode 1)
(show-paren-mode 1)
(setq show-paren-style 'expression)
(global-hl-line-mode 1)
(global-linum-mode 1)
(electric-pair-mode 1)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'remove-elisp-lint-on-save)
(add-hook 'emacs-lisp-mode-hook 'idle-highlight)
(add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)

;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
    (lambda ()
      (let ((color (cond ((minibufferp) default-color)
                         ((evil-insert-state-p) '("#ff6000" . "#000fff"))
                         ((evil-emacs-state-p)  '("#444488" . "#6fffff"))
                         ((buffer-modified-p)   '("#006fa0" . "#0fffff"))
                         (t default-color))))
        (set-face-background 'mode-line (car color))
        (set-face-foreground 'mode-line (cdr color))))))

;; clean up elisp lint
(defun remove-elisp-lint-on-save ()
  "On saving an elisp file, likely the .elc, .el~ is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c")))
              (if (file-exists-p (concat buffer-file-name "~"))
                  (delete-file (concat buffer-file-name "~"))))))

;; change other highlight background/forebround color
(set-face-background 'hl-line "ivory")
(set-face-foreground 'hl-line nil)
(set-face-foreground 'idle-highlight "magenta")
(set-face-background 'idle-highlight "OliveDrab1")
(set-face-background 'region "LightCyan1")
(set-face-background 'show-paren-match "LavenderBlush1")
(set-face-attribute 'show-paren-match nil :slant 'italic)

;; set tab
(setq-default indent-tabs-mode nil
              tab-width 4
              indent-line-function 'insert-tab)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path (quote ("/usr/bin"
                     "/bin"
                     "/usr/sbin"
                     "/sbin"
                     "/Applications/Emacs.app/Contents/MacOS/libexec"
                     "/Applications/Emacs.app/Contents/MacOS/bin"
                     "/usr/local/smlnj/bin"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 )

