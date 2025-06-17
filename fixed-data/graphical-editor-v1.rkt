;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname graphical-editor-v1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 5.10 A Graphical Editor

; Exercise 83: render

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define FONT-SIZE 16)
(define WIDTH 200)
(define HEIGHT 20)

; Editor -> Image
(define (rendered-text ed)
  (beside (text (editor-pre ed) FONT-SIZE "black")
          (rectangle 2 FONT-SIZE "solid" "red")
          (text (editor-post ed) FONT-SIZE "black")))

; Editor -> Image
; renders the Editor to the canvas
(define (render ed)
  (overlay/align "left" "center"
                 (rendered-text ed)
                 (empty-scene WIDTH HEIGHT)))

; Exercise 84: edit
(define ed1 (make-editor "hello" "world"))

; Editor KeyEvent -> Editor
; handles key input to the editor
(check-expect (edit ed1 " ") (make-editor "hello " "world"))
(check-expect (edit ed1 "H") (make-editor "helloH" "world"))
(check-expect (edit ed1 "\b") (make-editor "hell" "world"))
(check-expect (edit ed1 "\t") ed1)
(check-expect (edit ed1 "\r") ed1)
(check-expect (edit ed1 "left") (make-editor "hell" "oworld"))
(check-expect (edit ed1 "right") (make-editor "hellow" "orld"))
(define (edit ed ke)
  (cond
    [(string=? "\b" ke)
     (make-editor (string-remove-last (editor-pre ed))
                  (editor-post ed))]
    [(or (string=? "\t" ke) (string=? "\r" ke))
     ed]
    [(= (string-length ke) 1)
     (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
    [(string=? "left" ke)
     (make-editor (string-remove-last (editor-pre ed))
                  (string-append (string-last (editor-pre ed))
                                 (editor-post ed)))]
    [(string=? "right" ke)
     (make-editor (string-append (editor-pre ed)
                                 (string-first (editor-post ed)))
                  (string-rest (editor-post ed)))]
    [else ed]))

(check-expect (string-remove-last "") "")
(check-expect (string-remove-last "hello") "hell")
(define (string-remove-last s)
  (if (= (string-length s) 0)
      s
      (substring s 0 (- (string-length s) 1))))

(define (string-rest s)
  (if (= (string-length s) 0)
      s
      (substring s 1)))

(define (string-last s)
  (if (= (string-length s) 0)
      ""
      (substring s (- (string-length s) 1))))

(define (string-first s)
  (if (= (string-length s) 0)
      ""
      (substring s 0 1)))

; Exercise 85: run

; Editor -> Editor
(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))

; Exercise 86: too much text for the canvas

(define ed2 (make-editor "hello" "world1234567890ABCDEFG"))

(define (too-wide ed)
  (> (image-width (rendered-text ed))
     WIDTH))

; Editor KeyEvent -> Editor
(check-expect (edit.v2 ed2 "X") ed2)
(define (edit.v2 ed ke)
  (cond
    [(string=? "\b" ke)
     (make-editor (string-remove-last (editor-pre ed))
                  (editor-post ed))]
    [(or (string=? "\t" ke) (string=? "\r" ke))
     ed]
    [(= (string-length ke) 1)
     (if (too-wide ed)
         ed
         (make-editor (string-append (editor-pre ed) ke) (editor-post ed)))]
    [(string=? "left" ke)
     (make-editor (string-remove-last (editor-pre ed))
                  (string-append (string-last (editor-pre ed))
                                 (editor-post ed)))]
    [(string=? "right" ke)
     (make-editor (string-append (editor-pre ed)
                                 (string-first (editor-post ed)))
                  (string-rest (editor-post ed)))]
    [else ed]))

(define (run.v2 ed)
  (big-bang ed
    [to-draw render]
    [on-key edit.v2]))