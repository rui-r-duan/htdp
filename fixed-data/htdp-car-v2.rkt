;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp-car-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Exercise 42
; Modify the interpretation of the sample data definition so that a state
; denotes the x-coordinate of the right-most edge of the car.

; WorldState: the x-coordinate of the right-most edge of the car.

; Note:
; In v1 of the program, the WorldState represents the car-x which is the
; middle of the car (x-middle).
; place-image determines that the middle of the car is used as the car-x.
;
; Now the WorldState represents the right-most edge of the car (x-right),
; so the car-x (x-middle) needs to be calculated from the WorldState (x-right).
;
; Accordingly end? must be updated.

; WorldState -> X-Coordinate
; calculates the x-coordinate of the car
; The current world state cw is the x-coordinate of the right edge of the car,
; the car's x-coordinate is the x-coordinate of the middle of the car,
; this middle point's x-coordinate is calculated and returned.
; The returned middle point x-coordinate is used as the x value of place-image.
(define (car-x cw)
  (- cw (/ (image-width CAR) 2)))

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
               (car-x cw) CAR-Y
               BACKGROUND))

(check-expect (render 50)
              (place-image CAR (car-x 50) CAR-Y BACKGROUND))
(check-expect (render 100)
              (place-image CAR (car-x 100) CAR-Y BACKGROUND))
(check-expect (render 150)
              (place-image CAR (car-x 150) CAR-Y BACKGROUND))
(check-expect (render 200)
              (place-image CAR (car-x 200) CAR-Y BACKGROUND))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
; If the car moves out of BACKGROUND right border, return #true,
; otherwise return #false.
(define (end? cw)
  (> cw
     (+ WORLD-WIDTH (image-width CAR) DX)))

(check-expect (end? 250)
              (> (- 250 DX (image-width CAR))
                 WORLD-WIDTH))
(check-expect (end? 10)
              (> (- 10 DX (image-width CAR))
                 WORLD-WIDTH))
