;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname convert3) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
;; convert3 : number number number -> number
;; builds a three digit number from its digits

(define (convert3 ones tens hundreds)
  (+ ones
     (* 10 tens)
     (* 100 hundreds)))

;; TESTS
(convert3 1 2 3) ; should be 321
(convert3 5 3 9) ; should be 935