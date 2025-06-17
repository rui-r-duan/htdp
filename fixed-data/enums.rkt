;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname enums) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.3 Enumerations

; A MouseEvt is one of these Strings:
; – "button-down"
; – "button-up"
; – "drag"
; – "move"
; – "enter"
; – "leave"

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; Exercise 51: traffic light simulation

;;;;;;;;;;;
; Wish list
;;;;;;;;;;;

; WorldState: data representing the current world (cw)

; WorldState -> Image
; when needed, big-bang obtains the image of the current state
; of the world by evaluating (render cw)
; (define (render cw) ...)

; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next state
; of the world by evaluating (clock-tick-handler cw)
; (define (clock-tick-handler cw) ...)
;;;;;;;;;;;

; WorldState is a Number
; the count down timer for the duration of a light state
; It has an initial value, and every tick, it decrease by one.
; When it reaches zero, the traffic light turns to the next state,
; and the count down timer is reset to the initial value, so that
; a new count down for the new light state begins.

; WorldState is TrafficLight
; a color name: "red", "green", or "yellow"

; initial value of the WorldState, duration of a light state
(define DURATION 60)

; WorldState -> WorldState
; count down timer decreases by one for every clock tick
; when it reaches zero, the next state will be the initial value DURATION
;(define (tock cw)
;  (if (= cw 0)
;      DURATION
;      (- cw 1)))

; WorldState -> WorldState
; For every clock tick, change the traffic light state to the next.
(check-expect (tock "red") "green")
(check-expect (tock "green") "yellow")
(check-expect (tock "yellow") "red")
(define (tock cw)
  (traffic-light-next cw))

; WorldState -> Image
; display the traffic light according to the WorldState
(define (render cw)
  (circle 20 "solid" cw))

(define (traffic-light-simulation cw)
  (big-bang cw
    [on-tick tock]
    [to-draw render]))

; Sample Problem: Design a key-event handler that moves
; a red dot left or right on a horizontal line in response
; to pressing the left and right arrow keys.

; A Position is a Number.
; interpretation distance between the left margin and the ball 
 
; Position KeyEvent -> Position
; computes the next location of the ball 
 
(check-expect (keh 13 "left") 8)
(check-expect (keh 13 "right") 18)
(check-expect (keh 13 "a") 13)
(define (keh p k)
  (cond
    [(string=? "left" k) (- p 5)]
    [(string=? "right" k) (+ p 5)]
    [else p]))
