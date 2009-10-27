;; example `default.el' for Ansys mode under Unix and Windows
;; `default.el' can be used as a system wide startup file.  E. g. in
;; `/usr/local/share/emacs/site-lisp' or `INSTALLDIR/site-lisp'

(autoload 'ansys-mode "ansys-mode" "Activate Ansys mode." 'interactive)
(autoload 'ansys-display-error-file "ansys-mode" "Activate Ansys display error file function." 'interactive)
(autoload 'ansys-start-ansys-help "ansys-mode" "Activate Ansys start help function." 'interactive)
(autoload 'ansys-license-status "ansys-mode" "Activate Ansys license status function." 'interactive)

(add-to-list 'auto-mode-alist '("\\.mac$" . ansys-mode))
(add-to-list 'auto-mode-alist '("\\.inp$" . ansys-mode))
(add-to-list 'auto-mode-alist '("\\.anf$" . ansys-mode))

;; processes stuff
(setq ansys-license-file "27005@lic-rbg1")
(if (string= window-system "x")
    (progn
      (setq  ansys-program "/appl/ansys_inc/v110/ansys/bin/ansys110")
      (setq ansys-lmutil-program "/appl/ansys_inc/shared_files/licensing/linop64/lmutil")
      (setq ansys-help-file "/appl/ansys_inc/v110/ansys/bin/anshelp110"))
  (progn
    (setq ansys-lmutil-program "C:\\Program Files\\Ansys Inc\\Shared Files\\licensing\\intel\\anslic_admin.exe")
					;'\"' on windows mandatory
    (setq ansys-help-file "\"C:\\Program Files\\Ansys Inc\\v110\\CommonFiles\\HELP\\en-us\\ansyshelp.chm\"")))

(setq ansys-licence "preppost")

;; insertion stuff
(auto-insert-mode 1)
(add-hook 'find-file-hook 'auto-insert)
(setq auto-insert-query t)
(add-to-list 'auto-insert-alist '(ansys-mode . [ansys-skeleton]))

;; experimental user variables highlighting
;(setq ansys-dynamic-highlighting-flag t)
