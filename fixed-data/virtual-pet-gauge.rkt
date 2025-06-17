;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname virtual-pet-gauge) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Exercise 47: gauge-prog

; WorldState is a Number
; interpretation happiness level: [0, 100] (inclusive)

; WorldState -> WorldState
; With each clock tick, the happiness level decreases by 0.1; it never falls
; below 0 though.
; given: 100, expected: 99.9
; given: 0.1, expected: 0.1
; given: 0.2, expected: 0.1
(define (tock cw)
  (if (<= (- cw 0.1) 0)
      0.1
      (- cw 0.1)))

(check-expect (tock 100) 99.9)
(check-expect (tock 0.2) 0.1)
(check-expect (tock 0.1) 0.1)

; WorldState String -> WorldState
; Everytime the down arrow key is pressed, happiness decreased by 1/5;
; every time the up arrow is pressed, happiness jumps by 1/3.
(define (key-ev-handler cw ke)
  (cond
    [(string=? ke "down") (- cw 1/3)]
    [(string=? ke "up") (+ cw 1/5)]
    [else cw]))

; WorldState -> Image
(define (render cw)
  (overlay/xy
   (rectangle cw 19 "solid" "red")
   -1 -1
   (rectangle 102 20 "outline" "black")))

(define (gauge-prog cw)
  (big-bang cw
    [on-tick tock]
    [to-draw render]
    [on-key key-ev-handler]))
      
