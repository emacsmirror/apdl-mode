;;; apdl-wb-template.el --- APDL WorkBench/AIM templates for the APDL-Mode -*- lexical-binding: t -*-

;; Copyright (C) 2020  H. Dieter Wilhelm GPL V3

;; Author: H. Dieter Wilhelm <dieter@duenenhof-wilhelm.de>
;; Maintainer: H. Dieter Wilhelm
;; Version: 20.2.0
;; Package-Requires: ((emacs "25"))
;; Keywords: languages, convenience, ANSYS, tools, APDL
;; URL: https://github.com/dieter-wilhelm/apdl-mode


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This code is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 3, or (at your
;; option) any later version.
;;
;; This lisp script is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;
;; Permission is granted to distribute copies of this lisp script
;; provided the copyright notice and this permission are preserved in
;; all copies.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 675 Massachusetts Avenue; Cambridge, MA 02139, USA.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Comment:
;; Convention used for outlining
;; !@ is surrounded by 30 equal signs  ==============================
;; !@@ by 30 dashes ------------------------------
;; !@@@ by 30 dots ..............................
;; and empty lines

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Commentary:

;; Collection of templates for WorkBench and AIM Command (APDL)
;; objects

;;; Code:

(declare-function apdl-mode "apdl-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; --- functions ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun apdl-display-wb-skeleton (&optional arg)
  "Display or insert WorkBench Command (APDL) templates.
With an argument ARG not equal to 1 insert the template into the
current buffer instead of previewing it in a separate window.
You might trigger a completion of templates with the <TAB> or <?>
key and choose with the mouse 2 button."
  (interactive "p")
  (let* (
         (old-buffer (buffer-name))
         (new-buffer-name "*APDL-skeleton*")
         (skeleton-buffer
          (get-buffer-create new-buffer-name))
         s  ;yellow indicator line in the preview buffer above content
         ;; if skeleton window is visible in selected frame
         (visible  (get-buffer-window new-buffer-name nil))
         (skel-string
          ;; we might want to insert it while previewing...
          (if (and (not (= arg 1)) apdl-last-skeleton visible)
              apdl-last-skeleton
            "apdl-wbt-"))
         (skel
          (if (= arg 1)
              (completing-read "Preview template: "
                               obarray 'commandp t skel-string nil)
            (completing-read "Insert template: "
                             obarray 'commandp t skel-string nil)))
         )
    (setq apdl-last-skeleton skel)
    (cond ((= arg 1)
           (switch-to-buffer-other-window skeleton-buffer)
           (setq buffer-read-only nil)
           (remove-overlays)                                                  ;from beginnin and end of buffer
           (setq apdl-skeleton-overlay (make-overlay 1 1))
           (kill-region (point-min) (point-max))
           (funcall (intern-soft skel))
           ;;    (apdl-skeleton-numbering-controls)
           ;;    (insert "bla\n")
           (goto-char (point-min))
           (unless  (eq major-mode 'apdl-mode)
             (apdl-mode))
           (setq s (propertize
                    (concat "-*- APDL template: "
                            skel " -*-\n") 'face 'match))
           (overlay-put apdl-skeleton-overlay 'before-string s)
           (set-buffer-modified-p nil)
           (setq buffer-read-only t)
           (switch-to-buffer-other-window old-buffer)
           )
          (t
           (funcall (intern-soft skel))))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wbt workbench templates:
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; skeleton-insert
;; docu string
;; interactor string or nil
;; strings "here comes\n" str | "default" " again."

;; default values
(define-skeleton apdl-wbt-test
  "Write greetings"
  "Type name of idiot: "
  "hello, " str | "Otto von Bernstein" "!\n"
  "Here it goes.\n")

;; skeleton in skeleton
;; _ interesting / cursor region
(define-skeleton apdl-wbt-test2
  "Write greetings"
  "Type name of idiot: "
  ("Put a name in: " "hello, " str "!\n")
   "Here "_ "it goes.\n")

(define-skeleton apdl-wbt-2d-press-fit_calcs
"Post: Calculate the maximum torque.
And other parameters from a plane stress press-fit simulation."
nil
(insert-file "./template/plane_stress_press-fit_torque_calculations.mac"))

(provide 'apdl-wb-template)

;;; apdl-template.el ends here

;; Local Variables:
;; mode: outline-minor
;; indicate-empty-lines: t
;; show-trailing-whitespace: t
;; word-wrap: t
;; End:
