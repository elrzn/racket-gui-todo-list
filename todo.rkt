#!/usr/bin/env gracket
#lang racket/gui

(define title "My task list")

(define frame-main
  (new frame%
       (min-width 640)
       (min-height 480)
       (label title)))

(define group-box-panel-task
  (new group-box-panel%
       (parent frame-main)
       (label "Tasks")))

(define text-field-new-task
  (new text-field%
       (label "New task")
       (parent group-box-panel-task)
       (init-value "")))

(define button-add
  (new button%
       (parent group-box-panel-task)
       (label "Add task")
       (callback (lambda (button event)
                   (if (not (equal? (string-normalize-spaces (send text-field-new-task get-value)) ""))
                       (begin
                         (send list-box-task append
                               (send text-field-new-task get-value))
                         (send (send text-field-new-task get-editor)
                               erase))
                       (begin
                         (send text-field-new-task set-value "")
                         (message-box title "Task name is mandatory" frame-main)))))))

(define list-box-task
  (new list-box%
       (label "")
       (parent group-box-panel-task)
       (choices (list))
       (style (list 'single))
       (columns (list ""))))

(define button-done
  (new button%
       (parent group-box-panel-task)
       (label "Mark as done")
       (callback (lambda (button event)
                   (let ((index (send list-box-task get-selection))
                         (value (send list-box-task get-string-selection)))
                     (send list-box-task-completed append value)
                     (send list-box-task delete index))))))

(define group-box-panel-task-completed
  (new group-box-panel%
       (parent frame-main)
       (label "Completed tasks")))

(define list-box-task-completed
  (new list-box%
       (label "")
       (parent group-box-panel-task-completed)
       (choices (list))
       (style (list 'single))
       (columns (list ""))))

(send frame-main show #t)
