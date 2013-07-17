;; http://d.hatena.ne.jp/rubikitch/20090609/1244484272
(defun add-to-load-path-recompile (dir)
  (add-to-list 'load-path dir)
  )

;; setenv PATH
(setenv "PATH" (concat "/opt/local/bin:" (getenv "PATH")))
(dolist (dir (mapcar 'expand-file-name '("/opt/local/bin")))
  (setenv "PATH" (concat dir ":" (getenv "PATH")))
  (setq exec-path (append (list dir) exec-path)))

;; load-path
(setq load-path
      (append
       load-path
       (list
        (expand-file-name "~/.emacs.d/")
       )
       ))

;; MacのCopy/Paste
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;; 日本語設定設定
;; http://d.hatena.ne.jp/SISY/searchdiary?word=*[emacs]
(set-language-environment "Japanese")
(auto-compression-mode t)
;; http://www.yza.jp/blog/item/422/
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-systems 'utf-8)
;; 基本設定
;; (set-scroll-bar-mode 'right)
(display-time)
(setq visible-bell nil)
;; (tool-bar-mode 0)
(global-hl-line-mode 1)
;; http://www.bookshelf.jp/soft/meadow_42.html#SEC632
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; スタートアップ時のメッセージを抑制
(setq Inhibit-Startup-message t)

;; バックアップしない
(setq make-backup-files nil)


;; C-x C-iでリージョンをインデント
(global-set-key "\C-x\C-i" 'indent-region)

;; C-hでbackspace
;(keyboard-translate ?\C-h ?\C-?)
;(global-set-key "\C-h" nil)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-x?" 'help)

;; C-x p で前の画面
(define-key ctl-x-map "p"
  #'(lambda (arg) (interactive "p") (other-window (- arg))))

;; http://d.hatena.ne.jp/mat_aki/20080421
(windmove-default-keybindings)

;; ido-mode
(require 'ido)
(ido-mode t)

;; 矩形
;; http://taiyaki.org/elisp/sense-region/
(autoload 'sense-region-on "sense-region"
          "System to toggle region and rectangle." t nil)
(sense-region-on)

;; undo-tree
;; (when (require 'redo nil t)
;;   (define-key ctl-x-map (if window-system "U" "r") 'redo)
;;   (define-key global-map [?\C-_] 'redo))
(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key "\C-_" 'undo-tree-redo)

;; linum
(require 'linum)
(global-linum-mode)

;; -----------------------------
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-dwim t)
 '(display-time-mode t)
 '(js2-basic-offset 2)
 '(magit-log-cutoff-length 300)
 '(magit-process-popup-time 0)
 '(org-capture-templates nil t)
 '(python-continuation-offset 2)
 '(python-guess-indent t)
 '(python-indent 2)
 '(ruby-insert-encoding-magic-comment nil)
 '(ruby-use-encoding-map t)
 '(twit-follow-idle-interval 300)
 '(twit-mode t)
 '(twit-show-user-images t)
 '(untabify-exclude-list (quote (makefile-mode makefile-bsdmake-mode change-log-mode "Makefile$" Emacs-Lisp))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "red"))))
 '(mmm-code-submode-face ((t (:background "DarkGray"))))
 '(mmm-declaration-submode-face ((t (:background "Aquamarine" :foreground "black"))))
 '(mmm-default-submode-face ((t (:background "Black"))))
 '(mmm-output-submode-face ((t (:background "DarkGreen"))))
 '(rst-level-1-face ((t (:background "grey10"))) t)
 '(rst-level-2-face ((t (:background "grey20"))) t)
 '(twit-title-face ((((class color) (background dark)) (:background "chartreuse4"))))
 '(twit-zebra-1-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(twit-zebra-2-face ((((class color) (background dark)) (:background "SpringGreen4")))))

;; ------------------------------
;; color-theme
;; ------------------------------
(add-to-load-path-recompile "~/.emacs.d/color-theme")
(require 'color-theme)
(color-theme-initialize)
(color-theme-robin-hood)

;; yasnippet
(add-to-load-path-recompile "~/.emacs.d/yasnippet-0.5.10")
(require 'yasnippet)
(yas/load-directory "~/.emacs.d/yasnippets-rails/rails-snippets")
(add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
(add-to-list 'yas/extra-mode-hooks 'feature-mode-hook)
(setq yas/trigger-key (kbd "SPC"))
(setq yas/trigger-key (kbd "C-:"))
(yas/initialize)

;; WidenWindow http://d.hatena.ne.jp/rubikitch/20081113/1226575019
(require 'widen-window)
(setq ww-ratio 0.65)
(global-widen-window-mode 1)
;; (diminish 'widen-window-mode " WW")
(defadvice anything (around disable-ww-mode activate)
  (ad-deactivate-regexp "widen-window")
  (unwind-protect
      ad-do-it
    (ad-activate-regexp "widen-window")))

;; wdiredhttp://www.bookshelf.jp/soft/meadow_25.html#SEC296
;; diredでファイル名を一括リネーム
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; find-fileでの補完
;; http://www.bookshelf.jp/soft/meadow_23.html#SEC219
;; (setq hc-ctrl-x-c-is-completion t)
;; (require 'highlight-completion)
;; (highlight-completion-mode 1)

;; browse-kill-ring
;; http://www.todesschaf.org/projects/bkr.html
;; http://www.bookshelf.jp/soft/meadow_32.html#SEC451
;; (require 'browse-kill-ring)
;; (global-set-key "\M-y" 'browse-kill-ring)
;; 必要に応じて browse-kill-ring のウィンドウの大きさを変更する
;; (setq browse-kill-ring-resize-window t)
;; 現在選択中の kill-ring のハイライトする
;; (setq browse-kill-ring-highlight-current-entry t)

;; ibuffer
;; http://www.bookshelf.jp/soft/meadow_28.html#SEC357
(require 'ibuffer)

;; ------------------------------
;; mode / 編集モード
;; ------------------------------
;; mmm-mode
(add-to-load-path-recompile "~/.emacs.d/mmm-mode")
(require 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
;; 色設定．これは，好みで．色をつけたくないなら nil にします．
(set-face-background 'mmm-default-submode-face "honeydew")
(load "mmm-mode-setting")

;; javascript-mode js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|jsn\\)\\'" 'js2-mode))

;; javascript-mode
(add-to-list 'auto-mode-alist (cons  "\\.\\(json\\)\\'" 'javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(setq js-indent-level 2)

;; coffee-mode
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
          '(lambda() (coffee-custom)))

;; css-mode
;; http://www.garshol.priv.no/download/software/css-mode/doco.html
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons (cons "\\.scss$" 'css-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

;; rst-mode
(autoload 'rst-mode "rst-mode" "mode for editing reStructuredText documents" t)
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

;; haml-mode/sass-mode
(require 'sass-mode)
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;; cucumber.el
(add-to-load-path-recompile "~/.emacs.d/cucumber.el")
(autoload 'feature-mode "feature-mode" "Mode for editing cucumber files" t)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; ------------------------------
;; git
;; ------------------------------

;; git-emacs
;; http://d.hatena.ne.jp/xcezx/20080425/1209081657
;; http://tsgates.cafe24.com/git/git-emacs.html
;; (setq load-path (cons (expand-file-name "~/.emacs.d/git-emacs") load-path))
;; (require 'vc-git)

;; (require 'git-emacs)

;; magit http://gitorious.org/projects/magit/repos/mainline
(add-to-load-path-recompile "~/.emacs.d/magit")
(require 'magit)
(autoload 'magit-status "magit" nil t)

;; egg git http://github.com/bogolisk/egg/tree/master
;; (setq load-path (cons (expand-file-name "~/.emacs.d/egg") load-path))
;; (require 'egg)

;; ------------------------------
;; gist
;; ------------------------------
(require 'gist)

;; howm
(add-to-list 'load-path "~/.emacs.d/howm")
(require 'howm-mode)
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
;; (autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)

;; matodo
(require 'matodo-mode)

;; http://openlab.dino.co.jp/2008/07/15/233005294.html
;; Show tab, zenkaku-space, white spaces at end of line
;; http://www.bookshelf.jp/soft/meadow_26.html#SEC317
(defface my-face-tab         '((t (:background "Yellow"))) nil :group 'my-faces)
(defface my-face-zenkaku-spc '((t (:background "LightBlue"))) nil :group 'my-faces)
(defface my-face-spc-at-eol  '((t (:foreground "Red" :underline t))) nil :group 'my-faces)
(defvar my-face-tab         'my-face-tab)
(defvar my-face-zenkaku-spc 'my-face-zenkaku-spc)
(defvar my-face-spc-at-eol  'my-face-spc-at-eol)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-tab append)
     ("　" 0 my-face-zenkaku-spc append)
     ("[ \t]+$" 0 my-face-spc-at-eol append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
;; settings for text file
(add-hook 'ruby-mode-hook
          '(lambda ()
             (progn
               (font-lock-mode t)
               (font-lock-fontify-buffer))))

;; ------------------------------
;; ruby
;; ------------------------------
(add-to-load-path-recompile "~/.emacs.d/rinari/util")
(add-to-load-path-recompile "~/.emacs.d/ruby-mode")
(require 'ruby-mode)
(require 'ruby-electric)
(require 'inf-ruby)
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;; ri-emacs
(setq ri-ruby-script "~/.emacs.d/ri-emacs/ri-emacs.rb")
(add-to-load-path-recompile "~/.emacs.d/ri-emacs")
;; (add-hook 'ruby-mode-hook (lambda ()
;;                               (local-set-key 'f1 'ri)
;;                               (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
;;                               (local-set-key 'f4 'ri-ruby-show-args)
;;                               ))

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)

;; rcodetools
(require 'rcodetools)
;; (setq ac-omni-completion-sources
;;   '((ruby-mode . (("\\.\\=" . (ac-source-rcodetools))))))
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook
          (lambda()
            (ruby-electric-mode t)))


;; ------------------------------
;; rails
;; ------------------------------
;; emacs-rails
;; http://rubyforge.org/projects/emacs-rails/
;; http://d.hatena.ne.jp/higepon/20061222/1166774270
(add-to-load-path-recompile "~/.emacs.d/emacs-rails")
;; (require 'rails)
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))

;; rinari
;; http://d.hatena.ne.jp/willnet/20090110/1231595231
;; http://github.com/eschulte/rinari/tree/master
(add-to-load-path-recompile "~/.emacs.d/rinari")
(require 'rinari)

;; rhtml using in rinari
(add-to-load-path-recompile "~/.emacs.d/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)))

;; ------------------------------
;; yaml-mode
;; ------------------------------
(add-to-load-path-recompile "~/.emacs.d/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\.sample$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; ------------------------------
;; tools
;; ------------------------------

;; install-elisp
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/")

;; vim
(setq viper-mode nil)
(setq viper-inhibit-startup-message 't)
(setq viper-expert-level '1)
(require 'viper)

;; 同じファイル名のファイルを開いた際に親ディレクトリ名前を表示する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; tabをspaceに変換する
(require 'untabify-file)

;; ejacs
(add-to-load-path-recompile "~/.emacs.d/ejacs")
(autoload 'js-console "js-console" nil t)

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/")
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)

;; one-key
;; (require 'one-key)
;; (require 'one-key-default)
;; (require 'one-key-config)
;; (one-key-default-setup-keys)
;;(define-key global-map "\C-x" 'one-key-menu-C-x) ;; C-x にコマンドを定義

;; key-chord
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "df" 'describe-bindings)
(key-chord-define-global "ms" 'magit-status)
(key-chord-define-global "mn" 'anything-imenu)

;; ------------------------------
;; irc
;; ------------------------------
(require 'init-rcirc)

;; ------------------------------
;; twitter
;; ------------------------------
(require 'twit)

;; ------------------------------
;; anything
;; ------------------------------
(require 'anything-config)
(require 'anything)
(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0)
(setq anything-candidate-number-limit 100)
(require 'anything-c-mx)
(require 'anything-etags)
(require 'anything-auto-install)
(require 'anything-rcodetools)
(setq rct-get-all-methods-command "PAGER=cat fri -l")
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
;; anything-c-source-kill-ring
(defvar anything-c-source-kill-ring
    '((name . "Kill Ring")
      (candidates . (lambda ()
                      (loop for kill in kill-ring
                            unless (string-match "^[\\s\\t]+$" kill)
                            collect kill)))
      (action . insert)
      (migemo)
      (multiline)))
(require 'anything-c-yasnippet)
(setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
(global-set-key (kbd "C-c y") 'anything-c-yas-complete) ;C-c yで起動 (同時にお使いのマイナーモードとキーバインドがかぶるかもしれません)

(require 'descbinds-anything)
(descbinds-anything-install)

;; keybind
(global-set-key (kbd "C-;") 'anything-for-files)
(global-set-key (kbd "C-^") 'anything-for-files)
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
;; source list
(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-kill-ring
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-minibuffer-history
        anything-c-source-files-in-current-dir
        ))

;;; anything-c-moccurの設定
(require 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))

;; anything-complete
(require 'anything-complete)
(anything-lisp-complete-symbol-set-timer 150)
(require 'anything-show-completion)
;; http://d.hatena.ne.jp/rubikitch/20080701/1214844444
(require 'anything-dabbrev-expand)
(setq anything-dabbrev-input-idle-delay 0.0)
(setq anything-dabbrev-idle-delay 1.0)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(require 'buster-mode)
(add-to-list 'auto-mode-alist '("\\-test.js$" . buster-mode))


(require 'auto-complete)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-ruby)

(setq rsense-home "~/.emacs.d/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; .や::を入力直後から補完開始
             (add-to-list 'ac-sources 'ac-source-rsense-method)
             (add-to-list 'ac-sources 'ac-source-rsense-constant)
             ;; C-x .で補完出来るようキーを設定
             (define-key ruby-mode-map (kbd "C-x .") 'ac-complete-rsense)))



(require 'web-mode)

;;; 適用する拡張子
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)

;;; Elixir
(require 'elixir-mode)
(add-to-list 'auto-mode-alist '("\\.elixir$"     . elixir-mode))

