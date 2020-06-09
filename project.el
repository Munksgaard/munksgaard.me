(require 'ox-publish)

(setq org-html-postamble-format
      '(("en" "<div class=\"postamble\" class=\"status\">
<p class=\"copyright\">Copyright 2015-2020 %a<p>
<p class=\"email\">Email: %e</p>
<p class=\"date\">Created: %d</p>
<p class=\"modified\">Last modified: %C</p>
</div>")))

(setq org-publish-project-alist
      (list
       (list "munksgaard.me-org"
             :author "Philip Munksgaard"
             :email "philip@munksgaard.me"
             :base-directory (caar dir-locals-directory-cache)
             :base-extension "org"
             :publishing-directory "/ssh:munksgaard.me|sudo:www-data:/var/www/munksgaard.me"
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
             )

        '("munksgaard.me-static"
          :base-directory "./"
          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|patch"
          :recursive t
          :publishing-directory "/ssh:munksgaard.me|sudo:www-data:/var/www/munksgaard.me"
          :publishing-function org-publish-attachment
          )

        '("papers"
          :base-directory "./papers/"
          :base-extension "pdf"
          :publishing-directory "/ssh:munksgaard.me|sudo:www-data:/var/www/munksgaard.me/papers"
          :publishing-function org-publish-attachment)

        '("munksgaard.me" :components ("munksgaard.me-org" "munksgaard.me-static" "papers"))))
