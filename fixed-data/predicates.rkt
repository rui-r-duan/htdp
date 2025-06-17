;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname predicates) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; (* (+ (string-length 42) 1) pi)

(number? "42")
(string? 42)
(image? (rectangle 20 20 "outline" "red"))
(image? (text "closed" 16 "red"))
(boolean? 42)

(exact? pi) ; #false
(inexact? pi) ; #true
(rational? pi) ; #true !! But π is irrational!!
(real? pi) ; #true
(complex? pi) ; #true

; Exercise 9
(define (to-non-neg-num in)
  (cond
    [(string? in) (string-length in)]
    [(image? in) (* (image-width in) (image-height in))]
    [(number? in) (abs in)]
    [(boolean? in) (if in 10 20)]
    [else 0]))