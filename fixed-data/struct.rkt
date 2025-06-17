;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname struct) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 5 Adding Structure

; posn -> Number
; computes the distance of ap to the origin
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)
(define (distance-to-0 ap)
  (sqrt
   (+ (sqr (posn-x ap))
      (sqr (posn-y ap)))))

; Exercise 63
(distance-to-0 (make-posn 3 4))
(distance-to-0 (make-posn 6 (* 2 4)))
(+ (distance-to-0 (make-posn 12 5)) 10)

; Exercise 64: Manhattan distance
(check-expect (manhattan-distance (make-posn 3 4)) 7)
(define (manhattan-distance ap)
  (+ (posn-x ap) (posn-y ap)))

; Exercise 71
; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(game-ball game0)
(posn? (game-ball game0))
(game-left-player game0)

; Sample Problem: moving a red dot across a 100x100 canvas
; and allow players to use the mouse to reset the dot.

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

; Posn -> Image
; adds a red dot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn -> Posn
; increase the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))

; Exercise 73
(define (posn-up-x p n)
  (make-posn n (posn-y p)))
(check-expect (x+3 (make-posn 10 0)) (make-posn 13 0))
(define (x+3 p)
  (posn-up-x p (+ (posn-x p) 3)))

; Posn Number Number MouseEvt -> Posn
; for mouse clicks, (make-posn x y); otherwise p
(check-expect
 (reset-dot (make-posn 10 20) 29 31 "button-down")
 (make-posn 29 31))
(check-expect
 (reset-dot (make-posn 10 20) 29 31 "button-up")
 (make-posn 10 20))
(define (reset-dot p x y me)
  (cond
    [(mouse=? "button-down" me) (make-posn x y)]
    [else p]))

(define-struct vel [deltax deltay])

; Sample Problem: UFO

(define-struct ufo [loc vel])
; A UFO is a structure: 
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))
(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determines where u moves in one clock tick;
; leaves the velocity as is
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

; Posn Vel -> Posn
; adds v to p
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))

; § 5.7 The Universe of Data

; data definition

; A BS is one of: 
; — "hello",
; — "world", or
; — pi.

; Posn is (make-posn Number Number)

; The data definitions use combinations of natural language,
; data collections defined elsewhere, and data constructors.
; Nothing else should show up in a data definition at the moment.

; Movie is (make-movie String String Number)
(define-struct movie [title producer year])

; Person is (make-person String String String String)
(define-struct person [name hair eyes phone])

; Pet is (make-pet String Number)
(define-struct pet [name number])

; CD is (make-CD String String Number)
(define-struct CD [artist title price])

; Sweater is (make-sweater String Number String)
(define-struct sweater [material size producer])

; Exercise 77: points in time since midnight
; A TimePoint is (make-timepoint Number Number Number)
(define-struct timepoint [hour minute second])

; Exercise 78: three-letter words
; A letter is one of:
; - 1String ("a" to "z")
; - #false
; A Three-Letter-Word is (make-three-letter-word Letter Letter Letter)
(define-struct three-letter-word [a b c])

; A Word is one of:
; - (make-three-letter-word 1String 1String 1String)
; - #false

; Sample Problem: 3-dimensional space distance

(define-struct r3 [x y z])
; An R3 is a structure:
;  (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> Number
; computes the distance of r3 to the origin in the 3-dimensional space
(check-within (r3-distance-to-0 ex1) 13.19 0.1)
(check-within (r3-distance-to-0 ex2) 3.16 0.1)
(define (r3-distance-to-0 p)
  (sqrt
   (+ (sqr (r3-x p))
      (sqr (r3-y p))
      (sqr (r3-z p)))))

; TimePoint -> Number
; given TimePoint t, calculates the number of seconds that have passed
; since midnight
(check-expect (time->seconds (make-timepoint 12 30 2))
              (+ (* 12 60 60) (* 30 60) 2))
(define (time->seconds t)
  (+ (* (timepoint-hour t) 60 60)
     (* (timepoint-minute t) 60)
     (timepoint-second t)))

; Space Invader Game

; A SpaceGame is a structure:
;   (make-space-game Posn Number). 
; interpretation (make-space-game (make-posn ux uy) tx)
; describes a configuration where the UFO is 
; at (ux,uy) and the tank's x-coordinate is tx