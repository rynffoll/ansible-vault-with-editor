;;; ansible-vault-with-editor.el --- Ansible Vault With Editor  -*- lexical-binding: nil; -*-

;; Copyright (C) 2023  Ruslan Kamashev

;; Author: Ruslan Kamashev <rynffoll@gmail.com>
;; Keywords: tools
;; Version: 0.1
;; Package-Requires: ((with-editor))
;; Homepage: https://github.com/rynffoll/ansible-vault-with-editor

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

;; Integration `ansible-vault' and `with-editor'

;;; Code:

(require 'with-editor)

(defgroup ansible-vault-with-editor
  nil
  "Ansible Vault With Editor."
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

(defun ansible-vault-with-editor-run-action (action)
  "Run ansible-vault ACTION."
  (if (and ansible-vault-with-editor-password-file
           (file-exists-p ansible-vault-with-editor-password-file))
    (with-editor-async-shell-command
     (format "%s %s --vault-password-file %s %s"
             ansible-vault-with-editor-command
             action
             ansible-vault-with-editor-password-file
             (buffer-file-name)))
    (message "Correctly set `ansible-vault-with-editor-password-file' variable.")))

;;;###autoload
(defun ansible-vault-with-editor-edit ()
  "Edit vault file."
  (interactive)
  (ansible-vault-with-editor-run-action "edit"))

;;;###autoload
(defun ansible-vault-with-editor-encrypt ()
  "Encrypt vault file."
  (interactive)
  (ansible-vault-with-editor-run-action "encrypt"))

;;;###autoload
(defun ansible-vault-with-editor-decrypt ()
  "Encrypt vault file."
  (interactive)
  (ansible-vault-with-editor-run-action "decrypt"))

(provide 'ansible-vault-with-editor)
;;; ansible-vault-with-editor.el ends here
