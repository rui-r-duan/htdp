;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname computing) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (ff x)
  (* 10 x))

(* (ff 4) (+ (ff 3) 2))

(ff (ff 1))

(+ (ff 1) (ff 1)) ; DrRacket's stepper does NOT reuse the result.

; Exercise 22
(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))
(distance-to-origin 3 4)

; Exercise 23
(define (string-first s)
  (substring s 0 1))
(string-first "毕c")
; (string-first "") ; ending index 1 is out of range [0, 0]

; Exercise 24
(define (==> x y)
  (or (not x) y))
(==> #true #false)

; Exercise 25
(define (image-classify img)
  (cond
    [(> (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [else "wide"]))
(image-classify (square 20 "outline" "cyan"))

; Exercise 26
(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))
(string-insert "helloworld" 6)
