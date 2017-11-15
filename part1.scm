;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part1) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
(define (area-of-disk r)
  (* 22/7 (* r r)))
(define (area-of-ring outer inner)
  (- (area-of-disk outer)
     (area-of-disk inner)))
(+ 2 (* 3 4))
(area-of-disk 3)
(area-of-disk 0)
(area-of-ring 5 3)