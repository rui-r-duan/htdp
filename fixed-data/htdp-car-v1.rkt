;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp-car-v1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 3.6 Designing World Programs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The wish list for designing world programs

; WorldState: data representing the current world (cw)
 
; WorldState -> Image
; when needed, big-bang obtains the image of the current 
; state of the world by evaluating (render cw) 
;(define (render cw) ...)
 
; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next 
; state of the world from (clock-tick-handler cw) 
;(define (clock-tick-handler cw) ...)
 
; WorldState String -> WorldState 
; for each keystroke, big-bang obtains the next state 
; from (keystroke-handler cw ke); ke represents the key
;(define (keystroke-handler cw ke) ...)
 
; WorldState Number Number String -> WorldState 
; for each mouse gesture, big-bang obtains the next state
; from (mouse-event-handler cw x y me) where x and y are
; the coordinates of the event and me is its description 
;(define (mouse-event-handler cw x y me) ...)
 
; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw) 
;(define (end? cw) ...)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Step 1: constants
; Step 1a: "physical" constants
(define WORLD-WIDTH 250)
(define WORLD-HEIGHT 50)

; Exercise 39: single point of control
; Use WHEEL-RADIUS to control the size of the car so that
; CAR can be enlarged or reduced via a single change to a constant
; definition.
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define CAR-TOP-WIDTH (+ WHEEL-DISTANCE (* WHEEL-RADIUS 2)))
(define CAR-TOP-HEIGHT WHEEL-RADIUS)
(define CAR-BODY-WIDTH (* CAR-TOP-WIDTH 2))
(define CAR-BODY-HEIGHT (* WHEEL-RADIUS 2))

; Step 1b: graphical constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "transparent"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR
  (underlay/align/offset "middle" "bottom"
                         (above (rectangle CAR-TOP-WIDTH CAR-TOP-HEIGHT "solid" "red")
                                (rectangle CAR-BODY-WIDTH CAR-BODY-HEIGHT "solid" "red"))
                         0 WHEEL-RADIUS
                         BOTH-WHEELS))

; Exercise 41
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define BACKGROUND
  (place-image TREE
               (- WORLD-WIDTH (* (image-width TREE) 1.5))
               (- WORLD-HEIGHT (/ (image-height TREE) 2))
               (rectangle WORLD-WIDTH WORLD-HEIGHT "solid" "lightyellow")))

(define DX 3)
; WorldState -> WorldState
; moves the car by DX pixels for every clock tick
; examples:
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock cw)
  (+ cw DX))

; Exercise 40: formulate the examples as BSL tests.
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define CAR-Y (- WORLD-HEIGHT (/ (image-height CAR) 2)))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(define (render cw)
  (place-image CAR
               cw CAR-Y
               BACKGROUND))

(check-expect (render 50)
              (place-image CAR 50 CAR-Y BACKGROUND))
(check-expect (render 100)
              (place-image CAR 100 CAR-Y BACKGROUND))
(check-expect (render 150)
              (place-image CAR 150 CAR-Y BACKGROUND))
(check-expect (render 200)
              (place-image CAR 200 CAR-Y BACKGROUND))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))

; Exercise 41
; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
; If the car moves out of BACKGROUND right border, return #true,
; otherwise return #false.
(define (end? cw)
  (> cw
     (+ WORLD-WIDTH (/ (image-width CAR) 2) DX)))

(check-expect (end? 250)
              (> (- 250 DX (/ (image-width CAR) 2))
                 WORLD-WIDTH))
(check-expect (end? 10)
              (> (- 10 DX (/ (image-width CAR) 2))
                 WORLD-WIDTH))
