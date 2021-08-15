[
  (final: prev: {
    emacs-nox =
      let
	      myEmacsConfig = prev.writeText "default.el" ''
      ;; initialize package
      (require 'package)
      (package-initialize 'noactivate)

      (eval-when-compile
        (require 'use-package))

      ;; load theme
      (use-package beacon
        :init (beacon-mode 1))

      (use-package zerodark-theme
        :init (load-theme 'zerodark t) (zerodark-setup-modeline-format))
      
      ;; load some packages
      (use-package company
        :bind ("<C-tab>" . company-complete)
        :diminish company-mode
        :commands (company-mode global-company-mode)
        :defer 1
        :config
        (global-company-mode))

      (use-package counsel
        :commands (counsel-descbinds)
        :bind (([remap execute-extended-command] . counsel-M-x)
               ("C-x C-f" . counsel-find-file)
               ("C-c g" . counsel-git)
               ("C-c j" . counsel-git-grep)
               ("C-c k" . counsel-ag)
               ("C-x l" . counsel-locate)
               ("M-y" . counsel-yank-pop)))
        
      (use-package flycheck
        :defer 2
        :config (global-flycheck-mode))

      (use-package ivy
        :defer 1
        :bind (("C-c C-r" . ivy-resume)
               ("C-x C-b" . ivy-switch-buffer)
               :map ivy-minibuffer-map
               ("C-j" . ivy-call))
        :diminish ivy-mode
        :commands ivy-mode
        :config
        (ivy-mode 1))

      (use-package magit
        :defer
        :if (executable-find "git")
        :bind (("C-x g" . magit-status)
               ("C-x G" . magit-dispatch-popup))
        :init
        (setq magit-completing-read-function 'ivy-completing-read))
      '';
        emacsWithPackages =
          (final.emacsPackagesGen prev.emacs-nox).emacsWithPackages;
      in
        emacsWithPackages (epkgs:
          (with epkgs.melpaStablePackages; [
            (prev.runCommand "default.el" {} ''
         mkdir -p $out/share/emacs/site-lisp
         cp ${myEmacsConfig} $out/share/emacs/site-lisp/default.el
       '')
          ]) ++ (with epkgs.melpaPackages;
            [
              # zoom-frm # ; increase/decrease font size for all buffers %lt;C-x C-+>
            ]) ++ (with epkgs.elpaPackages; [ ]) ++ (with epkgs; [

              company # auto-complete

              s
              f

              counsel
              flycheck

              ivy
              projectile
              use-package


              undo-tree
              magit # ; Integrate git <C-x g>

              markdown-mode
              nix-mode
              nameless
              lsp-mode
              helm

              beacon
              # ;; themes
              # helm-themes # ; helm-themes
              # zenburn-theme # ; vim-them
              zerodark-theme # ; Nicolas' theme



              # (defadvice ac-common-setup (after give-yasnippet-highest-priority activate)
              # (setq ac-sources (delq 'ac-source-yasnippet ac-sources))
              # (add-to-list 'ac-sources 'ac-source-yasnippet))
            ]));
  })
]
