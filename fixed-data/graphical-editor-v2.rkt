;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname graphical-editor-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 5.10 A Graphical Editor

; Exercise 87: another data definition

(define-struct editor [content cursor-pos])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor c i) describes an editor
; whose visible text is c with 
; the cursor displayed after the i-th 1String in c
; i <= (string-length c)

; examples:
; (make-editor "hello" 0) => "(cursor)hello"
; (make-editor "hello" 1) => "h(cursor)ello"
; (make-editor "hello" 5) => "hello(cursor)"

(define FONT-SIZE 16)
(define WIDTH 200)
(define HEIGHT 20)

; Editor -> Image
(define (rendered-text ed)
  (beside (text (string-first-i (editor-content ed) (editor-cursor-pos ed))
                FONT-SIZE "black")
          (rectangle 2 FONT-SIZE "solid" "red")
          (text (string-rest-i (editor-content ed) (editor-cursor-pos ed))
                FONT-SIZE "black")))

; auxiliary functions
; string-first-i and string-rest-i splits a string at position i
(check-expect (string-first-i "h" 0) "")
(check-expect (string-first-i "h" 1) "h")
(check-error (string-first-i "h" 2) "index i must >=0 and <= string-length")
(define (string-first-i s i)
  (if (or (< i 0) (> i (string-length s)))
      (error "index i must >=0 and <= string-length")
      (substring s 0 i)))

(check-expect (string-rest-i "h" 0) "h")
(check-expect (string-rest-i "h" 1) "")
(check-error (string-rest-i "h" 2) "index i must >=0 and <= string-length")
(define (string-rest-i s i)
  (if (or (< i 0) (> i (string-length s)))
      (error "index i must >=0 and <= string-length")
      (substring s i)))

(define ed1 (make-editor "helloworld" 5))
(define ed2 (make-editor "helloworld1234567890ABCDEFG" 5))

; Editor -> Image
; renders the Editor to the canvas
(define (render ed)
  (overlay/align "left" "center"
                 (rendered-text ed)
                 (empty-scene WIDTH HEIGHT)))

; auxiliary functions
(define (string-insert str i ch)
  (if (and (>= i 0) (<= i (string-length str)))
      (string-append (substring str 0 i) ch (substring str i))
      (error "string index \"i\" is out of range")))

(define (string-delete str i)
  (if (and (>= i 0) (< i (string-length str)))
      (if (> (string-length str) 0)
          (string-append (substring str 0 i) (substring str (+ i 1)))
          "")
      (error "string index \"i\" is out of range")))

; Editor KeyEvent -> Editor
; handles key input to the editor
(check-expect (edit ed1 " ") (make-editor "hello world" 6))
(check-expect (edit ed1 "H") (make-editor "helloHworld" 6))
(check-expect (edit ed1 "\b") (make-editor "hellworld" 4))
(check-expect (edit ed1 "\t") ed1)
(check-expect (edit ed1 "\r") ed1)
(check-expect (edit ed1 "left") (make-editor "helloworld" 4))
(check-expect (edit ed1 "right") (make-editor "helloworld" 6))
(check-expect (edit ed2 "X") ed2)
(define (edit ed ke)
  (cond
    [(string=? "\b" ke)
     (if (= (editor-cursor-pos ed) 0)
         ed
         (make-editor (string-delete (editor-content ed)
                                     (- (editor-cursor-pos ed) 1))
                      (- (editor-cursor-pos ed) 1)))]
    [(or (string=? "\t" ke) (string=? "\r" ke))
     ed]
    [(= (string-length ke) 1)
     (if (too-wide ed)
         ed
         (make-editor (string-insert (editor-content ed)
                                     (editor-cursor-pos ed)
                                     ke)
                      (+ (editor-cursor-pos ed) 1)))]
    [(string=? "left" ke)
     (if (= (editor-cursor-pos ed) 0)
         ed
         (make-editor (editor-content ed)
                      (- (editor-cursor-pos ed) 1)))]
    [(string=? "right" ke)
     (if (= (editor-cursor-pos ed)
            (string-length (editor-content ed)))
         ed
         (make-editor (editor-content ed)
                      (+ (editor-cursor-pos ed) 1)))]
    [else ed]))

(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))

(define (too-wide ed)
  (> (image-width (rendered-text ed))
     WIDTH))