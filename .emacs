;; My name and e-mail adress
(setq user-full-name   "%Kats%")
(setq user-mail-adress "%n.kats@rambler-co.ru%")

;; System-type definition
(defun system-is-linux()
    (string-equal system-type "gnu/linux"))
(defun system-is-windows()
    (string-equal system-type "windows-nt"))
;; MS Windows path-variable
(when (system-is-windows)
    (setq win-sbcl-exe          "C:/sbcl/sbcl.exe")
    (setq win-init-path         "C:/.emacs.d")
    (setq win-init-ct-path      "C:/.emacs.d/plugins/color-theme")
    (setq win-init-ac-path      "C:/.emacs.d/plugins/auto-complete")
    (setq win-init-slime-path   "C:/slime")
    (setq win-init-ac-dict-path "C:/.emacs.d/plugins/auto-complete/dict"))
;; Unix path-variable
(when (system-is-linux)
    (setq unix-sbcl-bin          "/usr/bin/sbcl")
    (setq unix-init-path         "/home/nick/.emacs.d/lisp")
    (setq unix-init-ct-path      "~/.emacs.d/plugins/color-theme")
    (setq unix-init-ac-path      "~/.emacs.d/plugins/auto-complete")
    (setq unix-init-slime-path   "/usr/share/common-lisp/source/slime/")
    (setq unix-init-ac-dict-path "~/.emacs.d/plugins/auto-complete/dict"))

;;Load path for git package
(add-to-list 'load-path "/home/nick/.emacs.d/git_package")

;; Dired
(require 'dired)
(setq dired-recursive-deletes 'to)
;; Disable GUI components
(tooltip-mode      -1)
(menu-bar-mode     -1) ;; отключаем графическое меню
(tool-bar-mode     -1) ;; отключаем tool-bar
(scroll-bar-mode   -1) ;; отключаем полосу прокрутки
(blink-cursor-mode -1) ;; курсор не мигает
(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - все через минибуфер
(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; отключить звуковой сигнал

;; Linum plugin
(require 'linum) ;; вызвать Linum
(line-number-mode   t) ;; показать номер строки в mode-line
(global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
(setq linum-format " %d") ;; задаем формат нумерации строк

;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t) ;; автоматически обновлять список функций в буфере
(setq imenu-use-popup-menu nil) ;; диалоги Imenu только в минибуфере
(global-set-key (kbd "<f6>") 'imenu) ;; вызов Imenu на F6

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")
(setq blink-cursor-mode 1)

;; Load path for plugins
(if (system-is-windows)
    (add-to-list 'load-path unix-init-path)
	(add-to-list 'load-path unix-init-path))

;; Org-mode settings
(require 'org) ;; Вызвать org-mode
(global-set-key "\C-ca" 'org-agenda) ;; поределение клавиатурных комбинаций для внутренних
(global-set-key "\C-cb" 'org-iswitchb) ;; подрежимов org-mode
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; ассоциируем *.org файлы с org-mode
(setq ruby-insert-encoding-magic-comment nil)

;; Show-paren-mode settings
(show-paren-mode t) ;; включить выделение выражений между {},[],()
(setq show-paren-style 'expression) ;; выделить цветом выражения между {},[],()

;; Coding-system settings
(set-language-environment 'UTF-8)
(if (system-is-linux) ;; для GNU/Linux кодировка utf-8, для MS Windows - windows-1251
    (progn
        (setq default-buffer-file-coding-system 'utf-8)
        (setq-default coding-system-for-read    'utf-8)
        (setq file-name-coding-system           'utf-8)
        (set-selection-coding-system            'utf-8)
        (set-keyboard-coding-system        'utf-8-unix)
        (set-terminal-coding-system             'utf-8)
        (prefer-coding-system                   'utf-8))
    (progn
        (prefer-coding-system                   'windows-1251)
        (set-terminal-coding-system             'windows-1251)
        (set-keyboard-coding-system        'windows-1251-unix)
        (set-selection-coding-system            'windows-1251)
        (setq file-name-coding-system           'windows-1251)
        (setq-default coding-system-for-read    'windows-1251)
        (setq default-buffer-file-coding-system 'windows-1251)))

;; Fringe settings
(fringe-mode '(8 . 0)) ;; органичиталь текста только слева
(setq-default indicate-empty-lines t) ;; отсутствие строки выделить глифами рядом с полосой с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; индикация только слева

;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode             t) ;; показывать часы в mode-line
(size-indication-mode          t) ;; размер файла в %-ах

;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t) ;; включено с версии Emacs-22. На всякий...
(setq font-lock-maximum-decoration t)

	;; Scrolling settings
(setq scroll-step               1) ;; вверх-вниз по 1 строке
(setq scroll-margin            10) ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы
(setq scroll-conservatively 10000)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-eighties))
 '(custom-safe-themes
   '("e29a6c66d4c383dbda21f48effe83a1c2a1058a17ac506d60889aba36685ed94" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "e7b7d1e49adc2b0533b4fe57617c358ecbca80f39d05a30b825b998fa86bc372" default))
 '(font-use-system-font t)
 '(package-selected-packages
   '(zeal-at-point edbi ejc-sql todoist inf-ruby exec-path-from-shell smart-mode-line-atom-one-dark-theme doom-themes go-translate forest-blue-theme color-theme-sanityinc-tomorrow git-timemachine rubocop window-purpose flycheck magit projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282C34" :foreground "#ABB2BF" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 97 :width normal :foundry "ADBO" :family "Fira Code")))))

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(windmove-default-keybindings 'meta)
(load-theme 'one-dark t)

;; An atom-one-dark theme for smart-mode-line
;; smart-mode-line
(setq sml/theme 'atom-one-dark)
(sml/setup)

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-ruby-rubocop-executable "~/.rbenv/versions/2.7.1/bin/rubocop")
(setq flycheck-ruby-rubylint-executable "~/.rbnev/versions/2.7.1/bin/ruby-lint")

(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)

(setq todoist-token "8f2ce1219e7d2d43dd0da8148ec7f555d66acf0c")

(setq sql-postgres-login-params
      '((user :default "rm_dev_rm_dev")
        (database :default "rm_dev_rm_dev_master")
        (server :default "pg-dev.rambler-co.ru")
        (port :default 6000)))

;; update packages list if we are on a new install
(unless package-archive-contents
  (package-refresh-contents))

;; a list of pkgs to programmatically install
;; ensure installed via package.el
(setq my-package-list '(use-package))

;; programmatically install/ensure installed
;; pkgs in your personal list
(dolist (package my-package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; now you can
;; (use-package pkgname) etc as per
;; use-package example docs

(use-package power-mode
  :load-path "/home/nick/.emacs.d/git_package/power-mode.el/power-mode.el"
  :init
  (add-hook 'after-init-hook #'power-mode))
