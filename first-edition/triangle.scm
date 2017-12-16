;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname triangle) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
;; triangle : number number -> number
;; calculates the area of a triangle, given its base and
;; height

(define (triangle base height)
  (* 1/2 base height))

;; TESTS
(triangle 10 5) ; should be 25
(triangle 2 5)  ; should be 5