;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname wage) (read-case-sensitive #t) (teachpacks ((lib "convert.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.ss" "teachpack" "htdp")))))
;; wage : number -> number
;; calculates the wage, given work hours
(define (wage h)
  (* 12 h))

;; tax : number -> number
;; computes the tax, given a wage
(define (tax w)
  (* 0.15 w))

;; netpay : number -> number
;; computes the net pay, given the number of hours worked
(define (netpay h)
  (- (wage h)
     (tax (wage h))))