;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sum-coins) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
;; sum-coins : number number number number -> number
;; computes the value of p pennies, n nickels, d dimes,
;; and q quarters.

;; EXAMPLES
;; 1 penny should be worth 1 penny.
;; 1 nickel should be worth 5 pennies.
;; 1 dime should be worth 10 pennies.
;; 1 quarter should be worth 25 pennies.
;; 1 penny, 1 nickel, 1 dime and 1 quarter should be worth
;;   41 pennies.

(define (sum-coins p n d q)
  (+ (* p 1)
     (* n 5)
     (* d 10)
     (* q 25)))