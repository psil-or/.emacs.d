;; Base directory and load-path
(defun ors-add-subdirs (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(defvar emacs-d (file-truename "~/.emacs.d/"))
(ors-add-subdirs (expand-file-name "extensions/" emacs-d))
(ors-add-subdirs (expand-file-name "sdcv-dict/" emacs-d))
(add-to-list 'load-path (expand-file-name "config/" emacs-d))

;; Font
(require 'init-font)

(let (
      ;; 加载的时候临时增大`gc-cons-threshold`以加速启动速度
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      ;; 清空避免加载远程文件的时候分析文件
      (file-name-handler-alist nil))

  (with-temp-message ""
    (require 'init-customize)
    
    (require 'eclipse-theme)
    (load-theme 'eclipse t)
    (require 'lazy-load)
    (require 'lispy)
    ;; (require 'paredit)
  
    ;; (require 'init-awesome-tab)
    (require 'init-backup)
    (require 'init-auto-save)
    (require 'init-mode)
    ;; (require 'init-paredit)
    (require 'init-lispy)
    (require 'init-key)
    ;; (require 'init-exwm)
    
    ;; 可以延后加载的
    (run-with-idle-timer
     1 nil
     #'(lambda ()
         ;;(require 'init-yasnippet)
         
         (require 'init-eaf)
         (require 'init-sdcv)

         (server-start)
         ))))
