;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp-car-v5) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Add mouse-event handler to the car program.

; WorldState is a Number.
; interpretation the x-coordinate of the car (the middle of the car)

(define WORLD-WIDTH 250)
(define WORLD-HEIGHT 50)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define CAR-TOP-WIDTH (+ WHEEL-DISTANCE (* WHEEL-RADIUS 2)))
(define CAR-TOP-HEIGHT WHEEL-RADIUS)
(define CAR-BODY-WIDTH (* CAR-TOP-WIDTH 2))
(define CAR-BODY-HEIGHT (* WHEEL-RADIUS 2))

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

; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
; given: 21 10 20 "enter"
; wanted: 21
; given 42 10 20 "button-down"
; wanted: 10
; given 42 10 20 "move"
; wanted: 42
(define (hyper car-x x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else car-x]))

; Exercise 44: Fomulate the examples as BSL tests.
(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [on-mouse hyper]
    [to-draw render]
    [stop-when end?]))

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
; If the car moves out of BACKGROUND right border, return #true,
; otherwise return #false.
(define HALF-CAR-WIDTH (/ (image-width CAR) 2))
(define (car-left-edge-x xpos)
  (- xpos HALF-CAR-WIDTH))
(define (end? cw)
  (> (car-left-edge-x cw)
     WORLD-WIDTH))

(check-expect (end? 250)
              (> (car-left-edge-x 250)
                 WORLD-WIDTH))
(check-expect (end? 10)
              (> (car-left-edge-x 10)
                 WORLD-WIDTH))
