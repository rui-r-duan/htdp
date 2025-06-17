;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname launch-rocket-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.5 Itemizations

; Exercise 57: height represents the distance between the ref point and
; the ground.

(define HEIGHT 300)
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; bottom of the canvas and the rocket

; Number -> Number
; offset of the rocket when display
; The input is the position of the rocket in LRCD world which is
;   the coordinate of ROCKET's Y-center.
; The output is the actual display position of the rocket which includes
;   the offset.
(define (offset y)
  (- y CENTER))

; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect
 (show "resting")
 (place-image ROCKET 10 (offset HEIGHT) BACKG))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 10 (offset HEIGHT) BACKG)))
(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (offset 0) BACKG))
(check-expect
 (show 53)
 (place-image ROCKET 10 (offset (- HEIGHT 53)) BACKG))
(define (show y)
  (cond
    [(string? y)
     (place-image ROCKET 10 (offset HEIGHT) BACKG)]
    [(<= -3 y -1)
     (place-image (text (number->string y) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (offset HEIGHT)
                               BACKG))]
    [(>= y 0)
     (place-image ROCKET 10 (offset (- HEIGHT y)) BACKG)]))

; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed,
; if the rocket is still resting
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
(define (launch y ke)
  (cond
    [(string? y) (if (string=? " " ke) -3 y)]
    [(<= -3 y -1) y]
    [(>= y 0) y]))

; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))
(define (fly y)
  (cond
    [(string? y) y]
    [(<= -3 y -1) (if (= y -1) 0 (+ y 1))]
    [(>= y 0) (+ y YDELTA)]))

; The key is to cover the space of possible input data with a goodly bunch of
; examples.


; LRCD -> boolean
; Use #true to stop the big-bang program when the rocket flys out of sight.
; Returns #true if y > HEIGHT, returns #false otherwise.
(define (end y)
  (cond
    [(string? y) #false]
    [(<= -3 y -1) #false]
    [(<= 0 y HEIGHT) #false]
    [(> y HEIGHT) #true]))

; LRCD -> LRCD
(define (main s)
  (big-bang s
    [to-draw show]
    [on-tick fly 1/14]
    [on-key launch]
    [stop-when end]))