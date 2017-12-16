;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fomulas) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
;; formulate algebra expressions as Scheme programs

(define (f n)
  (+ (/ n 3) 2))

(f 2) ; 8/3
(f 5) ; 11/3
(f 9) ; 5

;; 1.
(define (g n)
  (+ (* n n) 10))

(g 2) ; 14
(g 9) ; 91

;; 2.
(define (h n)
  (+ (* 1/2 n n) 20))

(h 2) ; 22
(h 9) ; 60.5

;; 3.
(define (i n)
  (- 2 (/ 1 n)))

(i 2) ; 1.5
(i 9) ; 17/9