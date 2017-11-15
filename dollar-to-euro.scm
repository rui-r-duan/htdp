;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname dollar-to-euro) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
;; dollar->euro : number -> number
;; computes the euro equivalent to the amount of dollars

;; one dollar equals 0.73 euros
;; (source: MSN Money, date: December 8, 2013)
(define (dollar->euro d)
  (* 0.73 d))