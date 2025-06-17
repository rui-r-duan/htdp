;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname itemizations) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.5 Itemizations

; An NorF is one of:
; - #false
; - a Number

; Sample Problem: Design a program that launches a rocket when the user
; of your program presses the space bar.  The program first displays
; the rocket sitting at the bottom of the canvas.  Once launched, it
; moves upward at three pixels per clock tick.

; An LR (short for launching rocket) is one of:
; - "resting"
; - NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight

; two interpretaions of the notion of height:
; - the word "height" could refer to the distance between the ground and
;   the rocket's point of reference, say, its centre;
; - it could mean the distance between the top of the canvas and the
;   reference point

; Exercise 53: the distance between the top of the canvas and the ref point
; Draw world scenarios.
; example 1: when resting, cw = canvas-height - rocket-height / 2
; example 2: when dy = -3, cw-new = cw + dy

; Sample Problem: Design a program that launches a rocket when the user presses
; the space bar.  At that point, the simulation starts a countdown for three
; ticks, before it displays the scenery of a rising rocket.  The rocket should
; move upward at a rate of three pixels per clock tick.

(define HEIGHT 300) ; distances in pixels 
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
; top of the canvas and the rocket (its height)

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
 (place-image ROCKET 10 (offset HEIGHT) BACKG))
(check-expect
 (show 53)
 (place-image ROCKET 10 (offset 53) BACKG))
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
     (place-image ROCKET 10 (offset y) BACKG)]))

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
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))
(define (fly y)
  (cond
    [(string? y) y]
    [(<= -3 y -1) (if (= y -1) HEIGHT (+ y 1))]
    [(>= y 0) (- y YDELTA)]))

; The key is to cover the space of possible input data with a goodly bunch of
; examples.

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

; Exercise 56: main2 and stop-when

; LRCD -> boolean
; Use #true to stop the big-bang program when the rocket flys out of sight.
; Returns #true if y < 0, returns #false otherwise.
(define (end y)
  (cond
    [(string? y) #false]
    [(<= -3 y -1) #false]
    [(<= 0 y 3) #true]
    [(> y 3) #false]))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-tick fly 1/14]
    [on-key launch]
    [stop-when end]))