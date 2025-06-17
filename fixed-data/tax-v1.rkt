;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tax-v1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.6 Designing with Itemizations

; Sample Problem
; Those costing less than $1,000, are not taxed.
; Luxury items, with a price of more than $10,000, are taxed at the rate of
;   eight percent (8.00%).
; Everything in between comes with a five percent (5.00%) markup.

; A Price falls into one of three intervals:
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 1282) (* 0.05 1282))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))

; Exercise 58: introduce constants.
(define LOW 1000)
(define HIGH 10000)
(define MID-RATE 0.05)
(define HIGH-RATE 0.08)

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p LOW)) 0]
    [(and (<= LOW p) (< p HIGH)) (* MID-RATE p)]
    [(>= p HIGH) (* HIGH-RATE p)]))