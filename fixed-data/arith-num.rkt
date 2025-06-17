;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname arith-num) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(sin pi)
"remainder x 3"
(remainder -3 3)
(remainder -2 3)
(remainder -1 3)
(remainder 0 3)
(remainder 1 3)
(remainder 2 3)
(remainder 3 3)
"modulo x 3"
(modulo -3 3)
(modulo -2 3)
(modulo -1 3)
(modulo 0 3)
(modulo 1 3)
(modulo 2 3)
(modulo 3 3)
"remainder x -3"
(remainder -3 -3)
(remainder -2 -3)
(remainder -1 -3)
(remainder 0 -3)
(remainder 1 -3)
(remainder 2 -3)
(remainder 3 -3)
"modulo x -3"
(modulo -3 -3)
(modulo -2 -3)
(modulo -1 -3)
(modulo 0 -3)
(modulo 1 -3)
(modulo 2 -3)
(modulo 3 -3)

; Exercise 1
(define x 3)
(define y 4)
(define (distance x y) (sqrt (+ (sqr x) (sqr y))))
(distance 3 4)