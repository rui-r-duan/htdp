;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp-car-v3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Exercise 43
; An AnimationState is a Number.
; interpretation the number of clock ticks since the animation started

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


; AnimationState -> AnimationState
; increase one on the current AnimationState upon every tick
; examples:
;   given: 20, expect 21
;   given: 78, expect 79
(define (tock cw)
  (+ cw 1))

(check-expect (tock 20) 21)
(check-expect (tock 78) 79)

(define CAR-Y (- WORLD-HEIGHT (/ (image-height CAR) 2)))

(define DX 3)
(define HALF-CAR-WIDTH (/ (image-width CAR) 2))
(define INITIAL-CAR-X (- 0 HALF-CAR-WIDTH))
; AnimationState -> X-Coordinate
; calculates the x-coordinate of the car
; The current world state cw is the x-coordinate of the middle the car.
; This x-coordinate will be used as the x value of place-image, so it is
; called car-x.
(define (car-x cw)
  (+ INITIAL-CAR-X (* DX cw)))

(check-expect (car-x 0) INITIAL-CAR-X)
(check-expect (car-x 1) (+ INITIAL-CAR-X DX))
(check-expect (car-x 2) (+ INITIAL-CAR-X (* DX 2)))

; AnimationState -> Image
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

; AnimationState -> AnimationState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))

(define (prev-state cw)
  (- cw 1))

; AnimationState -> Boolean
; after each event, big-bang evaluates (end? cw)
; If the car moves out of BACKGROUND right border, return #true,
; otherwise return #false.
;
; Previous state's car-x is used, because current state has not
; been rendered yet, it is possible that in the current state
; the car is out of the scene, if #true is returned, then it won't
; be rendered, then the scene is stopped with the previous state
; which may leave part of the car in the scene.  So we make sure
; that the previou state's scene does not have the car in it.
(define (end? cw)
  (> (car-x (prev-state cw))
     (+ WORLD-WIDTH HALF-CAR-WIDTH)))

(check-expect (end? 0)
              (> (car-x (prev-state 0))
                 (+ WORLD-WIDTH HALF-CAR-WIDTH)))
(check-expect (end? 96)
              (> (car-x (prev-state 96))
                 (+ WORLD-WIDTH HALF-CAR-WIDTH)))
(check-expect (end? 289)
              (> (car-x (prev-state 289))
                 (+ WORLD-WIDTH HALF-CAR-WIDTH)))