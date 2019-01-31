;;; ansible-vault-with-editor-mode.el --- Ansible Vault With Editor  -*- lexical-binding: nil; -*-

;; Copyright (C) 2019  Ruslan Kamashev

;; Author: Ruslan Kamashev <rynffoll@mbp.local>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(require 'with-editor)
(require 's)

(defgroup ansible-vault-with-editor
  nil
  "Ansible Vault With Editor"
  :group 'tools)

(defcustom ansible-vault-with-editor-password-file
  nil
  "Path to password file."
  :type 'file
  :group 'ansible-vault-with-editor)

(defcustom ansible-vault-with-editor-command
  "ansible-vault"
  "`ansible-vault' command."
  :type 'file
  :group 'ansible-vault-with-editor)

;;;###autoload
(defun ansible-vault-with-editor-on-buffer ()
  "Edit vault file."
  (interactive)
  (if (and ansible-vault-with-editor-password-file
           (file-exists-p ansible-vault-with-editor-password-file))
    (with-editor-async-shell-command
     (format "%s --vault-id=%s edit %s"
             ansible-vault-with-editor-command
             ansible-vault-with-editor-password-file
             (buffer-file-name)))
    (message "Correctly set `ansible-vault-with-editor-password-file' variable.")))

(provide 'ansible-vault-with-editor-mode)
;;; ansible-vault-with-editor-mode.el ends here
