;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-gruvbox)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Quality of Life Key Binds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! "C-k" 'scroll-down-command
      "C-j" 'scroll-up-command)
(map! :map evil-normal-state-map "g b" #'better-jumper-jump-backward)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rebind insert mode movement keys for small edits and movements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :i "M-h" 'backward-char
      :i "M-j" 'next-line
      :i "M-k" 'previous-line
      :i "M-l" 'forward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Treemacs - Neotree but better
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! "<f8>" #'treemacs)
(map! :map treemacs-mode-map
      :localleader
      (:prefix-map ("p" . "treemacs-project")
        :desc "Select a new project to add to the current workspace" "a" #'treemacs-add-project-to-workspace
        :desc "Select a projectile project to add to the workspace"  "p" #'treemacs-projectile
        :desc "Remove a project at point from workspace"             "r" #'treemacs-remove-project-from-workspace
        :desc "Rename project at point"                              "R" #'treemacs-rename-project
        :desc "Collapse project at point"                            "c" #'treemacs-collapse-project
        :desc "Collapse all projects"                                "C" #'treemacs-collapse-all-projects)
      (:prefix-map ("w" . "treemacs-workspace")
        :desc "Rename a workspace"                    "R" #'treemacs-rename-workspace
        :desc "Create a new workspace"                "n" #'treemacs-create-workspace
        :desc "Delete a workspace"                    "d" #'treemacs-remove-workspace
        :desc "Switch current workspace"              "s" #'treemacs-switch-workspace
        :desc "Edit workspace layout via org-mode"    "e" #'treemacs-edit-workspaces
        :desc "Select the default fallback workspace" "f" #'treemacs-set-fallback-workspace)
      (:prefix-map ("n" . "treemacs-node")
        :desc "[Vert] Open current file or tag"     "v" #'treemacs-visit-node-vertical-split
        :desc "[Horz] Open current file or tag"     "h" #'treemacs-visit-node-horizontal-split
        :desc "[No Split] Open current file or tag" "o" #'treemacs-visit-node-no-split
        :desc "[Ace] Open current file or tag"      "a" #'treemacs-visit-node-ace
        :desc "[Ace Vert] Open current file or tag" "V" #'treemacs-visit-node-ace-vertical-split
        :desc "[Ace Horz] Open current file or tag" "H" #'treemacs-visit-node-ace-horizontal-split
        :desc "[External] Open current file or tag" "x" #'treemacs-visit-node-in-external-application)
      (:prefix-map ("t" . "treemacs-toggle")
        :desc "Dotfiles"    "d" #'treemacs-toggle-show-dotfiles
        :desc "Fixed width" "w" #'treemacs-toggle-fixed-width)
      (:prefix-map ("y" . "treemacs-copy")
        :desc "Absolute node path at point"    "n" #'treemacs-copy-path-at-point
        :desc "Absolute project path at point" "p" #'treemacs-copy-project-root
        :desc "File"                           "f" #'treemacs-copy-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comment-Dwim-2 - Replacement for comment-dwim. Allows commenting
;; of current buffer/selection, single lines (if pressed once), end
;; of line (if pressed twice), as well as kill single line comments
;; and reindenting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! "M-;" #'comment-dwim-2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iEdit - Allows isearch style find/replace for words at cursor.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package iedit
  ;:bind (("C-c e" . iedit-mode))
  :init
  (setq iedit-toggle-key-default nil))
(map! :leader
      (:prefix-map ("c" . "code")
        :desc "iEdit mode" "e" #'iedit-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Avy - Jump from character to character
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! "C-a" #'avy-goto-char)
(map! "M-a" #'avy-goto-char-2)

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Don't ring the bell
(setq ring-bell-function 'ignore)

(use-package lsp-mode)
