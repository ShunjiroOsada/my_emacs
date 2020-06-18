(require 'org)
(require 'ox-latex)
(require 'ox-bibtex)

(setq org-latex-classes '(("ltjsarticle"
            "\\documentclass{ltjsarticle}
\\usepackage{graphicx}
\\usepackage{color}
\\usepackage{atbegshi}
\\usepackage[unicode=true,bookmarks=true]{hyperref}
\\usepackage{bookmark}
\\usepackage{url}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               ))

(setq org-latex-default-class "ltjsarticle")
(setq org-latex-pdf-process '("lualatex %b" "lualatex %b" "pbibtex %b" "lualatex %b" "lualatex %b" "lualatex %b"))

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )
(add-hook 'org-mode-hook 'org-mode-reftex-setup)
(setq reftex-external-file-finders
       '(("tex" . "kpsewhich -format=.tex %f")
	 ("bib" . "kpsewhich -format=.bib %f")))

(defun define-bibfile (filename)
  (interactive
   (list
    (read-file-name "bibfile-name: ")))
  (setq reftex-default-bibliography `(,(format "%s" filename)))
)

(defun biblio-write(bib bst)
  (interactive
   (list
    (read-file-name "used-bibfile-name: ")
    (read-string "used-bstfile-name: ")))
  (insert (format "#+BIBLIOGRAPHY: %s %s option:-a limit:t" bib bst))
)
