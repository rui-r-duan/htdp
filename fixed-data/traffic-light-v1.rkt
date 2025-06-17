;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light-v1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.7 Finite State Worlds

; data definition

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 

; a signature, a purpose statement, and a stub

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(define (tl-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))

(define CELL-SIZE 30)
(define SCN-WIDTH (* CELL-SIZE 3))
(define SCN-HEIGHT CELL-SIZE)
(define RADIUS 10)

(define POS-Y (/ CELL-SIZE 2))
(define POS-X-RED (/ CELL-SIZE 2))
(define POS-X-YLW (+ POS-X-RED CELL-SIZE))
(define POS-X-GRN (+ POS-X-YLW CELL-SIZE))

(define MTSCN (empty-scene SCN-WIDTH SCN-HEIGHT))

; Color String, (or/c "on" "off") -> Image
; Draw a light according to the name `type` and on or off state.
(define (light type on/off)
  (circle RADIUS
          (cond
            [(string=? "on" on/off) "solid"]
            [(string=? "off" on/off) "outline"])
          type))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red") RED)
(check-expect (tl-render "yellow") YELLOW)
(check-expect (tl-render "green") GREEN)
(define (tl-render cs)
  (cond
    [(string=? "red" cs) RED]
    [(string=? "yellow" cs) YELLOW]
    [(string=? "green" cs) GREEN]))

(define RED
  (place-image (light "red" "on")
               POS-X-RED POS-Y
               (place-image (light "yellow" "off")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "off")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
(define YELLOW
  (place-image (light "red" "off")
               POS-X-RED POS-Y
               (place-image (light "yellow" "on")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "off")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
(define GREEN
  (place-image (light "red" "off")
               POS-X-RED POS-Y
               (place-image (light "yellow" "off")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "on")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
; Exercise 59

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))