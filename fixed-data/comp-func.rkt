;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname comp-func) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 2.3 Composing functions
(define (letter first-name last-name signature-name)
  (string-append
   (opening first-name)
   "\n\n"
   (body first-name last-name)
   "\n\n"
   (closing signature-name)))
 
(define (opening first-name)
  (string-append "Dear " first-name ","))
 
(define (body first-name last-name)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " last-name " have won our lottery. So, " "\n"
   first-name ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(write-file 'stdout (letter "Matt" "Fiss" "Fell"))

; Sample Problem: theater profit
; Exercise 27: refactor: use constants to replace magic numbers
(define Y0 120) ; average attendees when ticket price is X0
(define X0 5.0) ; a ticket price
(define DY 15)  ; delta attendees if price increases DX
(define DX 0.1) ; delta price
(define DY-DX-RATIO (/ DY DX)) ; Exercise 30
(define (attendees ticket-price)
  (- Y0 (* (- ticket-price X0) DY-DX-RATIO)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define FC 180)  ; fixed cost
(define VC 0.04) ; variable cost per attendee
(define (cost ticket-price)
  (+ FC (* VC (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

; Exercise 28: determine the best ticket price to a dime
(define (profit.v1.1 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))
(profit 1)
(profit 2)
(profit 3) ; 1063.2
(profit 4)
(profit 5)
(profit 6)
(profit 2.9) ; 1064.1
(profit 2.8) ; 1062
(profit 3.1) ; 1059.3
; best ticket price: 2.9

; Exercise 29
(define VC2 1.50) ; variable cost per attendee
(define (cost.v2 ticket-price)
  (* VC2 (attendees ticket-price)))

(define (profit.v2 ticket-price)
  (- (revenue ticket-price)
     (cost.v2 ticket-price)))

(profit.v2 3)
(profit.v2 3.6) ; max profit: 693
(profit.v2 4)
(profit.v2 5)