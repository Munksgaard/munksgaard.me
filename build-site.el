;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(toggle-debug-on-error)

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(use-package futhark-mode
  :ensure t
  :mode "\\.fut\\(_[a-z_]+\\)?\\'")

(use-package sml-mode
  :ensure t)



;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

(setq org-html-postamble-format
      '(("en" "<div class=\"postamble\" class=\"status\">
<p class=\"copyright\">Copyright 2015-2020 %a<p>
<p class=\"email\">Email: %e</p>
<p class=\"date\">Created: %d</p>
<p class=\"modified\">Last modified: %C</p>
</div>")))

;; ;; Define the publishing project
;; (setq org-publish-project-alist
;;       (list
;;        (list "org-site:main"
;;              :recursive t
;;              :base-directory "./content"
;;              :publishing-function 'org-html-publish-to-html
;;              :publishing-directory "./public"
;;              :with-author nil           ;; Don't include author name
;;              :with-creator t            ;; Include Emacs and Org versions in footer
;;              :with-toc t                ;; Include a table of contents
;;              :section-numbers nil       ;; Don't include section numbers
;;              :time-stamp-file nil)))    ;; Don't include time stamp in file

(setq org-publish-project-alist
      (list
       (list "munksgaard.me-org"
             :author "Philip Munksgaard"
             :email "philip@munksgaard.me"
             :base-directory "./"
             :base-extension "org"
             :publishing-directory "./build"
             :recursive t
             :publishing-function 'org-html-publish-to-html
             :headline-levels 4             ; Just the default for this project.
             :language "en"
             :section-numbers nil
             :time-stamp-file t
             :with-author t
             :with-creator nil
             :with-email t
             :with-emphasize t
             :with-footnotes t
             :with-tables t
             :with-timestamps t
             :with-toc nil
             :html-postamble t
             :html-doctype "xhtml-strict"
             :html-divs '((preamble "header" "preamble")
                          (content "article" "content")
                          (postamble "footer" "postamble"))
             :html-container "section"
             :html-head "<style type=\"text/css\">
    /*<![CDATA[*/
      pre.src { overflow: auto; }
    /*]]>*/
   </style>"
             :html-self-link-headlines t
             :html-allow-name-attribute-in-anchors t
             ;; :html-html5-fancy t
             :html-link-home "/index.html"
             :html-link-up ""
             :html-home/up-format "<div id=\"org-div-home-and-up\">
 %s
 <a accesskey=\"H\" href=\"%s\"> HOME </a>
</div>"
             )

        '("munksgaard.me-static"
          :base-directory "./"
          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|patch\\|txt"
          :recursive t
          :publishing-directory "./build"
          :publishing-function org-publish-attachment
          )

        '("papers"
          :base-directory "./papers/"
          :base-extension "pdf"
          :publishing-directory "./build/papers"
          :publishing-function org-publish-attachment)

        '("munksgaard.me" :components ("munksgaard.me-org" "munksgaard.me-static" "papers")))
      )

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
